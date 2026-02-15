#!/bin/sh

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

BASE_DIR="$(dirname "$0")/src"
HOME_DIR="$HOME"
CONFIG_DIR="$HOME/.config"

# Percorre todos os arquivos dentro de src recursivamente
find "$BASE_DIR" -type f | while read -r BASE_FILE; do
    
    # Caminho relativo dentro de src
    REL_PATH="${BASE_FILE#$BASE_DIR/}"
    
    # Decide origem dependendo se está dentro de .config ou HOME
    if echo "$REL_PATH" | grep -q "/"; then
        SRC_FILE="$CONFIG_DIR/$REL_PATH"
    else
        SRC_FILE="$HOME_DIR/$REL_PATH"
    fi

    # Se arquivo existir na origem
    if [ -f "$SRC_FILE" ]; then
        
        if ! diff -q "$SRC_FILE" "$BASE_FILE" >/dev/null 2>&1; then
            cp -f "$SRC_FILE" "$BASE_FILE"
            printf "%s: ${GREEN}Updated${NC}\n" "$BASE_FILE"
        else
            printf "%s: ${RED}Same file${NC}\n" "$BASE_FILE"
        fi

    else
        printf "%s: ${RED}Source missing${NC}\n" "$SRC_FILE"
    fi

done
