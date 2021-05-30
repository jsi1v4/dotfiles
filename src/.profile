## start xinit config
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi

## configs
export LANG="en_US.UTF-8"
export EDITOR="micro"
export PATH="${PATH}:/opt/vscode/bin"
#export ARCHFLAGS="-arch x86_64"

## alias
alias la="ls -la"
