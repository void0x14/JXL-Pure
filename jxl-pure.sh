#!/bin/bash
# 
# JXL-Pure: Ultra-Fast Lossless JPEG XL Batch Tool
# Copyright (c) 2026 void0x14
# Licensed under the MIT License. See LICENSE file in the project root for full license information.
#
# Version: 2.2 (English/Universal Edition)

TARGET_DIR="."
DELETE_ORIGINALS=false
EFFORT=7

show_help() {
    echo -e "JXL-Pure: Ultra-Fast Lossless JPEG XL Batch Tool"
    echo -e "Usage: ./jxl-pure.sh [TARGET_DIRECTORY] [OPTIONS]"
    echo -e ""
    echo -e "Options:"
    echo -e "  -h, --help              Show this help message"
    echo -e "  --delete-originals      Delete original files after successful conversion"
    echo -e "  --effort [1-9]          Set encoding effort (Default: 7)"
    echo -e "                          1: Lightning fast, slightly larger files"
    echo -e "                          7: Squirrel (Great balance)"
    echo -e "                          9: Tortoise (Best compression, very slow)"
    echo -e ""
    echo -e "Example:"
    echo -e "  ./jxl-pure.sh /path/to/photos --delete-originals --effort 3"
    exit 0
}

# Argument Parsing
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            show_help
            ;;
        --delete-originals)
            DELETE_ORIGINALS=true
            shift
            ;;
        --effort)
            if [[ "$2" =~ ^[1-9]$ ]]; then
                EFFORT=$2
                shift 2
            else
                echo -e "\e[31mError: Effort must be between 1 and 9.\e[0m"
                exit 1
            fi
            ;;
        *)
            if [[ -d "$1" ]]; then
                TARGET_DIR=$(realpath "$1")
            fi
            shift
            ;;
    esac
done

if [[ ! -d "$TARGET_DIR" ]]; then
    echo -e "\e[31mError: '$TARGET_DIR' is not a valid directory.\e[0m"
    exit 1
fi

# Check Dependencies
for cmd in fd cjxl; do
    if ! command -v "$cmd" &>/dev/null; then
        echo -e "\e[31mError: '$cmd' is not installed.\e[0m"
        exit 1
    fi
done

echo -e "\e[36m>>> Target: $TARGET_DIR | Effort: $EFFORT\e[0m"
echo -e "\e[36m>>> Searching for images... (Large HDDs may take a moment to start)\033[0m"

CURRENT=0

if [ "$DELETE_ORIGINALS" = true ]; then
    echo -e "\e[31m>>> WARNING: Original files will be DELETED after successful conversion!\e[0m"
fi

# Use --hidden and --no-ignore to ensure maximum discovery
fd --type file --extension jpg --extension jpeg --extension png --print0 --hidden --no-ignore . "$TARGET_DIR" | while read -r -d '' file; do
    ((CURRENT++))
    input="$file"
    output="${file%.*}.jxl"

    # Resumable + Deletion Logic
    if [[ -f "$output" ]]; then
        if [ "$DELETE_ORIGINALS" = true ] && [[ -f "$input" ]]; then
            echo -e "\e[34m[#$CURRENT]\e[0m Output already exists. Deleting original: \e[33m$(basename "$file")\e[0m"
            rm -f "$input"
        else
            echo -e "\e[34m[#$CURRENT]\e[0m Skipping (Already exists): \e[33m$(basename "$file")\e[0m"
        fi
        continue
    fi

    echo -ne "\e[34m[#$CURRENT]\e[0m Processing: \e[33m$(basename "$file")\e[0m ... "

    if [[ "$input" =~ \.(jpg|jpeg|JPG|JPEG)$ ]]; then
        CJXL_FLAGS=(--lossless_jpeg=1 -d 0 -e "$EFFORT" --quiet)
    else
        CJXL_FLAGS=(-d 0 -e "$EFFORT" --quiet)
    fi

    if cjxl "$input" "$output" "${CJXL_FLAGS[@]}"; then
        echo -e "\e[32mDONE\e[0m"
        if [ "$DELETE_ORIGINALS" = true ]; then
            rm -f "$input"
        fi
    else
        echo -e "\e[31mFAILED\e[0m"
    fi
done

echo -e "\e[36m>>> BATCH PROCESS COMPLETED!\e[0m"
