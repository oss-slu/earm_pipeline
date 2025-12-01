set -euo pipefail # Exit on Errors

SOFTDIR="/projects/earm"                    # GROMACS location
SOFTDIR_DOWSER="/projects/earm/software"    # Dowser location
LOGDIR="/projects/earm/logs"

mkdir -p "$LOGDIR"

### Gromacs 4.5.7 Installation

echo "=== Installing GROMACS 4.5.7 ==="
echo "Logs: $LOGDIR/gromacs-install.log"

(
    cd "$SOFTDIR"

    # Extract GROMACS source
    tar zxvf gromacs-4.5.7.tar.gz
    cd gromacs-4.5.7

    mkdir -p build
    cd build

    # Configure — using GCC toolchain
    ../configure \
        --prefix="$SOFTDIR/gromacs-4.5.7/installation" \
        --enable-double \
        CC=gcc CXX=g++ \
        2>&1 | tee "$LOGDIR/gromacs-config.log"

    # Build and install
    make -j 8        2>&1 | tee "$LOGDIR/gromacs-make.log"
    make install     2>&1 | tee "$LOGDIR/gromacs-install.log"

) || echo "*** GROMACS installation encountered issues ***"

echo "=== Verifying GROMACS installation ==="

# Test cases for Gromacs 4.5.7
{
    export PATH="$SOFTDIR/gromacs-4.5.7/installation/bin:$PATH"

    echo "---- GROMACS Version Tests ----"

    echo "grompp -version:"
    grompp -version || echo "grompp NOT FOUND — check PATH"
    echo

    echo "mdrun -version:"
    mdrun -version || echo "mdrun NOT FOUND — check PATH"
    echo

    echo "pdb2gmx -version:"
    pdb2gmx -version || echo "pdb2gmx NOT FOUND — check PATH"
    echo

    echo "Expected: version 4.5.7"
} > "$LOGDIR/gromacs-test.log" 2>&1

### Dowser Installation

echo "=== Installing Dowser ==="
echo "Logs: $LOGDIR/dowser-install.log"

(
    cd "$SOFTDIR_DOWSER"

    # Extract Dowser
    tar zxvf dowser.tar.gz
    cd dowser

    # Fix script bug line 225
    sed -i '225s/set W = WW\[1\]/set W = $WW\[1\]/' dowser || true

    # Ensure Makearch.linux has correct Fortran compiler
    sed -i 's/^F77 = .*/F77 = gfortran/' CODE/Makearch.linux

    # Run installation
    cd ..
    ./Install 2>&1 | tee "$LOGDIR/dowser-install.log"

    # Copy atomdict.db (if available)
    cp "$SOFTDIR_DOWSER/a-arm_fluorescence_search/scripts/templates/ff_db/atomdict.db" \
       "$SOFTDIR_DOWSER/dowser/data/" 2>/dev/null || true

) || echo "*** Dowser installation encountered issues ***"

echo "=== Verifying Dowser installation ==="

# Test case for Dowser
{
    echo "---- Dowser Test ----"

    DOWSER_BIN="$SOFTDIR_DOWSER/dowser/dowser"

    if [[ -x "$DOWSER_BIN" ]]; then
        echo "Running: dowser --help | head -n 10"
        "$DOWSER_BIN" --help | head -n 10
        echo
        echo "Expected: Dowser header or usage lines"
    else
        echo "Dowser binary NOT FOUND — checking directory:"
        ls -l "$SOFTDIR_DOWSER/dowser/"
    fi

    echo
    echo "---- Checking atomdict.db ----"

    if [[ -f "$SOFTDIR_DOWSER/dowser/data/atomdict.db" ]]; then
        echo "atomdict.db found in data/ directory."
    else
        echo "atomdict.db NOT FOUND — contents of data/:"
        ls -l "$SOFTDIR_DOWSER/dowser/data/" || true
    fi

} > "$LOGDIR/dowser-test.log" 2>&1
