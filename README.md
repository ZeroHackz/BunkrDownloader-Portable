# Bunkr Downloader Portable GUI

This project is a fork of the original [BunkrDownloader by Lysagxra](https://github.com/Lysagxra/BunkrDownloader). Huge thanks to her for creating and maintaining the powerful core of this application!

This version focuses on providing an user-friendly **Graphical User Interface (GUI)** and includes other features to make downloading as simple as possible. It was originally built for Windows, and now also runs — CLI and GUI — on **Linux** (see the [Linux section](#-linux-usage) below).

### Screenshots
*Download tab: paste a URL or load a batch file, watch live progress in the log.*

![Download tab](screenshots/screenshot-download-tab.png)

*Settings tab: save folder, concurrent downloads, retries, filters, and advanced toggles.*

![Settings tab](screenshots/screenshot-settings-tab.png)

## ✨ Features

This fork includes all the powerful core features from the original, plus:

*   **Dual Download Modes:** Easily switch between downloading a single URL or batch downloading from a `.txt` file using a simple toggle.
*   **Graphical User Interface (GUI):** A simple and intuitive interface for downloading. No command line needed!
*   **Portable Executable:** Download and run the application directly without needing to install Python or any dependencies (Windows `.exe`, Linux binary).
*   **Easy URL Pasting:** A convenient "Paste" button to quickly insert a Bunkr URL from your clipboard.
*   **File Browser:** A "Browse" button to easily select your URL list file when in "Batch from file" mode.
*   **Settings Tab:** Tweak the save folder, max concurrent downloads, retries, and include/exclude filters without touching the command line.
*   **Stop Button:** Cancel a batch mid-run — the current URL finishes, the rest are skipped.
*   **Detailed CLI Window (optional):** Toggle in Settings to spawn each download in its own console for the full Rich progress bars.
*   **Automatic Folder Opening:** Once your download is complete, the folder containing the files will automatically open.
*   **Build & Setup Scripts:** Comes with `.bat` scripts for Windows and `.sh` scripts for Linux/macOS to easily set up the environment and build the executable from source.

### Core Features

- Downloads multiple files from an album concurrently.
- Supports batch downloading via a list of URLs.
- Supports selective file downloading based on filename criteria.
- Provides progress indication during downloads.
- Automatically creates a directory structure for organized storage.
- Logs URLs that encounter errors for troubleshooting.

## 💻 How to Use (Easy Way)

1.  Go to the [**Releases**](https://github.com/ZeroHackz/BunkrDownloader-Portable/releases) page.
2.  Download the latest `BunkrDownloader-portable-GUI.exe` file.
3.  Run the application.
4.  **Choose your download mode:**
    *   **For a single link:** Leave it on "Single URL", paste your Bunkr URL, and click **Download**.
    *   **For multiple links:** Select "Batch from file", click **Browse** to select your `.txt` file, and then click **Download**.
5.  That's it!

## 🛠️ For Developers (Building from Source)

If you want to build the application yourself:

1.  Clone this repository:
    ```bash
    git clone https://github.com/ZeroHackz/BunkrDownloader-Portable.git
    ```
2.  Navigate to the project directory:
    ```bash
    cd BunkrDownloader-Portable
    ```
3.  Run the setup script. This will create a virtual environment and install the required dependencies.
    ```bat
    setup_launcher.bat
    ```
4.  To build the executable, run the build script:
    ```bat
    build.bat
    ```
    The `.exe` will be available in the `dist` folder.

## 🐧 Linux Usage

Both the CLI and the GUI run natively on Linux (and should work the same way on macOS).

### System dependencies

The core CLI has no OS-specific dependencies beyond Python 3.10+. The GUI additionally needs:

*   **Tk** — usually already installed alongside Python; if `python3 -c "import tkinter"` fails, install your distro's Tk package (e.g. `sudo apt install python3-tk` on Debian/Ubuntu, `sudo dnf install python3-tkinter` on Fedora).
*   **xdg-utils** — used by the "Open folder" button (`xdg-open`); installed by default on most desktop distros.
*   **A terminal emulator** (`xterm`, `gnome-terminal`, `konsole`, or `xfce4-terminal`) — only needed for the optional "detailed CLI window" setting; the GUI falls back to running without a detached console if none is found.

### Running from source

```bash
git clone https://github.com/ZeroHackz/BunkrDownloader-Portable.git
cd BunkrDownloader-Portable

./setup_launcher.sh     # creates venv/ and installs dependencies
./launch_cli.sh <url>   # run the CLI (prompts for a URL if omitted)
./launch_gui.sh         # run the GUI
```

### Building standalone Linux binaries

```bash
./build.sh
```

This produces two self-contained, dependency-free binaries in `dist/`:

*   `dist/bunkrdownloader-cli` — the command-line downloader
*   `dist/bunkrdownloader-gui` — the graphical interface

Both are single-file PyInstaller builds; no Python installation is required to run them on another Linux machine (same architecture, glibc-compatible).

## CLI Usage

The original command-line interface is still available and fully functional.

### Single Download

```bash
python downloader.py <bunkr_url>      # Windows
python3 downloader.py <bunkr_url>     # Linux/macOS
```

### Selective & Batch Downloads

All the original flags like `--ignore`, `--include`, and batch downloading via `URLs.txt` are still supported, along with `--custom-path`, `--no-download-folder`, `--no-album-folder`, `--clean-name`, `--max-retries`, `--connections`, `--rate-limit`, `--dry-run`, `--disable-disk-check`, and `--version`.
 
For more details, please refer to the [Lysagxra README](https://github.com/Lysagxra/BunkrDownloader/blob/main/README.md).

## Logging

The application logs any issues encountered during the download process in a file named `session.log`. Check this file for any URLs that may have been blocked or had errors.
