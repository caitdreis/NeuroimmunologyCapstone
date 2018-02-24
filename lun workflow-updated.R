

#------ Libraries

library (R.utils)
library (gdata)

#source("https://bioconductor.org/biocLite.R")
#biocLite("scater")
#biocLite('scran')
#biocLite('GenomicRanges')

library (scater)
library (scran)
library (readr)
library (SingleCellExperiment)
library(org.Mm.eg.db)
library(namespace)

#------ Function to read in data

readFormat <- function(infile) { 
  # First column is empty.
  metadata <- read.delim(infile, stringsAsFactors=FALSE, header=FALSE, nrow=10)[,-1] 
  rownames(metadata) <- metadata[,1]
  metadata <- metadata[,-1]
  metadata <- as.data.frame(t(metadata))
  
  # First column after row names is some useless filler.
  counts <- read.delim(infile, stringsAsFactors=FALSE, 
                       header=FALSE, row.names=1, skip=11)[,-1] 
  counts <- as.matrix(counts)
  return(list(metadata=metadata, counts=counts))
}
#------- Read in the Data

endo.data <- readFormat("C:\\Users\\mkw5c\\OneDrive\\Documents\\Neuro Capstone\\TFIDF\\MRNA LUN.txt")
spike.data <- readFormat("C:\\Users\\mkw5c\\OneDrive\\Documents\\Neuro Capstone\\TFIDF\\ERCC LUN.txt")
mito.data <- readFormat("C:\\Users\\mkw5c\\OneDrive\\Documents\\Neuro Capstone\\TFIDF\\MITO LUN.txt")

#------- Reorder Mito data to be consistent with others
m <- match(endo.data$metadata$cell_id, mito.data$metadata$cell_id)
mito.data$metadata <- mito.data$metadata[m,]
mito.data$counts <- mito.data$counts[,m]

#-------- sum the counts for all rows that represent the same gene but at different locations
raw.names <- sub("_loc[0-9]+$", "", rownames(endo.data$counts))
new.counts <- rowsum(endo.data$counts, group=raw.names, reorder=FALSE)
endo.data$counts <- new.counts

#------- Create a single SCE object with all of the data
all.counts <- rbind(endo.data$counts, mito.data$counts, spike.data$counts)
#metadata <- AnnotatedDataFrame(endo.data$metadata)
sce <- SingleCellExperiment(list(counts=all.counts), colData=endo.data$metadata) #sce <- newSCESet(countData=all.counts, phenoData=metadata)
dim(sce)


#-------- Add rows to annotate mito and spike data
nrows <- c(nrow(endo.data$counts), nrow(mito.data$counts), nrow(spike.data$counts))
is.spike <- rep(c(FALSE, FALSE, TRUE), nrows)
is.mito <- rep(c(FALSE, TRUE, FALSE), nrows)

#-------- Explicitly indicate the Spike In data
isSpike(sce, "Spike") <- is.spike


#-------- Add ensembl IDs
ensembl <- mapIds(org.Mm.eg.db, keys=rownames(sce), keytype="SYMBOL", column="ENSEMBL")
rowData(sce)$ENSEMBL <- ensembl


#-------- Calculate quality control metrics
sce<- calculateQCMetrics(sce, feature_controls = list(Spike = is.spike, Mt = is.mito))

 
#-------- Look at the library sizes and number of genes expressed
par(mfrow = c(1,2), mar = c(5.1, 4.1, 0.1, 0.1))

#too small library size: cell wasn't successfully captured during library preparation
hist(sce$total_counts/1e3, xlab = "Library sizes (thousands)", main = "", breaks = 20, col = "grey80", ylab = "Number of Cells")

#low numbers of expressed genes (non-zero counts): gene transcript diversity wasn't succesfully captured
hist(sce$total_features, xlab = "Number of Expressed Genes", main = "", breaks = 20, col = "grey80", ylab = "Number of Cells")

#--------- Look at the proportions of spike in data for each gene: greater variability may reflect
#           greater variability in the total amount of endogenous RNA per cell when many 
#           cell types are present.

hist(sce$pct_counts_Mt, xlab = "Mitochondrial proportion (%)",
     ylab="Number of cells", breaks=20, main="", col="grey80")
hist(sce$pct_counts_Spike, xlab="ERCC proportion (%)",
     ylab="Number of cells", breaks=20, main="", col="grey80")

#--------- Remove low quality cells
libsize.drop <- isOutlier(sce$total_counts, nmads=3, type="lower", log=TRUE)
feature.drop <- isOutlier(sce$total_features, nmads=3, type="lower", log=TRUE)
#mito.drop <- isOutlier(sce$pct_counts_feature_controls_Mt, nmads=3, type="higher")
spike.drop <- isOutlier(sce$pct_counts_Spike, nmads=3, type="higher")


