
write_path = "C:\\Users\\mkw5c\\OneDrive\\Documents\\Neuro Capstone\\SPRING\\seurat genesets 3.22\\"
###----- Seurat Analysis

library(devtools)
#install_github("satijalab/seurat", ref = "develop")
library(Seurat)

###----- CORTEX
#-- Data
cortex<- read.csv("cortex_df.csv")


#rownames(cortex)<- cortex[,1]
#cortex[,1]<- NULL
cortex_red<- cortex[1:1677, c(1:19804, 19896)]

c1 = which(cortex_red$cluster_mem == "1")
c2 = which(cortex_red$cluster_mem == "2")
c3 = which(cortex_red$cluster_mem == "3")
c4 = which(cortex_red$cluster_mem == "4")
c5 = which(cortex_red$cluster_mem == "5")
c6 = which(cortex_red$cluster_mem == "6")
c7 = which(cortex_red$cluster_mem == "7")
c8 = which(cortex_red$cluster_mem == "8")
c9 = which(cortex_red$cluster_mem == "9")
c10 = which(cortex_red$cluster_mem == "10")
c11= which(cortex_red$cluster_mem == "11")
c12 = which(cortex_red$cluster_mem == "12")


cortex_t<- t(cortex_red)
#colnames(cortex_t) <- cortex_t[1, ]
cortex_t<- cortex_t[1:19804, ]
class(cortex_t)<- "numeric"

#---- create Seurat object and label identities

cortex_S<- CreateSeuratObject(raw.data = cortex_t, cell.names = colnames(cortex_t))

cortex_S<- SetIdent(cortex_S, cells.use = c1, ident.use = "cluster1")
cortex_S<- SetIdent(cortex_S, cells.use = c2, ident.use = "cluster2")
cortex_S<- SetIdent(cortex_S, cells.use = c3, ident.use = "cluster3")
cortex_S<- SetIdent(cortex_S, cells.use = c4, ident.use = "cluster4")
cortex_S<- SetIdent(cortex_S, cells.use = c5, ident.use = "cluster5")
cortex_S<- SetIdent(cortex_S, cells.use = c6, ident.use = "cluster6")
cortex_S<- SetIdent(cortex_S, cells.use = c7, ident.use = "cluster7")
cortex_S<- SetIdent(cortex_S, cells.use = c8, ident.use = "cluster8")
cortex_S<- SetIdent(cortex_S, cells.use = c9, ident.use = "cluster9")
cortex_S<- SetIdent(cortex_S, cells.use = c10, ident.use = "cluster10")
cortex_S<- SetIdent(cortex_S, cells.use = c11, ident.use = "cluster11")
cortex_S<- SetIdent(cortex_S, cells.use = c12, ident.use = "cluster12")




#---- view levels to differentiate between
ident_levels_C = levels(cortex_S@ident)
ident_levels_H = levels(hippo_S@ident)

###----- find the differentially expressed genes for each cluster against all other clusters

#--- cortex 
 for (i in ident_levels_C){
   print(i)
   DE_genes<- FindMarkers(cortex_S, ident.1 = i, ident.2 = NULL, only.pos = TRUE)
   file = paste0("DE_cortex_", i, ".csv")
   write.csv(DE_genes, paste0(write_path, file))
 }


#--- HIPPOCAMPUS
#-- Data
hippoc<- read.csv("hippocampus_df.csv")


#rownames(hippoc)<- hippoc[,1]
#hippoc[,1]<- NULL
hippoc_red<- hippoc[1:1312, c(1:19804, 19896)]

c1 = which(hippoc_red$cluster_mem == "1")
c2 = which(hippoc_red$cluster_mem == "2")
c3 = which(hippoc_red$cluster_mem == "3")
c4 = which(hippoc_red$cluster_mem == "4")
c5 = which(hippoc_red$cluster_mem == "5")
c6 = which(hippoc_red$cluster_mem == "6")
c7 = which(hippoc_red$cluster_mem == "7")
c8 = which(hippoc_red$cluster_mem == "8")
c9 = which(hippoc_red$cluster_mem == "9")
c10 = which(hippoc_red$cluster_mem == "10")
c11= which(hippoc_red$cluster_mem == "11")
c12 = which(hippoc_red$cluster_mem == "12")
c13 = which(hippoc_red$cluster_mem == "13")
c14 = which(hippoc_red$cluster_mem == "14")
c15= which(hippoc_red$cluster_mem == "15")
c16 = which(hippoc_red$cluster_mem == "16")

hippoc_t<- t(hippoc_red)
#colnames(hippoc_t) <- hippoc_t[1, ]
hippoc_t<- hippoc_t[2:19804, ]
class(hippoc_t)<- "numeric"

#---- create Seurat object and label identities
hippoc_S<- CreateSeuratObject(raw.data = hippoc_t, cell.names = colnames(hippoc_t))

hippoc_S<- SetIdent(hippoc_S, cells.use = c1, ident.use = "1")
hippoc_S<- SetIdent(hippoc_S, cells.use = c2, ident.use = "2")
hippoc_S<- SetIdent(hippoc_S, cells.use = c3, ident.use = "3")
hippoc_S<- SetIdent(hippoc_S, cells.use = c4, ident.use = "4")
hippoc_S<- SetIdent(hippoc_S, cells.use = c5, ident.use = "5")
hippoc_S<- SetIdent(hippoc_S, cells.use = c6, ident.use = "6")
hippoc_S<- SetIdent(hippoc_S, cells.use = c7, ident.use = "7")
hippoc_S<- SetIdent(hippoc_S, cells.use = c8, ident.use = "8")
hippoc_S<- SetIdent(hippoc_S, cells.use = c9, ident.use = "9")
hippoc_S<- SetIdent(hippoc_S, cells.use = c10, ident.use = "10")
hippoc_S<- SetIdent(hippoc_S, cells.use = c11, ident.use = "11")
hippoc_S<- SetIdent(hippoc_S, cells.use = c12, ident.use = "12")
hippoc_S<- SetIdent(hippoc_S, cells.use = c13, ident.use = "13")
hippoc_S<- SetIdent(hippoc_S, cells.use = c14, ident.use = "14")
hippoc_S<- SetIdent(hippoc_S, cells.use = c15, ident.use = "15")
hippoc_S<- SetIdent(hippoc_S, cells.use = c16, ident.use = "16")


#---- view levels to differentiate between
ident_levels_H = levels(hippoc_S@ident)

###----- find the differentially expressed genes for each cluster against all other clusters
for (i in ident_levels_H){
  print(i)
  DE_genes<- FindMarkers(hippoc_S, ident.1 = i, ident.2 = NULL, only.pos = TRUE)
  file = paste0("DE_hippoc_", i, ".csv")
  write.csv(DE_genes, paste0(write_path, file))
}
