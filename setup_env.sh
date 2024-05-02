#!/bin/bash

# Script arguments
VENV_NAME="my_venv"  # Replace with your desired virtual environment name
REQUIREMENTS_FILE="requirements.txt"  # Replace with the path to your requirements.txt file (absolute or relative)
PYTHON_VERSION="3.12"  # Optional: Specify a specific Python version (if needed)

# Check if virtual environment already exists
if [ -d "$VENV_NAME" ]; then
  echo "Virtual environment '$VENV_NAME' already exists."
  echo "Do you want to recreate it (y/N)?"
  read -r recreate
  if [[ "$recreate" =~ ^([Yy])$ ]]; then
    rm -rf "$VENV_NAME"
  else
    echo "Skipping virtual environment creation."
    exit 0
  fi
fi

# Create virtual environment (using venv for portability)
echo "Creating virtual environment '$VENV_NAME'..."
python"$PYTHON_VERSION" -m venv "$VENV_NAME" || { echo "Failed to create virtual environment. Check Python version or permissions."; exit 1; }

# Activate the virtual environment
# source "${VENV_PATH}/bin/activate"  # For Linux/macOS
. "${VENV_PATH}\Scripts\activate.bat"  # For Windows (assuming Scripts folder exists)

# Install packages from requirements.txt
echo "Installing packages from '$REQUIREMENTS_FILE'..."
pip install -r "$REQUIREMENTS_FILE" || { echo "Failed to install packages. Check requirements.txt or network connectivity."; exit 1; }

echo "Virtual environment '$VENV_NAME' is ready and activated."
echo "Packages installed from '$REQUIREMENTS_FILE'."

# Optional: Deactivate virtual environment (uncomment if desired)
# deactivate

# deletion of venv
rm -rf "$VENV_NAME" #linux/macos
rmdir /S /Q "$VENV_NAME" #windows