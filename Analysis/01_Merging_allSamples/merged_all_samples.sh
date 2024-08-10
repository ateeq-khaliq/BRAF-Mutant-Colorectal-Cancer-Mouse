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

# Create an R script for Seurat object creation and analysis
cat << EOF > create_seurat_object.R
library(dplyr)
library(Seurat)
library(ggplot2)
library(stringr)
library(here)
library(config)

config <- config::get()

# Create a named vector of the samples and their corresponding paths
all_samples_march <- list.files(
    here::here(
        config$data_interim, 
        "Chrm_375_Masood_FLEX16_Mar2023_output", 
        "outs", 
        "per_sample_outs"
    ),
    full.names = TRUE
)
names(all_samples_march) <- basename(all_samples_march)

all_samples_august <- list.files(
    here::here(
        config$data_interim, 
        "Chrm_441_Masood_FLEX8_Mouse_Aug2023_output", 
        "outs", 
        "per_sample_outs"
    ),
    full.names = TRUE
)
names(all_samples_august) <- basename(all_samples_august)

# We'll take all samples from August batch and 8 samples from March batch
# which are not present in August batch.
samples_not_in_august <- setdiff(
    names(all_samples_march), 
    names(all_samples_august)
)

all_samples <- c(
    all_samples_august, 
    all_samples_march[samples_not_in_august]
)

# Display the samples and their corresponding paths
pattern <- "Chrm_\\d+_Masood_[A-Za-z0-9_]+_(\\w+\\d+)"
sample_info <- data.frame(
  sample_id = names(all_samples),
  selected_batch = str_extract(all_samples, pattern)
)
print(sample_info)

# Append the paths of sample_path/count/sample_filtered_feature_bc_matrix to each sample
feature_matrix_paths <- file.path(
    all_samples, 
    "count", 
    "sample_filtered_feature_bc_matrix"
)
names(feature_matrix_paths) <- names(all_samples)

# Create a list of Read10X objects
expression_matrices <- lapply(
    feature_matrix_paths, 
    Read10X
)
names(expression_matrices) <- names(all_samples)

# Create Seurat objects from the list of Read10X objects
seurat_objects <- mapply(
    function(x, y) {
        CreateSeuratObject(
            counts = x, 
            project = y
        )
    },
    expression_matrices, 
    names(expression_matrices), 
    SIMPLIFY = FALSE,
    USE.NAMES = TRUE
)

# Merge the Seurat objects
seurat_object <- merge(
    seurat_objects[[1]],
    seurat_objects[-1],
    add.cell.ids = names(seurat_objects), 
    project = "ProAgio"
)

# Join layers
seurat_joined <- JoinLayers(seurat_object)

# Save the Seurat object
save_path <- file.path(here::here(config$data_interim, "00-seurat_merged.rds"))
saveRDS(seurat_joined, save_path)

# Verify that the file was saved
if (file.exists(save_path)) {
    file_size <- file.size(save_path) / 1e6  # Convert to MB
    cat(sprintf("Seurat object saved successfully to %s (%.2f MB)\n", save_path, file_size))
} else {
    cat(sprintf("ERROR: Failed to save Seurat object to %s\n", save_path))
}

# Print some information about the Seurat object
cat(
    "Number of cells in the saved object: ",
    ncol(seurat_joined),
    "\n",
    "Number of genes in the saved object: ",
    nrow(seurat_joined),
    "\n",
    sep = ""
)

# Check the number of cells in each sample
cells_per_sample <- table(seurat_joined$orig.ident)
cells_per_sample <- data.frame(
    sample_id = names(cells_per_sample),
    cells = as.numeric(cells_per_sample)
)
print(cells_per_sample)

# Plot the number of cells in each sample
pdf("cells_per_sample.pdf", width = 12, height = 8)
ggplot(cells_per_sample, aes(x = sample_id, y = cells)) +
    geom_bar(stat = "identity", fill = "#66c2a5") +
    theme_minimal() +
    theme(
        axis.text.x = element_text(angle = 90, hjust = 1),
        axis.title.x = element_blank()
    ) +
    labs(
        title = "Number of cells in each sample",
        x = "Sample ID",
        y = "Number of cells"
    ) +
    theme(plot.title = element_text(hjust = 0.5, size = 20)) +
    geom_text(
        aes(label = cells), 
        vjust = -0.5, 
        size = 4
    ) +
    theme(
        panel.grid.major = element_blank(),
        panel.border = element_blank(),
        panel.background = element_blank()
    )
dev.off()

print("Seurat object creation and analysis completed successfully.")
EOF

# Run the R script
Rscript create_seurat_object.R

echo "Pipeline completed successfully"

# Deactivate the conda environment
conda deactivate
