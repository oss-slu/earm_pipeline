#!/bin/bash
echo "----------------------------------------"
echo "Testing pyARM tool paths..."
echo "----------------------------------------"

TOOLS=(
"/projects/earm/tools/vmd/bin/vmd"
"/projects/earm/tools/pdb2pqr/pdb2pqr.py"
"/projects/earm/tools/dowser/dowser"
)

for tool in "${TOOLS[@]}"; do
  if [ -x "$tool" ]; then
    echo "✅ Found: $tool"
  else
    echo "❌ Not found: $tool"
  fi
done

echo "Path test complete."
