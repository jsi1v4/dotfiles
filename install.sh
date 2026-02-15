#!/usr/bin/env sh

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

FORCE=false
BASE_DIR="$(dirname "$0")/src"
HOME_DIR="$HOME"
CONFIG_DIR="$HOME/.config"

show_help () {
cat << EOF
  ----------------------------------------------------
            Jsi1v4 - dotfiles - install
  ----------------------------------------------------
    commands:
      --help,  -h -> show this help;
      --force, -f -> overwrite the files, if exists;
  ----------------------------------------------------
EOF
}

for PARAM in "$@"; do
  case "$PARAM" in
    --help|-h) show_help; exit 0 ;;
    --force|-f) FORCE=true ;;
  esac
done

if [ "$FORCE" = true ]; then
  printf "Force parameter, will overwrite files. Continue? [yes/no]: "
  read CONTINUE
  case "$CONTINUE" in
    yes|y) ;;
    *) exit 0 ;;
  esac
fi

# Percorre todos os arquivos dentro de src (recursivo)
find "$BASE_DIR" -type f | while read -r SRC_FILE; do
  REL_PATH="${SRC_FILE#$BASE_DIR/}"

  case "$REL_PATH" in
    .config/*)
      DEST="$HOME/$REL_PATH"
      ;;
    *)
      DEST="$HOME/$REL_PATH"
      ;;
  esac

  DEST_DIR="$(dirname "$DEST")"

  if [ -e "$DEST" ] && [ "$FORCE" != true ]; then
    printf "%s: ${RED}File exists${NC}\n" "$DEST"
    continue
  fi

  if [ -e "$DEST" ] && diff -q "$SRC_FILE" "$DEST" >/dev/null 2>&1; then
    printf "%s: ${RED}Same file${NC}\n" "$DEST"
    continue
  fi

  mkdir -p "$DEST_DIR"
  cp -f "$SRC_FILE" "$DEST"

  printf "%s: ${GREEN}Success${NC}\n" "$DEST"
done