sce <- sce[,!(libsize.drop | feature.drop | spike.drop)]
data.frame(ByLibSize=sum(libsize.drop), ByFeature=sum(feature.drop),
           BySpike=sum(spike.drop), Remaining=ncol(sce))


#--------- Assign Cell Cycle Phase
#mm.pairs <- readRDS(system.file("exdata", "mouse_cycle_markers.rds", package="scran"))
#assignments <- cyclone(sce, mm.pairs, gene.names=rowData(sce)$ENSEMBL)
#table(assignments$phase)


#--------- Examine gene level metrics
fontsize <- theme(axis.text=element_text(size=12), axis.title=element_text(size=16))
#plotQC(sce, type = "highest-expression", n=50) + fontsize

#--------- Use UMI's to get rid of low abubndance genes
#           elimnates technical noise from amplification biases
ave.counts <- calcAverage(sce)

hist(log10(ave.counts), breaks=100, main="", col="grey",
     xlab=expression(Log[10]~"average count"))

#-------- use the histogram to choose a count threshold
rowData(sce)$ave.count<- ave.counts
keep <- ave.counts > 0

abline(v=log10(0.1), col="blue", lwd=2, lty=2)

sce<- sce[keep, ]
summary(keep)


#--------- Remove mitochondrial data
#sce <- sce[!fData(sce)$is_feature_control_Mt,]

#--------- Uses quick cluster to similar cells and 
#         then normalize cells in each cluster using the deconvolution method
high.ave <- rowData(sce)$ave.count >= 0.1
clusters <- quickCluster(sce, subset.row = high.ave, method = "igraph")
sce <- computeSumFactors(sce, cluster=clusters, subset.row = high.ave, min.mean = NULL)
summary(sizeFactors(sce))

#--------- Plot the size factors vs Library Size for each cell
plot(sizeFactors(sce), sce$total_counts/1e3, log="xy",
     ylab="Library size (thousands)", xlab="Size factor")

#------- compute size factors relative to the spike in set
sce <- computeSpikeFactors(sce, type="Spike", general.use=FALSE)

#------- normalize the cells
sce <- normalize(sce)



#-----identify highly variable genes
#fit a trend to the technical variance for the spike in transcripts
var.fit <- trendVar(sce, parametric=TRUE, span=0.4)

#compute the biological component of the variance for each endogenous gene by 
#subtracting the fitted value of the trend from the total variance
var.out <- decomposeVar(sce, var.fit)

plot(var.out$mean, var.out$total, pch=16, cex=0.6, xlab="Mean log-expression", 
     ylab="Variance of log-expression")
points(var.out$mean[isSpike(sce)], var.out$total[isSpike(sce)], col="red", pch=16)
curve(var.fit$trend(x), col="dodgerblue", add=TRUE, lwd=2)


chosen.genes <- order(var.out$bio, decreasing=TRUE)[1:10]
plotExpression(sce, rownames(var.out)[chosen.genes], 
               alpha=0.05, jitter="jitter") + fontsize

#--------- Denoise using PCA: gives x,y coordinates with 
sce <- denoisePCA(sce, technical=var.fit$trend, approximate=TRUE)
ncol(reducedDim(sce, "PCA"))


#save the full normalized dataset
saveRDS(file="normalized_Lun_data.rds", sce)


#-------------------- SPLIT THE DATA ------------------------------#

levels(sce$tissue)
#[1] ""               "ca1hippocampus" "sscortex" 

hippocampus <- sce[, sce$tissue=='ca1hippocampus']
#1303 single cells from hippocampus

cortex <- sce[, sce$tissue=='sscortex']
#1599 single cells from cortex



#------------------ RE-CLUSTER CELLTYPES FOR EACH REGION -------------#

#--------------HIPPOCAMPUS

#---------- reduce dimensionality using TSNE on the correlated HVGs
hippocampus2 <- runTSNE(hippocampus, use_dimred="PCA", perplexity=10, rand_seed=100)
tsne1 <- plotTSNE(hippocampus2, colour_by="Neurod6") + fontsize
tsne2 <- plotTSNE(hippocampus2, colour_by="Mog") + fontsize
multiplot(tsne1, tsne2, cols=2)

#------------ show that PCA is less effective at clustering these pops than tSNE
# pca1 <- plotReducedDim(hippocampus, use_dimred="PCA", colour_by="Neurod6") + fontsize
# pca2 <- plotReducedDim(hippocampus, use_dimred="PCA", colour_by="Mog") + fontsize
# multiplot(pca1, pca2, cols=2)

#---------- cluster using shared nearest neighbors
snn.gr <- buildSNNGraph(hippocampus2, use.dimred="PCA")
cluster.out <- igraph::cluster_walktrap(snn.gr)
hippo.clusters <- cluster.out$membership
table(hippo.clusters)

