#!/usr/bin/env python3
import argparse
import os
import re
import time
import subprocess
from urllib.request import urlopen  # Add this import at the top of the file
from urllib.error import HTTPError, URLError  # Handle exceptions

BASE_URL = "http://pm.service.patronas.com"
DATA_DIR = os.environ.get('HOME') + "/tmp/data/kb"
DELAY_MS = 500  # Delay in milliseconds

# Function to fetch page content from a URL with delay and output using urllib
def fetch_page_content_with_delay(url):
    try:
        print(f"Fetching {url} ...")
        response = urlopen(url)
        if response.status == 200:
            # Adding a delay before returning the content
            time.sleep(DELAY_MS / 1000.0)
            print(f"Successfully fetched {url}")
            return response.read().decode('utf-8')
        else:
            print(f"Failed to fetch {url}")
            return None
    except (HTTPError, URLError) as e:
        print(f"Failed to fetch {url}: {e}")
        return None
# Function to save content to a file
def save_to_file(filename, content):
    with open(filename, 'w') as f:
        f.write(content)

# Function to read content from a file
def read_from_file(filename):
    with open(filename, 'r') as f:
        return f.read()

# Create directory if it doesn't exist
def ensure_directory_exists(directory):
    if not os.path.exists(directory):
        os.makedirs(directory)

# Function to extract system info
def extract_system_info(html_content):
    regex_pattern = r'<td.*?><a href="(/system/\d+)">([\w-]+)</a></td>'
    matches = re.findall(regex_pattern, html_content)
    system_dict = {}
    for match in matches:
        system_path, system_name = match
        system_dict[system_name] = system_path
    return system_dict

# Function to extract Kibana links
def extract_kibana_links(html_content):
    table_regex_pattern = r'<h2>Systems</h2>.*?<table.*?>(.*?)</table>'
    table_match = re.search(table_regex_pattern, html_content, re.DOTALL)
    if not table_match:
        return None
    table_html = table_match.group(1)
    row_regex_pattern = r'<tr.*?>.*?<td.*?>(.*?)</td>.*?<a href="(http://kibana[^"]+)">Kibana</a>.*?</tr>'
    row_matches = re.findall(row_regex_pattern, table_html, re.DOTALL)
    kibana_dict = {}
    for match in row_matches:
        system_name, kibana_link = match
     # Regex pattern to find and replace the refresh interval part of the URL
        refresh_interval_pattern = r'refreshInterval:\(pause:!t,value:0\)'
        new_refresh_interval = 'refreshInterval:(pause:!f,value:5000)'
        modified_link = re.sub(refresh_interval_pattern, new_refresh_interval, kibana_link)
        kibana_dict[system_name] = modified_link
    return kibana_dict

# Main crawling function
def crawl_and_extract():
    final_data = []
    ensure_directory_exists(f"{DATA_DIR}")
    base_filename = f"{DATA_DIR}/base.html"
    if not os.path.exists(base_filename):
        base_content = fetch_page_content_with_delay(BASE_URL)
        if base_content is None:
            return
        save_to_file(base_filename, base_content)
    base_content = read_from_file(base_filename)
    system_info = extract_system_info(base_content)
    for env, system_path in system_info.items():
        subpage_filename = f"{DATA_DIR}/{env}.html"
        if not os.path.exists(subpage_filename):
            subpage_url = f"{BASE_URL}{system_path}"
            subpage_content = fetch_page_content_with_delay(subpage_url)
            if subpage_content is None:
                continue
            save_to_file(subpage_filename, subpage_content)
        subpage_content = read_from_file(subpage_filename)
        kibana_links = extract_kibana_links(subpage_content)
        if kibana_links is None:
            continue
        for service, kibana_link in kibana_links.items():
            final_data.append((env, service, kibana_link))
    return final_data

def interact_with_fzf_and_xdg_open(final_data, initial_input=None):
    # Prepare the data for fzf
    fzf_data = [f"{env} {service}" for env, service, _ in final_data]
    fzf_input = "\n".join(fzf_data)
    # If initial input is provided, pass it to fzf
    # Create a temporary file to store the fzf input data
    with open(f"{DATA_DIR}/fzf_input.txt", "w") as f:
        f.write(fzf_input)

    # Run fzf using os.system
    if initial_input is not None:
        selected = os.system(f'cat {DATA_DIR}/fzf_input.txt | fzf --query "{initial_input}"> {DATA_DIR}/fzf_output.txt')
    else:
        selected = os.system(f'cat {DATA_DIR}/fzf_input.txt | fzf > {DATA_DIR}/fzf_output.txt')
    
    # Read the output from the temporary file
    with open(f"{DATA_DIR}/fzf_output.txt", "r") as f:
        selected = f.read().strip()

    # Find the matching entry in final_data
    for env, service, kibana_link in final_data:
        if selected == f"{env} {service}":
            # Open the kibana link using xdg-open
            subprocess.run(["xdg-open", kibana_link])
            return

def delete_all_files():
    # Check if the directory exists
    if not os.path.exists(DATA_DIR):
        print(f"The directory {DATA_DIR} does not exist.")
        return
    # Gather full paths of all files in the directory
    full_paths = [os.path.join(DATA_DIR, filename) for filename in os.listdir(DATA_DIR)]
    if not full_paths:
        print("No files found to delete.")
        return
    # Show full paths to the user
    print("The following files will be deleted:")
    for full_path in full_paths:
        print(f"{full_path}")
    # Ask for user confirmation
    user_input = input("Do you want to proceed? (y/n): ").strip().lower()
    if user_input == 'y':
        # Delete each file
        for full_path in full_paths:
            try:
                if os.path.isfile(full_path):
                    os.unlink(full_path)
                    print(f"Deleted: {full_path}")
                elif os.path.isdir(full_path):
                    print(f"Skipping directory: {full_path}")
            except Exception as e:
                print(f"Failed to delete {full_path}. Reason: {e}")
    else:
        print("File deletion cancelled.")

# Function to set up argparse and return the parsed arguments
def parse_arguments():
    parser = argparse.ArgumentParser(description='Open kibana links quickly using fzf')
    parser.add_argument('initial', nargs='*', type=str, help='Initial input for fzf')
    parser.add_argument('--refresh', action='store_true', help=f'Refresh all files before running. This will delete all files under {DATA_DIR}')
    return parser.parse_args()

# In your main function or script entry point
if __name__ == "__main__":
    args = parse_arguments()
    if args.refresh:
        # Delete all files in the directory (implement your own function for this)
        delete_all_files()

    initial_input = " ".join(args.initial) if args.initial else None
    final_data = crawl_and_extract()
    interact_with_fzf_and_xdg_open(final_data, initial_input=initial_input)
