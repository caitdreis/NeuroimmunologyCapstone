

###---- Assign Cluster Labels

#--- libraries
library(Seurat)
library(dplyr)
library(Matrix)

#--- normalized and clulstered data in s4 object

#-- Data
hippoc<- read.csv("hippocampus_df.csv")


#rownames(hippoc)<- hippoc[,1]
#hippoc[,1]<- NULL
hippoc_red<- hippoc[1:1312, c(2:19804, 19896)]

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


#--- plots
VlnPlot(hippoc_S, "Thy1" ) # 1 4,5,6,7,9, 10,11,13,16 Neurons
VlnPlot(hippo_S, "Gad1" ) # 6, 7 Interneurons
VlnPlot(hippo_S, c("Dlx1", "Dlx2", "Dlx5")) #6, 7 Interneurons
VlnPlot(hippo_S, c("Lhx6", "Reln", "Gabrd")) # 6

VlnPlot(hippo_S, c("Spink8"))  # 4,5, 10, 11 C1 pyramimdal
VlnPlot(hippo_S, c("Pcp4"))  # 9 CA2 pyramimdal
VlnPlot(hippo_S, c("Ly6g6e"))  # 9 C1 pyramimdal subiculum
VlnPlot(hippo_S, c("Calb1", "Nov")) # 4,5,9,10,11,13  CA1 layer
VlnPlot(hippo_S, c("Wfs1", "Grp")) # 4,5,9,13 dorsoventral CA1




VlnPlot(hippo_S, "Hapln2")   # 2, 3  Oligodendrocytes
VlnPlot(hippo_S, "Mbp" ) # 2, 3 oligo
VlnPlot(hippo_S, "Plp1" ) # 2, 3 olig


VlnPlot(hippo_S, c("Acta2")) # 14  Mural

VlnPlot(hippo_S, c("Ly6c1")) # 14 Endothelial
VlnPlot(hippo_S, c("Cldn5")) # 14  Endothelial

VlnPlot(hippo_S, c("Aldoc")) # 1 (?), 8 astrocytes
VlnPlot(hippo_S, c("Gfap")) # 8 astrocytes (layer 1) 
VlnPlot(hippo_S, c("Mfge8")) # 1, 8, 14 astrocytes (uniform)
VlnPlot(hippo_S, c("Id4")) # 8, 12
VlnPlot(hippo_S, c("Rfx4")) # 8, 12


VlnPlot(hippo_S, c("Aif1")) # 15 microglia
VlnPlot(hippo_S, c("Cx3cr1")) # 15 microglia

VlnPlot(hippo_S, c("Mrc1")) # 15 macrophage
VlnPlot(hippo_S, c("Lyve1")) # 15 macrophage
