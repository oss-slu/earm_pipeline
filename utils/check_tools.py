"""
Simple utility to check whether required external tools
for the pyARM workflow are available in the system PATH.
This helps with Sprint 6 verification.
"""
from shutil import which
def check_tool(name):
    """Check if a tool exists in PATH and print a simple status message."""
    path = which(name)
    if path:
        print(f":heavy_check_mark: {name} found at {path}")
    else:
        print(f"✘ {name} not found in PATH")
if __name__ == "__main__":
    required_tools = [
        "gmx",       # GROMACS executable
        "dowser",    # Dowser executable
        "pdb2pqr",   # PDB2PQR executable
        "modeller",  # Modeller (may be modeller9 or others)
    ]
    print("=== pyARM Tool Availability Check ===\n")
    for tool in required_tools:
        check_tool(tool)
    print("\nCheck complete.")