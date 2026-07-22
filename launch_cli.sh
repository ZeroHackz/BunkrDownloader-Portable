#!/usr/bin/env bash
# Launches the CLI downloader, prompting for a URL if none is given as an argument.
set -e

echo "Launching BunkrDownloader..."

if [ ! -d venv ]; then
    echo "Virtual environment not found. Running setup_launcher.sh..."
    ./setup_launcher.sh
fi

# shellcheck source=/dev/null
source venv/bin/activate

if [ -z "$1" ]; then
    read -rp "Enter a Bunkr URL to download: " BUNKR_URL
else
    BUNKR_URL="$1"
    shift
fi

if [ -z "$BUNKR_URL" ]; then
    echo "No URL provided. Exiting..."
    exit 1
fi

echo "Processing URL: $BUNKR_URL"
echo
python3 downloader.py "$BUNKR_URL" "$@"
