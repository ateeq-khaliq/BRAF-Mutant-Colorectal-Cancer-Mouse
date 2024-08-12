getwd()

library(Seurat)
library(knitr)
library(dittoSeq)

so <- readRDS("~/Desktop/heather/seurat_object/00-seurat_merged.rds")

head(so)

metadata <- data.frame(
  sample_name = c(968, 966, 979, 963, 975, 964, 960, 978, 969, 983, 0, 959, 965, 967, 977),
  description = c(
    "Vehicle treated female 1", "Vehicle treated female 2", "Vehicle treated female 3",
    "Inhibitor treated female 1", "Inhibitor treated female 2", "Inhibitor treated female 3",
    "Vehicle treated male 1", "Vehicle treated male 2", "Vehicle treated male 3",
    "Vehicle treated male 4", "Inhibitor treated male 1", "Inhibitor treated male 2",
    "Inhibitor treated male 3", "Inhibitor treated male 4", "Inhibitor treated male 5"
  ),
  barcode = paste0("BC", 1:15)
)

# Add Treatment and Sex columns to the metadata
metadata$Treatment <- ifelse(grepl("Vehicle", metadata$description), "Vehicle Treated", "Inhibitor Treated")
metadata$Sex <- ifelse(grepl("female", metadata$description), "Female", "Male")

# Create lookup tables
lookup_description <- setNames(metadata$description, metadata$sample_name)
lookup_barcode <- setNames(metadata$barcode, metadata$sample_name)
lookup_treatment <- setNames(metadata$Treatment, metadata$sample_name)
lookup_sex <- setNames(metadata$Sex, metadata$sample_name)

# Add metadata to Seurat object
so$sample_description <- lookup_description[as.character(so$orig.ident)]
so$barcode <- lookup_barcode[as.character(so$orig.ident)]
so$Treatment <- lookup_treatment[as.character(so$orig.ident)]
so$Sex <- lookup_sex[as.character(so$orig.ident)]

# Verify that the metadata has been added correctly
head(so@meta.data)


#

library(Seurat)
library(ggplot2)
library(dplyr)

# 1. Distribution of nCount_RNA by Treatment and Sex
ggplot(so@meta.data, aes(x = Treatment, y = nCount_RNA, fill = Sex)) +
  geom_boxplot() +
  scale_y_log10() +
  theme_minimal() +
  labs(title = "Distribution of RNA counts by Treatment and Sex",
       y = "Number of RNA counts (log10 scale)")

# 2. Distribution of nFeature_RNA by Treatment and Sex
ggplot(so@meta.data, aes(x = Treatment, y = nFeature_RNA, fill = Sex)) +
  geom_boxplot() +
  theme_minimal() +
  labs(title = "Distribution of Features by Treatment and Sex",
       y = "Number of Features")

# 3. Scatter plot of nCount_RNA vs nFeature_RNA, colored by Treatment
ggplot(so@meta.data, aes(x = nCount_RNA, y = nFeature_RNA, color = Treatment)) +
  geom_point(alpha = 0.5) +
  scale_x_log10() +
  scale_y_log10() +
  theme_minimal() +
  labs(title = "nCount_RNA vs nFeature_RNA",
       x = "Number of RNA counts (log10 scale)",
       y = "Number of Features (log10 scale)")

# 4. Bar plot of cell counts by sample_description
so@meta.data %>%
  count(sample_description) %>%
  ggplot(aes(x = reorder(sample_description, n), y = n, fill = sample_description)) +
  geom_bar(stat = "identity") +
  coord_flip() +
  theme_minimal() +
  labs(title = "Number of Cells by Sample",
       x = "Sample Description",
       y = "Number of Cells") +
  theme(legend.position = "none")

# 5. Violin plot of nFeature_RNA by barcode
ggplot(so@meta.data, aes(x = barcode, y = nFeature_RNA, fill = barcode)) +
  geom_violin() +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(title = "Distribution of Features by Barcode",
       x = "Barcode",
       y = "Number of Features") +
  theme(legend.position = "none")

# 6. Density plot of nCount_RNA by Treatment
ggplot(so@meta.data, aes(x = nCount_RNA, fill = Treatment)) +
  geom_density(alpha = 0.5) +
  scale_x_log10() +
  theme_minimal() +
  labs(title = "Density of RNA counts by Treatment",
       x = "Number of RNA counts (log10 scale)")

ggsave("plot_name.png", plot = last_plot(), width = 10, height = 6)

####


library(Seurat)
library(ggplot2)
library(dplyr)
library(scales)
library(viridis)

