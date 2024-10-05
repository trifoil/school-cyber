#!/bin/bash

# Directory where the .uwu files are stored (you can adjust this)
CONFIG_DIR="./"

# Serial port (adjust if needed)
SERIAL_PORT="/dev/ttyUSB0"
BAUD_RATE=9600

# Ensure proper permissions to access the serial port
stty -F $SERIAL_PORT $BAUD_RATE cs8 -cstopb -parenb

# Find all .uwu files in the directory
uwu_files=($(find $CONFIG_DIR -maxdepth 1 -name "*.uwu"))

# Check if any .uwu files exist
if [ ${#uwu_files[@]} -eq 0 ]; then
    echo "No .uwu files found in the directory."
    exit 1
fi

# Display the available .uwu files
echo "Available configuration files:"
for i in "${!uwu_files[@]}"; do
    echo "$i) ${uwu_files[$i]}"
done

# Prompt the user to select a file by index
read -p "Enter the number of the configuration file to load: " file_index

# Check if the selected index is valid
if ! [[ "$file_index" =~ ^[0-9]+$ ]] || [ "$file_index" -ge ${#uwu_files[@]} ]; then
    echo "Invalid selection."
    exit 1
fi

# Get the selected file
CONFIG_FILE="${uwu_files[$file_index]}"
echo "Loading configuration from: $CONFIG_FILE"

# Send the selected configuration file to the router via serial port
cat "$CONFIG_FILE" > "$SERIAL_PORT"

# Optional: After sending, you can manually check via minicom or screen
# screen $SERIAL_PORT $BAUD_RATE
