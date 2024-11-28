#!/bin/bash

# Define variables
ENV_NAME="opentrons-env"
PYTHON_VERSION="3.10"

# Function to set up Conda environment
setup_conda_environment() {
    echo "Checking Conda installation..."

    if ! command -v conda &>/dev/null; then
        echo "Error: Conda is not installed or not detected in PATH."
        read -n 1 -s -r -p "Press any key to continue..."
        return
    fi

    # Update Conda
    echo "Updating Conda..."
    conda update -n base -c defaults conda -y
    if [ $? -ne 0 ]; then
        echo "Error: Conda update failed."
        read -n 1 -s -r -p "Press any key to continue..."
        return
    fi

    # Check if environment exists
    if conda env list | grep -q "$ENV_NAME"; then
        echo "Conda environment '$ENV_NAME' already exists."
    else
        echo "Creating Conda environment '$ENV_NAME' with Python $PYTHON_VERSION..."
        conda create -n $ENV_NAME python=$PYTHON_VERSION -y
        if [ $? -ne 0 ]; then
            echo "Error: Failed to create Conda environment '$ENV_NAME'."
            read -n 1 -s -r -p "Press any key to continue..."
            return
        fi
    fi

    echo "Activating Conda environment '$ENV_NAME'..."
    eval "$(conda shell.bash hook)"
    conda activate $ENV_NAME
    if [ $? -ne 0 ]; then
        echo "Error: Failed to activate Conda environment '$ENV_NAME'."
        read -n 1 -s -r -p "Press any key to continue..."
        return
    fi

    echo "Installing Opentrons dependencies..."
    pip install opentrons
    if [ $? -ne 0 ]; then
        echo "Error: Failed to install Opentrons dependencies."
        read -n 1 -s -r -p "Press any key to continue..."
        return
    fi

    echo "Installing GitHub CLI..."
    conda install -c conda-forge gh -y
    if [ $? -ne 0 ]; then
        echo "Error: Failed to install GitHub CLI."
        read -n 1 -s -r -p "Press any key to continue..."
        return
    fi

    echo "Setting '$ENV_NAME' as the default environment..."
    conda config --set auto_activate_base false
    echo "conda activate $ENV_NAME" >> ~/.bashrc

    echo "Conda environment setup completed successfully!"
}

# Main script
echo "Starting setup..."
setup_conda_environment

echo "Setup completed successfully!"
read -n 1 -s -r -p "Press any key to exit."
