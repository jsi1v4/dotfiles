## start xinit config
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx
fi

## configs
export LANG="en_US.UTF-8"
export EDITOR="micro"
export ARCHFLAGS="-arch x86_64"

## path
export PATH="${PATH}"

## alias
alias la="ls -la"
alias ll="ls -l"
alias pacsave="pacman -Qeq > $HOME/.my-packages"
