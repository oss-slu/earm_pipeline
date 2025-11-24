set -euo pipefail #Exit on Errors

SOFTDIR="/projects/earm/software"
LOGDIR="/projects/earm/logs"

mkdir -p "$LOGDIR"

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

export PATH="$SOFTDIR/gromacs-4.5.7/installation/bin:$PATH"

grompp -version   > "$LOGDIR/gromacs-test.log" 2>&1 || true
mdrun  -version  >> "$LOGDIR/gromacs-test.log" 2>&1 || true
pdb2gmx -version >> "$LOGDIR/gromacs-test.log" 2>&1 || true
