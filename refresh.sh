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

for FOLDER in $FOLDERS; do
  SUB_FILES=$(ls -Ap $BASE_DIR$FOLDER)
  for FILE in $SUB_FILES; do
    DIFF=$(diff $CONFIG_DIR$FOLDER$FILE $BASE_DIR$FOLDER$FILE)
    if [ -n "$DIFF" ]; then
      cp -f $CONFIG_DIR$FOLDER$FILE $BASE_DIR$FOLDER$FILE
      echo -e "${BASE_DIR}${FOLDER}${FILE}: ${GREEN}Updated${NC}"
    else
      echo -e "${BASE_DIR}${FOLDER}${FILE}: ${RED}Same file${NC}"
    fi
  done
done

for FILE in $FILES; do
  DIFF=$(diff $HOME_DIR$FILE $BASE_DIR$FILE)
  if [ -n "$DIFF" ]; then
    cp -f $HOME_DIR$FILE $BASE_DIR$FILE
    echo -e "${BASE_DIR}${FILE}: ${GREEN}Updated${NC}"
  else
    echo -e "${BASE_DIR}${FILE}: ${RED}Same file${NC}"
  fi
done
