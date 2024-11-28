# OpenTrons Development Environment Setup for MRes 2024

This guide provides detailed instructions to set up the OpenTrons development environment. Ensure you follow the steps carefully for a successful setup.

---

## **Steps for Setup**

### 1. **Download and Extract Files**
- Download the two provided setup files (`setup_opentron_env.sh`, `install_vscode.sh`) into your home folder (` i.e: C:\Users\he124`).
- ensure the scripts and any configuration files are correctly placed into your home folder.

### 2. **Install Required Software Manually**
You will need to install the following software manually before running the scripts:

- **Miniconda**: [Download Miniconda](https://repo.anaconda.com/miniconda/Miniconda3-latest-Windows-x86_64.exe).
  - Install Miniconda before proceeding with the `setup_opentron_env.sh` script.

- **Visual Studio Code (VS Code)**: [Download VS Code](https://code.visualstudio.com/sha/download?build=stable&os=win32-x64-user)  
  - Use the User Installer for Windows or the system-appropriate installer.  
  - Install VS Code before proceeding with the `install_vscode.sh` script.

- **Git for Windows**: [Download Git 2.47.1 64-bit](https://github.com/git-for-windows/git/releases/download/v2.47.1.windows.1/Git-2.47.1-64-bit.exe)  
  - Install Git to enable version control and collaboration.
  - Install Git before proceeding with the `setup_opentron_env.sh` script.

---

# **Using the Environment Setup Scripts**

### **Setting Up OpenTrons Development Environment**
1. Open the **Conda Powershell Bash** (installed alongside Miniconda).  
2. Navigate to your home directory by typing:
   ```bash
   cd ~
   ```
3. Run the OpenTrons environment setup script:
   ```bash
   ./setup_opentron_env.sh
   ```
4. Follow the on-screen instructions:
   - This will configure a new Conda environment (`opentrons-env`).
   - Installs Python dependencies (`opentrons`, `gh`, and other required libraries).

### **Installing and Configuring VS Code**
1. Once the environment setup is complete, configure VS Code by running:
   ```bash
   ./install_vscode.sh
   ```
2. The script will:
   - Add VS Code to the PATH (if needed).
   - Install essential VS Code extensions for Python development and GitHub integration.
   - Configure VS Code for working with the `opentrons-env` Conda environment.

3. Follow the output closely. When the script halts, type:
   ```bash
   exit
   ```

---

## **File Descriptions**

### `setup_opentron_env.sh`
- This script sets up the OpenTrons Conda environment (`opentrons-env`).
- It installs all required dependencies, including:
  - Python 3.10
  - `opentrons` library for protocol simulation and development
  - `gh` (GitHub CLI) for GitHub integration.

### `install_vscode.sh`
- Configures Visual Studio Code for OpenTrons development.
- Adds VS Code to the PATH (if not already available).
- Installs extensions for Python, GitHub, and remote repository integration.

---

## **Using the OpenTrons Development Environment**

### Activating the Environment
- After the setup, activate the `opentrons-env` Conda environment:
  ```bash
  conda activate opentrons-env
  ```
- Alternatively, use **Conda Navigator** to activate the environment.

### Working with OpenTrons
1. Launch VS Code:
   ```bash
   code .
   ```
2. **Select the Python Interpreter**:
   - Press `Ctrl+Shift+P` to open the command palette.
   - Type "Python: Select Interpreter" and select the `opentrons-env` environment.
3. **Run Simulations**:
   - Use the integrated terminal or Python interactive terminal to develop and test OpenTrons protocols.
   - Refer to the [OpenTrons Python API documentation](https://docs.opentrons.com/) for detailed examples and guidelines.

---

## **Git Workflow in VS Code**

1. **Cloning Repositories**:
   - Use GitHub CLI or the integrated terminal to clone repositories:
     ```bash
     gh repo clone <username>/<repository>
     ```
2. **Managing Changes**:
   - Use the VS Code source control tab or Git commands to stage, commit, and push changes:
     ```bash
     git status
     git add .
     git commit -m "Your commit message"
     git push origin <branch-name>
     ```
3. **Creating Pull Requests**:
   - Use the GitHub Pull Requests and Issues extension in VS Code or `gh` CLI:
     ```bash
     gh pr create --title "PR Title" --body "Description of the PR"
     ```

4. **Syncing Branches**:
   - To sync your local branch with the remote branch:
     ```bash
     git pull origin <branch-name>
     ```
---
