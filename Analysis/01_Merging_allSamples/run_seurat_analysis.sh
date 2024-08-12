#!/bin/bash
#SBATCH --mail-user=akhaliq@iu.edu
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=16
#SBATCH --mail-type=FAIL,BEGIN,END
#SBATCH --job-name=seurat_integration
#SBATCH --error=seurat_integration.error
#SBATCH --output=seurat_integration.out
#SBATCH --time=1-00:00:00
#SBATCH --mem=400G
#SBATCH --partition=general
#SBATCH --account=r00583

# Load miniconda module
module load miniconda

# Activate the spatial conda environment
conda activate spatial

# Change to the project directory
cd /N/project/cytassist/heather/Chrm_499_OHagan_IUB_FLEX15_Mouse_May2024

# Run the R script
Rscript create_seurat_object.R

echo "Seurat analysis completed"
