# Project Directory Structure

## Overview

This README provides an overview of the directory structure for the Chromium 499 OHagan IUB FLEX15 Mouse May2024 project. The project contains multiple samples, each with its own set of analysis files and outputs.

## Directory Structure

The main project directory is located at:
```
/N/project/cytassist/heather/Chrm_499_OHagan_IUB_FLEX15_Mouse_May2024/Chrm_499_OHagan_IUB_FLEX15_run6/outs/per_sample_outs
```

Each sample is represented by a numbered directory (e.g., 0, 959, 960, etc.). The structure within each sample directory is as follows:

```
sample_number/
├── count/
│   ├── analysis/
│   │   ├── clustering/
│   │   │   ├── gene_expression_graphclust/
│   │   │   │   └── clusters.csv
│   │   │   └── gene_expression_kmeans_X_clusters/ (X = 2 to 10)
│   │   │       └── clusters.csv
│   │   ├── diffexp/
│   │   │   ├── gene_expression_graphclust/
│   │   │   │   └── differential_expression.csv
│   │   │   └── gene_expression_kmeans_X_clusters/ (X = 2 to 10)
│   │   │       └── differential_expression.csv
│   │   ├── pca/
│   │   │   └── gene_expression_10_components/
│   │   │       ├── components.csv
│   │   │       ├── dispersion.csv
│   │   │       ├── features_selected.csv
│   │   │       ├── projection.csv
│   │   │       └── variance.csv
│   │   ├── tsne/
│   │   │   └── gene_expression_2_components/
│   │   │       └── projection.csv
│   │   └── umap/
│   │       └── gene_expression_2_components/
│   │           └── projection.csv
│   ├── probe_set.csv
│   ├── sample_alignments.bam
│   ├── sample_alignments.bam.bai
│   ├── sample_cloupe.cloupe
│   ├── sample_filtered_barcodes.csv
│   ├── sample_filtered_feature_bc_matrix/
│   │   ├── barcodes.tsv.gz
│   │   ├── features.tsv.gz
│   │   └── matrix.mtx.gz
│   ├── sample_filtered_feature_bc_matrix.h5
│   ├── sample_molecule_info.h5
│   ├── sample_raw_feature_bc_matrix/
│   │   ├── barcodes.tsv.gz
│   │   ├── features.tsv.gz
│   │   └── matrix.mtx.gz
│   ├── sample_raw_feature_bc_matrix.h5
│   └── sample_raw_probe_bc_matrix.h5
├── metrics_summary.csv
└── web_summary.html
```

## Key Files and Directories

- `count/`: Contains all count-based analyses and raw data.
  - `analysis/`: Holds various analysis outputs.
    - `clustering/`: Contains clustering results using different methods.
    - `diffexp/`: Contains differential expression analysis results.
    - `pca/`, `tsne/`, `umap/`: Dimension reduction analysis results.
  - `sample_alignments.bam`: Aligned sequencing reads.
  - `sample_filtered_feature_bc_matrix/`: Filtered feature-barcode matrices.
  - `sample_raw_feature_bc_matrix/`: Raw feature-barcode matrices.
- `metrics_summary.csv`: Summary of various metrics for the sample.
- `web_summary.html`: HTML report summarizing the analysis results.

## Notes

- The structure is consistent across all sample directories.
- Each sample directory is named with a number (e.g., 0, 959, 960, etc.).
- The project contains 15 sample directories in total.

## Usage

This directory structure is typically the output of a spatial transcriptomics analysis pipeline. Users can navigate to specific sample directories to access analysis results, raw data, and summary reports for each sample.

For a consolidated view of all web summaries, refer to the `collected_web_summaries` directory, which contains renamed copies of each sample's `web_summary.html` file.

## Additional Information

For more details on the analysis methods or file formats, please refer to the documentation of the analysis pipeline used (e.g., Space Ranger if this is from 10x Genomics).
