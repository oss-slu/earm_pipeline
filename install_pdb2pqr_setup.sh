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

echo "=== Step 3: Prepare Dowser source directory ==="

DOWSER_TAR="/projects/earm/software/dowser.tar.gz"
DOWSER_DIR="/projects/earm/software/dowser"

# Ensure tarball exists
if [ ! -f "$DOWSER_TAR" ]; then
    echo "ERROR: Dowser tarball missing at $DOWSER_TAR"
    exit 1
fi

# Extract dowser if missing
if [ ! -d "$DOWSER_DIR" ]; then
    echo "Extracting Dowser..."
    tar -xzvf "$DOWSER_TAR" -C "$SOFTWARE_DIR"
else
    echo "Dowser directory exists, skipping extraction."
fi

echo "=== Step 4: Apply source code fixes for missing prototypes ==="

cd "$DOWSER_DIR/CODE"

# Append missing function prototypes if not present
grep -q "AddAllAtoms" general.h || echo "int AddAllAtoms(int, tAtom *, tResType *, int);" >> general.h
grep -q "LocateInResidue" general.h || echo "int LocateInResidue(tAtom *, int, tResidue *, char *);" >> general.h

echo "=== Step 5: Patch Makefile for GCC ==="

sed -i 's/^F77 = .*/F77 = gfortran/' Makearch.linux || true

echo "=== Step 6: Build Dowser ==="

cd "$DOWSER_DIR"
./Install <<EOF
linux
EOF

echo "=== Step 7: Create bash-friendly initialization file ==="

INIT_FILE="$DOWSER_DIR/dowserinit.sh"

cat > "$INIT_FILE" <<'EOF'
export DOWSER=/projects/earm/software/dowser
export DOW_MACH=linux
export PATH=$PATH:$DOWSER/bin:$DOWSER/bin/$DOW_MACH
EOF

echo "Bash initialization file created at $INIT_FILE"

# Source the new init file
source "$INIT_FILE"

echo "=== Step 8: Verify Dowser installation ==="

if command -v dowser >/dev/null 2>&1; then
    echo "Dowser is in PATH."
else
    echo "ERROR: Dowser not found in PATH."
    exit 1
fi

dowser --help || true

echo "=== Step 9: Install PDB2PQR ==="

cd "$PDB2PQR_DIR"

python setup.py install --prefix "$PDB2PQR_DIR/install"

echo "=== Step 10: Verify PDB2PQR ==="

"$PDB2PQR_DIR/install/bin/pdb2pqr" --help

echo "=== Installation Completed Successfully ==="
