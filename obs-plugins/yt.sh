#!/bin/bash

# Color codes
GREEN="\033[1;32m"
RED="\033[1;31m"
NC="\033[0m" # No color

echo -e "${GREEN}🔽 YouTube 1080p Video Downloader (MP4) for Linux${NC}"

# Check yt-dlp
if ! command -v yt-dlp &> /dev/null
then
    echo -e "${RED}yt-dlp not found. Installing...${NC}"
    pip3 install --user yt-dlp
fi

# Check ffmpeg
if ! command -v ffmpeg &> /dev/null
then
    echo -e "${RED}ffmpeg not found. Installing...${NC}"
    sudo apt update
    sudo apt install -y ffmpeg
fi

# Add yt-dlp to PATH if needed
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# Ask for URL
read -p "Enter YouTube video URL: " URL

# Destination folder
DEST="$HOME/Downloads"

echo -e "${GREEN}Downloading to $DEST ...${NC}"

yt-dlp -f "bestvideo[height<=1080][ext=mp4]+bestaudio[ext=m4a]/best[height<=1080][ext=mp4]" \
-o "$DEST/%(title)s.%(ext)s" "$URL"

echo -e "${GREEN}✅ Download complete. Check your Downloads folder.${NC}"
