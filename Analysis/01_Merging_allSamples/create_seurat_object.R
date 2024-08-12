library(dplyr)
library(Seurat)
library(ggplot2)
library(stringr)
library(here)

# Define the base directory
base_dir <- "/N/project/cytassist/heather/Chrm_499_OHagan_IUB_FLEX15_Mouse_May2024/Chrm_499_OHagan_IUB_FLEX15_run6/outs/per_sample_outs"

# Get all sample folders
all_samples <- list.dirs(base_dir, full.names = TRUE, recursive = FALSE)
names(all_samples) <- basename(all_samples)

# Remove the 'merged' folder if it exists
all_samples <- all_samples[!names(all_samples) %in% c("merged")]

# Display the samples
print(data.frame(sample_id = names(all_samples)))

# Append the paths of sample_path/count/sample_filtered_feature_bc_matrix to each sample
feature_matrix_paths <- file.path(all_samples, "count", "sample_filtered_feature_bc_matrix")
names(feature_matrix_paths) <- names(all_samples)

# Create a list of Read10X objects
expression_matrices <- lapply(feature_matrix_paths, function(path) {
  tryCatch(
    Read10X(path),
    error = function(e) {
      warning(paste("Error reading", path, ":", e$message))
      NULL
    }
  )
})
expression_matrices <- expression_matrices[!sapply(expression_matrices, is.null)]

# Create Seurat objects from the list of Read10X objects
seurat_objects <- mapply(
    function(x, y) {
        CreateSeuratObject(counts = x, project = y)
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
save_path <- file.path(base_dir, "merged", "00-seurat_merged.rds")
dir.create(file.path(base_dir, "merged"), showWarnings = FALSE)
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
pdf(file.path(base_dir, "merged", "cells_per_sample.pdf"), width = 12, height = 8)
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
