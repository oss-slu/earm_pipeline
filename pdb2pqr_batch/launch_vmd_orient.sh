# Function to check if a command exists
check_command() {
    if command -v "$1" >/dev/null 2>&1; then
        echo "[OK] $1 found in PATH."
        return 0
    else
        echo "[ERROR] $1 not found in PATH."
        return 1
    fi
}

echo "=== Checking environment ==="

# Check for VMD
check_command vmd
vmd_status=$?

# Check for Orient
check_command orient
orient_status=$?

# If both are available, launch them
if [[ $vmd_status -eq 0 ]]; then
    echo "Launching VMD..."
    nohup vmd >/dev/null 2>&1 &
else
    echo "Skipping VMD launch (not in PATH)."
fi

if [[ $orient_status -eq 0 ]]; then
    echo "Launching Orient..."
    nohup orient >/dev/null 2>&1 &
else
    echo "Skipping Orient launch (not in PATH)."
fi

echo "=== Done ==="
