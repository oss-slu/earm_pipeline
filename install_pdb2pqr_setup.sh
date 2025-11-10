# Exit script if any commands fail
set -e

# Define key directories and paths
SOFTWARE_DIR="/projects/earm/software"
PDB2PQR_VER="2.1.1"
PDB2PQR_TAR="$SOFTWARE_DIR/pdb2pqr-$PDB2PQR_VER.tar.gz"
PDB2PQR_DIR="$SOFTWARE_DIR/pdb2pqr-$PDB2PQR_VER"
MINICONDA_CONDA="/projects/earm/local/miniconda3/conda/bin/conda"
PY2_ENV="/projects/earm/py2pdb"

# Ensure installation directory exist
mkdir -p "$SOFTWARE_DIR"

echo "=== Step 1: Download and extract pdb2pqr v$PDB2PQR_VER ==="

# Move to installation directory
cd "$SOFTWARE_DIR"

# Download tarball if missing
if [ ! -f "$PDB2PQR_TAR" ]; then
    echo "Downloading pdb2pqr-$PDB2PQR_VER..."
    wget "https://github.com/Electrostatics/pdb2pqr/archive/refs/tags/v${PDB2PQR_VER}.tar.gz" \
        -O "$PDB2PQR_TAR"
else
    echo "Tarball already exists, skipping download."
fi

# Extract if not already extracted
if [ ! -d "$PDB2PQR_DIR" ]; then
    echo "Extracting pdb2pqr-$PDB2PQR_VER..."
    tar -xzf "$PDB2PQR_TAR"
else
    echo "Source folder already exists, skipping extraction."
fi

echo "=== Step 2: Create Python 2.7 environment ==="

# Check if environment exists
if [ ! -d "$PY2_ENV" ]; then
    echo "Creating Python 2.7 conda environment at $PY2_ENV..."
    "$MINICONDA_CONDA" create -p "$PY2_ENV" python=2.7 -y
else
    echo "Environment already exists at $PY2_ENV, skipping creation."
fi

# Activate environment and verify Python version
source /projects/earm/local/miniconda3/bin/activate "$PY2_ENV"
python --version

echo "=== Steps 1 and 2 complete! ==="
