#!/bin/bash

# Define variables
VSCODE_INSTALLER="VSCodeUserSetup-x64.exe"
VSCODE_URL="https://update.code.visualstudio.com/latest/win32-x64-user/stable"
INSTALL_DIR="/c/Users/$USER/AppData/Local/Programs/Microsoft VS Code"
VSCODE_BIN="$INSTALL_DIR/bin/code"

# Function to check if VS Code is installed
check_vscode_installation() {
    echo "Checking if VS Code is already installed..."
    if [ -f "$VSCODE_BIN" ]; then
        echo "VS Code is already installed."
        return 0
    else
        return 1
    fi
}

# Function to manually download and install VS Code
install_vscode_manually() {
    echo "VS Code is not installed. Proceeding with manual installation..."

    # Download VS Code installer
    curl -L -o "$VSCODE_INSTALLER" "$VSCODE_URL"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to download VS Code installer."
        return 1
    fi

    # Run the installer
    cmd.exe /c "$VSCODE_INSTALLER /VERYSILENT /NORESTART"
    if [ $? -ne 0 ]; then
        echo "Error: Failed to install VS Code."
        rm -f "$VSCODE_INSTALLER"
        return 1
    fi

    # Clean up installer
    rm -f "$VSCODE_INSTALLER"
    echo "VS Code installed successfully."
}

# Function to add VS Code to PATH
add_vscode_to_path() {
    echo "Adding VS Code to PATH..."
    if [[ ":$PATH:" != *":$(dirname "$VSCODE_BIN"):"* ]]; then
        export PATH="$(dirname "$VSCODE_BIN"):$PATH"
        echo "export PATH=\"$(dirname "$VSCODE_BIN"):\$PATH\"" >> ~/.bashrc
        echo "VS Code has been added to PATH."
    else
        echo "VS Code is already in PATH."
    fi
}

# Function to configure VS Code
configure_vscode() {
    echo "Configuring VS Code for Opentrons development..."

    # Ensure `code` is available in PATH
    if ! command -v code &>/dev/null; then
        echo "Error: VS Code is not accessible from the PATH. Skipping configuration."
        return 1
    fi

    # Install VS Code extensions
    echo "Installing VS Code extensions..."
    code --install-extension ms-python.python
    code --install-extension ms-python.vscode-pylance
    code --install-extension github.vscode-pull-request-github
    code --install-extension ms-vscode.remote-repositories
    code --install-extension ms-vscode.cpptools
    echo "VS Code extensions installed successfully."
}

# Prompt user to open VS Code
prompt_open_vscode() {
    read -p "Do you want to open VS Code now? (y/n): " response
    if [[ $response =~ ^[Yy]$ ]]; then
        echo "Launching VS Code..."
        code .
    else
        echo "You can start VS Code later by running 'code' in the terminal."
    fi
}

# Main script
echo "Starting VS Code setup..."
check_vscode_installation
if [ $? -ne 0 ]; then
    install_vscode_manually
fi

add_vscode_to_path
configure_vscode
prompt_open_vscode

echo "VS Code setup completed successfully!"
