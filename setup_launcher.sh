#!/usr/bin/env bash
# Sets up a local virtual environment with all dependencies (CLI + GUI).
set -e

echo "Setting up BunkrDownloader environment..."

if ! command -v python3 &>/dev/null; then
    echo "Python 3 is not installed or not in PATH. Please install Python 3.10+ and try again."
    exit 1
fi

if [ ! -d venv ]; then
    echo "Creating virtual environment..."
    python3 -m venv venv
fi

echo "Activating virtual environment and installing dependencies..."
# shellcheck source=/dev/null
source venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt

echo
echo "Setup completed successfully!"
echo "Run ./launch_cli.sh <url> for the CLI, or ./launch_gui.sh for the GUI."
