#!/usr/bin/env bash
# Builds standalone Linux binaries (CLI + GUI) with PyInstaller.
set -e

echo "Building BunkrDownloader Linux binaries..."

if [ ! -d venv ]; then
    echo "Virtual environment not found. Running setup_launcher.sh..."
    ./setup_launcher.sh
fi

# shellcheck source=/dev/null
source venv/bin/activate

echo "Installing PyInstaller..."
pip install --upgrade pyinstaller

echo
echo "Building CLI binary..."
pyinstaller --onefile --name bunkrdownloader-cli --noconfirm downloader.py

echo
echo "Building GUI binary..."
pyinstaller --onefile --name bunkrdownloader-gui --noconfirm \
    --add-data "misc/gui/icons/icon.ico:misc/gui/icons" \
    --add-data "misc/gui/icons/icon.png:misc/gui/icons" \
    gui.py

echo
echo "Build successful!"
echo "Binaries are available in the 'dist' folder:"
echo "  dist/bunkrdownloader-cli"
echo "  dist/bunkrdownloader-gui"
echo
echo "Note: the GUI binary still needs, at runtime on the target machine:"
echo "  - Tk libraries (usually already present; if not, install your distro's"
echo "    'tk' / 'python3-tk' system package)"
echo "  - xdg-utils (for the \"Open folder\" button)"
echo "  - a terminal emulator such as xterm/gnome-terminal/konsole (only needed"
echo "    for the optional \"detailed CLI window\" setting)"
