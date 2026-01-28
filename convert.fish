#!/usr/bin/fish
# 
# JXL-Pure: Ultra-Fast Lossless JPEG XL Batch Tool
# Copyright (c) 2026 void0x14
# Licensed under the MIT License. See LICENSE file in the project root for full license information.
#
# Version: 2.2 (English/Universal Edition)

set target_dir "."
set delete_originals false

set effort 7
set next_is_effort false

function show_help
    echo (set_color cyan)"JXL-Pure: Ultra-Fast Lossless JPEG XL Batch Tool"(set_color normal)
    echo "Usage: ./convert.fish [TARGET_DIRECTORY] [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -h, --help              Show this help message"
    echo "  --delete-originals      Delete original files after successful conversion"
    echo "  --effort [1-9]          Set encoding effort (Default: 7)"
    echo "                          1: Lightning fast, slightly larger files"
    echo "                          7: Squirrel (Great balance)"
    echo "                          9: Tortoise (Best compression, very slow)"
    echo ""
    echo "Example:"
    echo "  ./convert.fish /path/to/photos --delete-originals --effort 3"
    exit 0
end

# Argument Parsing
for arg in $argv
    if test "$next_is_effort" = true
        if string match -qr '^[1-9]$' "$arg"
            set effort "$arg"
            set next_is_effort false
            continue
        else
            set_color red; echo "Error: Effort must be between 1 and 9."; set_color normal; exit 1
        end
    end

    switch $arg
        case "-h" "--help"
            show_help
        case "--delete-originals"
            set delete_originals true
        case "--effort"
            set next_is_effort true
        case "*"
            if test -d "$arg"
                set target_dir (realpath "$arg")
            end
    end
end

if not test -d "$target_dir"
    set_color red; echo "Error: '$target_dir' is not a valid directory."; set_color normal; exit 1
end

# Check Dependencies
for cmd in fd cjxl
    if not command -v $cmd > /dev/null
        set_color red; echo "Error: $cmd is not installed."; set_color normal; exit 1
    end
end

begin
    set_color cyan
    echo ">>> Target Directory: $target_dir"
    echo ">>> Searching for images... (This might take a moment on slow HDDs)"
    set_color normal

    set -l current 0

    if test "$delete_originals" = true
        set_color red; echo ">>> WARNING: Original files will be DELETED after successful conversion!"; set_color normal
    end

    # Use --hidden and --no-ignore to ensure no files are missed
    fd --type file --extension jpg --extension jpeg --extension png --print0 --hidden --no-ignore . "$target_dir" | while read -lz file
        set current (math $current + 1)
        set input $file
        set -l output (string replace -r '\.[^.]+$' '' $file).jxl

        # Resumable + Deletion Logic
        if test -f "$output"
            if test "$delete_originals" = true; and test -f "$input"
                echo (set_color blue)"[#$current]"(set_color normal)" Output already exists. Deleting original: "(set_color yellow)(basename "$file")(set_color normal)
                rm -f "$input"
            else
                echo (set_color blue)"[#$current]"(set_color normal)" Skipping (Already exists): "(set_color yellow)(basename "$file")(set_color normal)
            end
            continue
        end

        echo -n (set_color blue)"[#$current]"(set_color normal)" Processing: "(set_color yellow)(basename "$file")(set_color normal)" ... "
        
        set -l cjxl_flags -d 0 -e $effort --quiet
        if string match -ri '\.jpe?g$' "$input" > /dev/null
            set cjxl_flags --lossless_jpeg=1 $cjxl_flags
        end

        if cjxl "$input" "$output" $cjxl_flags
            set_color green; echo "DONE"
            if test "$delete_originals" = true
                rm -f "$input"
            end
        else
            set_color red; echo "FAILED"
        end
    end

    set_color cyan; echo ">>> BATCH PROCESS COMPLETED!"; set_color normal
end
