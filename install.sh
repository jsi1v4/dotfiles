#!/bin/sh

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

FORCE=false
BASE_DIR=$(dirname "$0")/src/
FOLDERS=$(ls -Ap $BASE_DIR | grep /)
FILES=$(ls -Ap $BASE_DIR | grep -v /)

HOME_DIR=$HOME/
CONFIG_DIR=$HOME/.config/

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

for PARAM in $*; do
  if [ "$PARAM" == "--help" -o "$PARAM" == "-h" ]; then
    show_help
    exit
  fi
  if [ "$PARAM" == "--force" -o "$PARAM" == "-f" ]; then
    FORCE=true
  fi
done

if [ $FORCE == true ]; then
  read -p "Force parameter, will overwrite the files. Do you really want to continue? [yes, no]: " CONTINUE
  if [ "$CONTINUE" != "yes" -a "$CONTINUE" != "y" ]; then
    exit
  fi
fi

for FOLDER in $FOLDERS; do
  SUB_FILES=$(ls -Ap $BASE_DIR$FOLDER)
  for FILE in $SUB_FILES; do
    if [ ! -e $CONFIG_DIR$FOLDER$FILE -o $FORCE == true ]; then
      DIFF=$(diff $BASE_DIR$FOLDER$FILE $CONFIG_DIR$FOLDER$FILE)
      if [ -n "$DIFF" ]; then
        cp -f $BASE_DIR$FOLDER$FILE $CONFIG_DIR$FOLDER$FILE
        echo -e "${CONFIG_DIR}${FOLDER}${FILE}: ${GREEN}Success${NC}"
      else
        echo -e "${CONFIG_DIR}${FOLDER}${FILE}: ${RED}Same file${NC}"
      fi
    else
      echo -e "${CONFIG_DIR}${FOLDER}${FILE}: ${RED}File exists${NC}"
    fi
  done
done

for FILE in $FILES; do
  if [ ! -e $HOME_DIR$FILE -o $FORCE == true ]; then
    DIFF=$(diff $BASE_DIR$FILE $HOME_DIR$FILE)
    if [ -n "$DIFF" ]; then
      cp -f $BASE_DIR$FILE $HOME_DIR$FILE
      echo -e "${HOME_DIR}${FILE}: ${GREEN}Success${NC}"
    else
      echo -e "${HOME_DIR}${FILE}: ${RED}Same file${NC}"
    fi
  else
    echo -e "${HOME_DIR}${FILE}: ${RED}File exists${NC}"
  fi
done
