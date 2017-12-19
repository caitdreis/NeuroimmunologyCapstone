
####  LUN workflow   ####

library (R.utils)
library (gdata)

#source("https://bioconductor.org/biocLite.R")
#biocLite("scater")

library (scater)
library (scran)
library (readr)

############################### BRAIN CELLS ##################################################

## COUNT LOADING

readFormat <- function(infile) {
  # First column is empty.
  metadata <- read.delim(infile, stringsAsFactors=FALSE, header=FALSE, nrow=10)[,-1]
  rownames(metadata) <- metadata[,1]
  metadata <- metadata[,-1]
  metadata <- as.data.frame(t(metadata))
  # First column after row names is some useless filler.
  counts <- read.delim(infile, stringsAsFactors=FALSE, header=FALSE, row.names=1, skip=11)[,-1]
  counts <- as.matrix(counts)
  return(list(metadata=metadata, counts=counts))
}

# READ IN THE COUNTS FOR EACH TYPE OF GENE
endo.data <- readFormat("C:/Users/mkw5c/OneDrive/Documents/Capstone/MRNA LUN.txt")
spike.data <- readFormat("C:/Users/mkw5c/OneDrive/Documents/Capstone/ERCC LUN.txt")
mito.data <- readFormat("C:/Users/mkw5c/OneDrive/Documents/Capstone/MITO LUN.txt")
#cell.type<- read_csv("C:/Users/mkw5c/OneDrive/Documents/Capstone/cell types.csv")

#REFORMAT MITO DATA TO BE CONSISTENT WITH OTHERS
m <- match(endo.data$metadata$cell_id, mito.data$metadata$cell_id)
mito.data$metadata <- mito.data$metadata[m,]
mito.data$counts <- mito.data$counts[,m]

#CREATE SINGLE MATRIX FOR SCESET OBJECT AND INCLUDE METADATA #
all.counts <- rbind(endo.data$counts, mito.data$counts, spike.data$counts)
metadata <- AnnotatedDataFrame(endo.data$metadata)
sce <- newSCESet(countData=all.counts, phenoData=metadata)
dim(sce)

#ADD ROWS TO ANNOTATE MITOCHONDRIA AND SPIKES 
nrows <- c(nrow(endo.data$counts), nrow(mito.data$counts), nrow(spike.data$counts))
is.spike <- rep(c(FALSE, FALSE, TRUE), nrows)
is.mito <- rep(c(FALSE, TRUE, FALSE), nrows)

#### QUALITY CONTROL 

sce<- calculateQCMetrics(sce, feature_controls = list(Spike = is.spike, Mt = is.mito))
setSpike(sce)<- "Spike"

#look at library sizes and number of genes expressed
par(mfrow = c(1,2))
hist(sce$total_counts/1e3, xlab = "Library sizes (thousands)", main = "", breaks = 20, col = "grey80", ylab = "Number of Cells")
hist(sce$total_features, xlab = "Number of Expressed Genes", main = "", breaks = 20, col = "grey80", ylab = "Number of Cells")

#The spike-in proportions here are more variable than in the 
#HSC dataset. This may reflect a greater variability in the total 
#amount of endogenous RNA per cell when many cell types are present.

par(mfrow = c(1,2))
hist(sce$pct_counts_feature_controls_Mt, xlab = "Mitochondrial proportion (%)",
     ylab="Number of cells", breaks=20, main="", col="grey80")
hist(sce$pct_counts_feature_controls_Spike, xlab="ERCC proportion (%)",
     ylab="Number of cells", breaks=20, main="", col="grey80")

## remove small outliers from library size and gene expression

cell_drop<-c(which( isOutlier(sce$total_counts, nmads=3, type="lower", log=TRUE)))
libsize.drop <- isOutlier(sce$total_counts, nmads=3, type="lower", log=TRUE)

cell_drop<- c(cell_drop, which(isOutlier(sce$total_features, nmads=3, type="lower", log=TRUE)))
feature.drop <- isOutlier(sce$total_features, nmads=3, type="lower", log=TRUE)

## remove large outliers from spikes and mito
cell_drop<- c(cell_drop, which(isOutlier(sce$pct_counts_feature_controls_Mt, nmads=3, type="higher")))
mito.drop <- isOutlier(sce$pct_counts_feature_controls_Mt, nmads=3, type="higher")

cell_drop<- c(cell_drop, which(isOutlier(sce$pct_counts_feature_controls_Spike, nmads=3, type="higher")))
spike.drop <- isOutlier(sce$pct_counts_feature_controls_Spike, nmads=3, type="higher")

#cells<- cell.type[-cell_drop,]
#write.csv(cells, "C:/Users/mkw5c/OneDrive/Documents/Capstone/cells2902.csv")

##  remove low quality cells by combining filters for all metrics

sce <- sce[,!(libsize.drop | feature.drop | spike.drop | mito.drop)]
data.frame(ByLibSize=sum(libsize.drop), ByFeature=sum(feature.drop),
           ByMito=sum(mito.drop), BySpike=sum(spike.drop), Remaining=ncol(sce))


## use UMI's to get rid of low abundance genes: eliminate technical noise from 
## amplification biases
ave.counts <- rowMeans(counts(sce))

hist(log10(ave.counts), breaks=100, main="", col="grey",
     xlab=expression(Log[10]~"average count"))

#use the histogram to choose a count threshold

keep <- rowMeans(counts(sce)) >= 0.2

abline(v=log10(0.2), col="blue", lwd=2, lty=2)

sce<- sce[keep, ]

nrow(sce)

###reduced our features from 20063 to 8939

#eliminate mitochondrial genes
sce <- sce[!fData(sce)$is_feature_control_Mt,]
nrow(sce)


###Normalization of Cell Specific Biases

# cluster similar cells together and normalize the cells in each cluster using the 
# deconvolution method. This improves normalization accuracy by reducing the number 
# of DE genes between cells in the same cluster

clusters <- quickCluster(sce)
sce <- computeSumFactors(sce, cluster=clusters) #this line is the deconvolution method

plot(sizeFactors(sce), sce$total_counts/1e3, log="xy", 
     ylab="Library size (thousands)", xlab="Size factor")    #these size factors are from the deconv.

#deconvolve spikes
sce <- computeSpikeFactors(sce, type="Spike", general.use=FALSE)

#normalize by size factor
sce <- normalize(sce)

#look at which technical factors may be explaining variability in the data
plotExplanatoryVariables(sce, variables=c("counts_feature_controls_Spike",
                                          "log10_counts_feature_controls_Spike", "sex", "tissue", "age"))
#########################################################################################

#remove ERCC reads before analysis
sce <- sce[!fData(sce)$is_feature_control_Spike,]
dim(sce)

#write the normalized dataset to new file for further analysis
brain<- as.data.frame(sce)
brain[1,c(8850:8861)]
brain<-brain[,1:8860]
brain<-brain[,c(8859, 8860, 8852, 8857,8856, 1:8851)]
brain[1,c(1:10,8846:8856)]


write.csv(brain, "processed_Lun.csv")
#########################################################################################
