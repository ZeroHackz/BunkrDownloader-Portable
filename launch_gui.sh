#!/usr/bin/env bash
# Launches the graphical interface. Requires a Tk-enabled Python (install your
# distro's "python3-tk" package if you see "No module named 'tkinter'").
set -e

if [ ! -d venv ]; then
    echo "Virtual environment not found. Running setup_launcher.sh..."
    ./setup_launcher.sh
fi

# shellcheck source=/dev/null
source venv/bin/activate
python3 gui.py
