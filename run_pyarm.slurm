# ==== Load modules (if available) ====
module load python singularityce gcc openblas 2>/dev/null || echo "Modules not found — skipping"

# ==== Activate Conda environment ====
source ~/miniconda3/
conda activate pyarm2021

# ==== Move to project directory ====
cd /home/$USER/pyarm_project   # replace $USER with appropriate user

# ==== Run the workflow ====
echo "Starting pyARM + Dowser + GROMACS workflow..."
python run_pyarm.py > pyarm_output.log 2>&1
echo "Workflow finished."

# In the Terminal:
# Make it Executable
#   chmod +x run_pyarm.slurm
# Submit the job
#   sbatch run_pyarm.slurm
# Check output
#   cat slurm-12345.out (replace 12345 with actual job #)
#   cat pyarm_output.log