#-------- modularity scores appraoching 1 imply that the detected clusters are
#         enriched for internal edges with relatively few edges between clusters. 
igraph::modularity(cluster.out)
#[1] 0.6214083  in full it was 0.75


#------- determine how successfully the cells were clustered
uclust <- sort(unique(hippo.clusters))
nclust <- length(uclust)
mod.mat <- matrix(0, nclust, nclust)
rownames(mod.mat) <- colnames(mod.mat) <- uclust

# Calculating total weight within/between clusters.
library(Matrix)
grmat <- snn.gr[]
for (x in uclust) { 
  current <- hippo.clusters==x
  for (y in uclust) { 
    other <- hippo.clusters==y
    mod.mat[x,y] <- sum(grmat[current,other])
  }
}

# Calculating expected matrix under the null, and comparing to observed.
total.weight <- colSums(mod.mat)/sum(mod.mat)
expected.mat <- tcrossprod(total.weight) * sum(mod.mat)
ratio <- log10(mod.mat/expected.mat + 1)
library(pheatmap)
pheatmap(ratio, cluster_rows=FALSE, cluster_cols=FALSE, 
         color=colorRampPalette(c("white", "blue"))(100))

#-------- visualize the clusters on the tSNE plot
hippocampus$cluster <- factor(hippo.clusters)
plotTSNE(hippocampus2, colour_by="cluster") + fontsize

###########################################################
###########################################################

#--------- Cortex Clustering

#---------- reduce dimensionality using TSNE on the correlated HVGs
cortex2 <- runTSNE(cortex, use_dimred="PCA", perplexity=10, rand_seed=100)
tsne1 <- plotTSNE(cortex2, colour_by="Neurod6") + fontsize
tsne2 <- plotTSNE(cortex2, colour_by="Mog") + fontsize
multiplot(tsne1, tsne2, cols=2)

#------------ show that PCA is less effective at clustering these pops than tSNE
pca1 <- plotReducedDim(cortex, use_dimred="PCA", colour_by="Neurod6") + fontsize
pca2 <- plotReducedDim(cortex, use_dimred="PCA", colour_by="Mog") + fontsize
multiplot(pca1, pca2, cols=2)

#---------- cluster using shared nearest neighbors
snn.gr <- buildSNNGraph(cortex2, use.dimred="PCA")
cluster.out <- igraph::cluster_walktrap(snn.gr)
cortex.clusters <- cluster.out$membership
table(cortex2.clusters)

#-------- modularity scores appraoching 1 imply that the detected clusters are
#         enriched for internal edges with relatively few edges between clusters. 
igraph::modularity(cluster.out)
#[1] 0.7015699  in full it was 0.75


#------- determine how successfully the cells were clustered
uclust <- sort(unique(cortex.clusters))
nclust <- length(uclust)
mod.mat <- matrix(0, nclust, nclust)
rownames(mod.mat) <- colnames(mod.mat) <- uclust

# Calculating total weight within/between clusters.
library(Matrix)
grmat <- snn.gr[]
for (x in uclust) { 
  current <- cortex.clusters==x
  for (y in uclust) { 
    other <- cortex.clusters==y
    mod.mat[x,y] <- sum(grmat[current,other])
  }
}

# Calculating expected matrix under the null, and comparing to observed.
total.weight <- colSums(mod.mat)/sum(mod.mat)
expected.mat <- tcrossprod(total.weight) * sum(mod.mat)
ratio <- log10(mod.mat/expected.mat + 1)
library(pheatmap)
pheatmap(ratio, cluster_rows=FALSE, cluster_cols=FALSE, 
         color=colorRampPalette(c("white", "blue"))(100))

#-------- visualize the clusters on the tSNE plot
cortex$cluster <- factor(cortex.clusters)
plotTSNE(cortex2, colour_by="cluster") + fontsize


#save the full normalized dataset
saveRDS(file="hippocampus_tsne_coord.rds", hippocampus2)
saveRDS(file="cortex_tsne_coord.rds", cortex2)
saveRDS(file="cortex_norm.rds", cortex)
saveRDS(file="hippocampus_norm.rds", hippocampus)

#------  save the count data as csv and bind cluster membership

hippo.mat<- as.matrix(logcounts(hippocampus))
hippo.df<- as.data.frame(t(hippo.mat))
hippo.df$cluster_mem<- hippo.clusters

cortex.mat<- as.matrix(logcounts(cortex))
cortex.df<- as.data.frame(t(cortex.mat))
cortex.df$cluster_mem<- cortex.clusters

write.csv(hippo.df, "hippocampus_df.csv", row.names = TRUE)
write.csv(cortex.df, "cortex_df.csv", row.names = TRUE)


