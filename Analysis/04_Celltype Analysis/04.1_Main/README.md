<img src="https://github.com/user-attachments/assets/19ebab73-174e-469f-b5d2-0e110dbf6d6c" alt="slide_13" width="300">  Clustree gave us the optimal resolution of *1.5* for further analysis

![Cluster Tree](images/clustree_plot_publication.png)

- ### The Seurat analysis yielded 23 clusters, whose quality was evaluated using the silhouette score.

![silhouette_scores](images/silhouette_scores_plot.png)
![UMAP](images/umap_clusters_publication.png)

- ### Top Gene Expression Markers in each Cluster,

![Heatmap](images/top_10_marker_genes_per_cluster_heatmap_improved.pdf)


# Cluster Annotation
### The clusters were annotated using two mouse datasets, SingleR and ImmGen, along with manual annotation based on marker genes. This process led to the identification of 7 final clusters.
### UMAP Plots (SingleR)

<table>
  <tr>
    <td>
      <strong>SingleR Mouse-dataset UMAP Plot</strong><br>
      <img src="https://github.com/user-attachments/assets/ad7c0b6d-1d3d-4e32-84fc-174d567d2b95" alt="SingleR UMAP Plot" width="500">
    </td>
    <td>
      <strong>ImmGen UMAP Plot</strong><br>
      <img src="https://github.com/user-attachments/assets/69e32d15-4510-4d78-ae35-6797299fc669" alt="ImmGen UMAP Plot" width="500">
    </td>
  </tr>
</table>


### 🌟Celltypes:

- 1. Epithelial Cells (Epcam, Krt8, Krt18)
- 2. Endothelial Cells (Cldn5, Rgs5)
- 3. T Cells (3d3d, Foxp3, Lag3)
- 4. B Cells (Cd79a)
- 6. Myeloids (Mrc1, Tgfb1, Cxcl12, Antxr1)
- 7. Dendritic Cells (DCs) (Cd1c, Lamp3)
- 8. Fibroblasts (Fap, Pdpn, Cd248, Pdgfra, Pdgfrb, Sema3c) 
- 9. Others

# Marker Genes Feature plots
![fibro_featureplot](https://github.com/user-attachments/assets/502378d1-ab63-4750-b22e-ab83cdfa680f)

![epit_featureplt](https://github.com/user-attachments/assets/1d49c3e7-be94-4d1c-a4b2-e6c2d42d14ec)

![tcells](https://github.com/user-attachments/assets/706a1920-b2e0-4317-a7ab-4bb709645cb6)
![mylo_f](https://github.com/user-attachments/assets/3655b062-9948-4baa-bfc5-c66542aea8c4)


## Final Umap
![all_cells_umap](https://github.com/user-attachments/assets/ede3631e-8d92-43a3-af4c-014624b63224)




