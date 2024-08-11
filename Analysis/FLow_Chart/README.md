# 🧬 Single-cell RNA-seq Analysis of Therapy-induced Transdifferentiation in BRAF Mutant Colorectal Cancer

## 🔬 Project Overview
![Project Overview](https://github.com/ateeq-khaliq/BRAF-Mutant-Colorectal-Cancer-Mouse/blob/main/Analysis/images/picture_4.png)



This cutting-edge study investigates therapy-induced transdifferentiation in BRAF mutant colorectal cancer using single-cell RNA sequencing. Our goal is to unravel cellular heterogeneity, identify novel cell states, and discover mechanisms of treatment response and resistance.

**Principal Investigator:** Ashiq Masood, MD. Ph.D.  
**Institution:** Indiana University School of Medicine

## 📊 Experimental Design

- **Total Samples:** 15
  - 8 Vehicle-treated (4 male, 4 female)
  - 7 Inhibitor-treated (4 male, 3 female)
- **Model:** Syngeneic orthotopic BRAFV600E colorectal cancer
- **Treatment:** Encorafenib (BRAFi) + Gefitinib/Cetuximab (EGFRi)
- 

Details:

1. Vehicle-treated samples:
   - Females: 3 samples (Barcodes: BC1, BC2, BC3)
   - Males: 4 samples (Barcodes: BC7, BC8, BC9, BC10)

2. Inhibitor-treated samples:
   - Females: 3 samples (Barcodes: BC4, BC5, BC6)
   - Males: 5 samples (Barcodes: BC11, BC12, BC13, BC14, BC15)

## 🔄 Analysis Workflow

1. 🧫 Sample Collection and Preparation
2. 🧪 Single-cell RNA Sequencing (10x Genomics)
3. 💻 Raw Data Processing (CellRanger)
4. 🔍 Quality Control and Filtering
5. 📊 Data Integration and Normalization (Seurat)
6. 📉 Dimensionality Reduction (PCA, UMAP, t-SNE)
7. 🏷️ Clustering and Cell Type Identification
8. 📈 Differential Expression Analysis
9. 🔀 Trajectory Analysis (Monocle 3)
10. 🕸️ Gene Regulatory Network Analysis (SCENIC)
11. 🤝 Cell-Cell Interaction Analysis (CellPhoneDB)
12. 💊 Treatment Response Characterization
13. 🗺️ Spatial Transcriptomics Integration
14. 🧮 Multimodal Data Integration
15. 🤖 Machine Learning for Predictive Modeling

## 🧫 Expected Cell Types

- **Colorectal Cancer Cells**
  - Proliferative
  - Quiescent
  - EMT-like
  - Stem-like
- **Immune Cells**
  - T Cells
  - B Cells
  - Macrophages
  - NK Cells
- **Stromal Cells**
  - Fibroblasts
  - Endothelial Cells
- **Specialized Epithelial**
  - Enteroendocrine Cells
  - Goblet Cells
  - Paneth Cells

## 🎯 Key Analyses and Expected Outcomes

1. **Cellular Heterogeneity Mapping**
   - Comprehensive atlas of cell types and states
   - Identification of rare cell populations

2. **Treatment-Induced Cellular Plasticity**
   - Characterization of therapy-induced cell state transitions
   - Focus on enteroendocrine cell transdifferentiation

3. **Resistance Mechanisms**
   - Identification of resistant cell populations
   - Gene programs involved in resistance

4. **Tumor Microenvironment Interactions**
   - Analysis of tumor-immune cell interactions
   - Stromal contributions to tumor progression

5. **Biomarker Discovery**
   - Predictive biomarkers for treatment response
   - Potential targets for combination therapies

## 🛠️ Secondary Analyses

### 1. 🔀 Trajectory Analysis
- Use Monocle 3 to reconstruct cellular differentiation paths
- Identify branching points in cell fate decisions
- Map therapy-induced state transitions

### 2. 🕸️ Gene Regulatory Network Analysis
- Apply SCENIC to infer transcription factor activities
- Construct cell-type-specific regulatory networks
- Identify master regulators of cell states

### 3. 🤝 Cell-Cell Interaction Analysis
- Utilize CellPhoneDB to predict ligand-receptor interactions
- Map communication networks within the tumor microenvironment
- Identify therapy-induced changes in cellular communication

### 4. 🗺️ Spatial Transcriptomics Integration
- Integrate scRNA-seq data with spatial transcriptomics
- Map cell types and states to specific tissue regions
- Analyze spatial organization of tumor and stromal cells

### 5. 🧮 Multimodal Data Integration (IF NEEDED)
- Integrate scRNA-seq with other omics data (e.g., ATAC-seq, proteomics)
- Perform multi-omics factor analysis (MOFA)
- Gain holistic insights into cellular states and functions

### 6. 🦠 Microbial Analysis  (IF NEEDED)
- Identify microbial signatures in tumor samples
- Analyze host-microbiome interactions
- Investigate microbial influences on treatment response

### 7. 🧬 Copy Number Variation Analysis
- Infer CNVs from scRNA-seq data
- Characterize subclonal architecture
- Link genomic alterations to transcriptomic states

### 8. 🤖 Machine Learning for Predictive Modeling
- Develop ML models to predict treatment response
- Identify key features for patient stratification
- Create a decision support tool for personalized therapy

## 🛠️ Key Tools and Technologies

- **Sequencing:** Illumina NovaSeq, 10x Genomics Chromium
- **Primary Analysis:** CellRanger, Seurat, Scanpy
- **Trajectory Analysis:** Monocle 3, Velocity
- **Network Analysis:** SCENIC, GRNBoost
- **Cell-Cell Interaction:** CellPhoneDB, NicheNet
- **Spatial Analysis:** STutility, Giotto
- **Multimodal Integration:** MOFA, Seurat v4
- **Machine Learning:** scikit-learn, TensorFlow

## 📞 Contact Information

**Dr.Ateeq Khaliq**  
📧 Email: akhaliq@iu.edu  
🏢 Office: HITS Sciences Building, Room 5005

🏫 Indiana University School of Medicine

---

<p align="center">
  <em>Advancing colorectal cancer research through comprehensive single-cell genomics and integrative analyses 🤝 </em>
</p>