# Custom theme for consistent, professional look
theme_publication <- function(base_size = 12, base_family = "Helvetica") {
  theme_minimal(base_size = base_size, base_family = base_family) %+replace%
    theme(
      panel.border = element_rect(colour = "black", fill = NA, size = 0.5),
      axis.title = element_text(face = "bold", size = rel(1)),
      axis.text = element_text(size = rel(0.8)),
      legend.title = element_text(face = "bold", size = rel(0.8)),
      legend.text = element_text(size = rel(0.7)),
      plot.title = element_text(face = "bold", size = rel(1.2), hjust = 0.5),
      plot.subtitle = element_text(size = rel(0.9), hjust = 0.5),
      plot.caption = element_text(size = rel(0.7), hjust = 1),
      plot.background = element_rect(fill = "white", colour = NA),
      panel.background = element_rect(fill = "white", colour = NA),
      legend.background = element_rect(fill = "white", colour = NA)
    )
}

# Function to create and save plots
create_and_save_plot <- function(plot_func, filename) {
  p <- plot_func()
  ggsave(filename, plot = p, width = 10, height = 7, dpi = 300)
  print(paste("Saved:", filename))
}

# 1. Distribution of nCount_RNA by Treatment and Sex
create_and_save_plot(
  function() {
    ggplot(so@meta.data, aes(x = Treatment, y = nCount_RNA, fill = Sex)) +
      geom_boxplot(alpha = 0.7, outlier.shape = 21, outlier.size = 1.5) +
      scale_y_log10(labels = comma) +
      scale_fill_viridis(discrete = TRUE, begin = 0.3, end = 0.7) +
      theme_publication() +
      labs(title = "Distribution of RNA Counts by Treatment and Sex",
           subtitle = "Log10 scale",
           y = "Number of RNA Counts",
           x = "Treatment")
  },
  "1_rna_counts_by_treatment_sex.png"
)

# 2. Distribution of nFeature_RNA by Treatment and Sex
create_and_save_plot(
  function() {
    ggplot(so@meta.data, aes(x = Treatment, y = nFeature_RNA, fill = Sex)) +
      geom_boxplot(alpha = 0.7, outlier.shape = 21, outlier.size = 1.5) +
      scale_fill_viridis(discrete = TRUE, begin = 0.3, end = 0.7) +
      theme_publication() +
      labs(title = "Distribution of Features by Treatment and Sex",
           y = "Number of Features",
           x = "Treatment")
  },
  "2_features_by_treatment_sex.png"
)

# 3. Scatter plot of nCount_RNA vs nFeature_RNA, colored by Treatment
create_and_save_plot(
  function() {
    ggplot(so@meta.data, aes(x = nCount_RNA, y = nFeature_RNA, color = Treatment)) +
      geom_point(alpha = 0.6, size = 1) +
      scale_x_log10(labels = comma) +
      scale_y_log10(labels = comma) +
      scale_color_viridis(discrete = TRUE, begin = 0.3, end = 0.7) +
      theme_publication() +
      labs(title = "RNA Counts vs Number of Features",
           subtitle = "Log10 scale",
           x = "Number of RNA Counts",
           y = "Number of Features")
  },
  "3_rna_counts_vs_features.png"
)

# 4. Bar plot of cell counts by sample_description
create_and_save_plot(
  function() {
    so@meta.data %>%
      count(sample_description) %>%
      ggplot(aes(x = reorder(sample_description, n), y = n, fill = n)) +
      geom_bar(stat = "identity", alpha = 0.8) +
      coord_flip() +
      scale_fill_viridis() +
      theme_publication() +
      theme(axis.text.y = element_text(size = rel(0.7))) +
      labs(title = "Number of Cells by Sample",
           x = "Sample Description",
           y = "Number of Cells",
           fill = "Cell Count")
  },
  "4_cell_counts_by_sample.png"
)

# 5. Violin plot of nFeature_RNA by barcode
create_and_save_plot(
  function() {
    ggplot(so@meta.data, aes(x = barcode, y = nFeature_RNA, fill = barcode)) +
      geom_violin(alpha = 0.7) +
      theme_publication() +
      theme(axis.text.x = element_text(angle = 45, hjust = 1, size = rel(0.6)),
            legend.position = "none") +
      scale_fill_viridis(discrete = TRUE) +
      labs(title = "Distribution of Features by Barcode",
           x = "Barcode",
           y = "Number of Features")
  },
  "5_features_by_barcode.png"
)

# 6. Density plot of nCount_RNA by Treatment
create_and_save_plot(
  function() {
    ggplot(so@meta.data, aes(x = nCount_RNA, fill = Treatment)) +
      geom_density(alpha = 0.7) +
      scale_x_log10(labels = comma) +
      scale_fill_viridis(discrete = TRUE, begin = 0.3, end = 0.7) +
      theme_publication() +
      labs(title = "Density of RNA Counts by Treatment",
           subtitle = "Log10 scale",
           x = "Number of RNA Counts",
           y = "Density")
  },
  "6_rna_counts_density_by_treatment.png"
)
