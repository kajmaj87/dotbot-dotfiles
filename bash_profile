#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc
if [ -e /home/kajman/.nix-profile/etc/profile.d/nix.sh ]; then . /home/kajman/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
