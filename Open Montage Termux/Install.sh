#!/bin/bash

# ==============================================================================
# AUTHOR: Dr. Akshith
# BRANDING: Dr. Akshith's Automated Cloud Lab Series
# DESCRIPTION: Optimized OpenMontage Installer for Termux (Android / 4GB RAM)
# ==============================================================================

# Define Dr. Akshith's Signature Branding Colors
BLUE='\033[0;34m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo -e "${CYAN}====================================================${NC}"
echo -e "${BLUE}        DR. AKSHITH'S AUTOMATED CLOUD LABS        ${NC}"
echo -e "${BLUE}          OpenMontage Termux Setup Script          ${NC}"
echo -e "${CYAN}====================================================${NC}"
echo -e "${YELLOW}[*] Target Device Profile: Samsung 4GB RAM / 128GB ROM Config${NC}"

# Step 1: System Package Validation
echo -e "\n${CYAN}[1/5] Syncing Termux packages and tools...${NC}"
pkg update -y && pkg install -y git python nodejs ffmpeg make

# Step 2: Clean Existing Directory Workspace
echo -e "\n${CYAN}[2/5] Cleaning and creating workspace environments...${NC}"
if [ -d "OpenMontage" ]; then
    echo -e "${YELLOW}[!] Found legacy OpenMontage directory. Wiping for clean install...${NC}"
    rm -rf OpenMontage
fi

# Step 3: Core Repository Clone
echo -e "\n${CYAN}[3/5] Cloning OpenMontage repository...${NC}"
git clone https://github.com/calesthio/OpenMontage.git
if [ ! -d "OpenMontage" ]; then
    echo -e "${RED}[X] Error: Failed to clone the repository.${NC}"
    exit 1
fi
cd OpenMontage

# Step 4: Python Virtual Environment Matrix Setup
echo -e "\n${CYAN}[4/5] Establishing sandboxed Python environment...${NC}"
python3 -m venv .venv
source .venv/bin/activate

# Step 5: Injecting Python 3.14 Structural Patches
echo -e "\n${CYAN}[5/5] Patching dependency ecosystem for Python 3.14 compatibility...${NC}"
pip install --upgrade pip setuptools wheel

# Force install a version of NumPy that natively supports Python 3.14 wheels to stop compilation locks
echo -e "${YELLOW}[*] Injecting NumPy wheel binary constraints...${NC}"
pip install "numpy>=2.1.0"

# Step 6: Triggering Core Project Automation
echo -e "\n${GREEN}[+] Executing project setup automation toolchain...${NC}"
make setup

if [ $? -eq 0 ]; then
    echo -e "\n${CYAN}====================================================${NC}"
    echo -e "${GREEN}      🎉 SUCCESS: OPENMONTAGE INSTALLED SUCCESSFULLY 🎉      ${NC}"
    echo -e "${BLUE}          Brought to you by Dr. Akshith's Tech Lab         ${NC}"
    echo -e "${CYAN}====================================================${NC}"
else
    echo -e "\n${RED}[X] Compilation or setup exited with errors. Please check the logs above.${NC}"
    exit 1
fi
