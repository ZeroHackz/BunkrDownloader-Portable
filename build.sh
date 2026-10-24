#!/usr/bin/env bash
# Builds a portable Linux AppImage (GUI + CLI) with PyInstaller + appimagetool.
set -e

APP_NAME="BunkrDownloader"
ARCH="$(uname -m)"
APPDIR="build/AppDir"
TOOLS_DIR="build/tools"
APPIMAGETOOL="$TOOLS_DIR/appimagetool-$ARCH.AppImage"
APPIMAGETOOL_URL="https://github.com/AppImage/appimagetool/releases/download/continuous/appimagetool-$ARCH.AppImage"
OUTPUT="dist/$APP_NAME-$ARCH.AppImage"

echo "Building $APP_NAME AppImage..."

if [ ! -d venv ]; then
    echo "Virtual environment not found. Running setup_launcher.sh..."
    ./setup_launcher.sh
fi

# shellcheck source=/dev/null
source venv/bin/activate

echo "Installing PyInstaller..."
pip install --upgrade pyinstaller

echo
echo "Building application bundle..."
# --onedir rather than --onefile: the AppImage is already a single file, so a
# onefile build would only add a second extraction step on every launch.
pyinstaller --onedir --name "$APP_NAME" --noconfirm \
    --add-data "misc/gui/icons/icon.ico:misc/gui/icons" \
    --add-data "misc/gui/icons/icon.png:misc/gui/icons" \
    gui.py

echo
echo "Assembling AppDir..."
rm -rf "$APPDIR"
mkdir -p "$APPDIR/usr/bin"
cp -a "dist/$APP_NAME/." "$APPDIR/usr/bin/"
cp misc/gui/icons/icon.png "$APPDIR/bunkrdownloader.png"

cat > "$APPDIR/bunkrdownloader.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=Bunkr Downloader
Comment=Download albums and files from Bunkr
Exec=$APP_NAME
Icon=bunkrdownloader
Categories=Network;FileTransfer;
Terminal=false
EOF

cat > "$APPDIR/AppRun" <<EOF
#!/bin/sh
HERE="\$(dirname "\$(readlink -f "\$0")")"
# GUI launches (no arguments) run from the folder holding the .AppImage, so
# ./Downloads and settings.json end up next to it, like the portable .exe.
# CLI usage (--cli <url>) keeps the caller's working directory.
if [ "\$#" -eq 0 ] && [ -n "\$APPIMAGE" ]; then
    cd "\$(dirname "\$APPIMAGE")" || exit 1
fi
exec "\$HERE/usr/bin/$APP_NAME" "\$@"
EOF
chmod +x "$APPDIR/AppRun"

if [ ! -x "$APPIMAGETOOL" ]; then
    echo
    echo "Downloading appimagetool..."
    mkdir -p "$TOOLS_DIR"
    curl -fL -o "$APPIMAGETOOL" "$APPIMAGETOOL_URL"
    chmod +x "$APPIMAGETOOL"
fi

echo
echo "Packing AppImage..."
# Extract-and-run so building doesn't require FUSE on the build machine.
ARCH="$ARCH" APPIMAGE_EXTRACT_AND_RUN=1 "$APPIMAGETOOL" "$APPDIR" "$OUTPUT"

echo
echo "Build successful!"
echo "AppImage: $OUTPUT"
echo "  GUI: ./$APP_NAME-$ARCH.AppImage"
echo "  CLI: ./$APP_NAME-$ARCH.AppImage --cli <bunkr_url>"
echo
echo "Note: the AppImage runs on distros with the same or a newer glibc than the"
echo "build machine. At runtime it also uses:"
echo "  - xdg-utils (for the \"Open folder\" button)"
echo "  - a terminal emulator such as xterm/gnome-terminal/konsole (only needed"
echo "    for the optional \"detailed CLI window\" setting)"
