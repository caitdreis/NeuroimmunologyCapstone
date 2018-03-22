
#----- resources

#--- https://guangchuangyu.github.io/2016/01/go-analysis-using-clusterprofiler/
#--- https://github.com/GuangchuangYu/DOSE/wiki/how-to-prepare-your-own-geneList

#---- install the cluster profiler package
#source("https://bioconductor.org/biocLite.R")
#biocLite("clusterProfiler")

#---- libraries

library(readr)
library(clusterProfiler)

#----- set paths

path_to_read = "C:\\Users\\mkw5c\\OneDrive\\Documents\\Neuro Capstone\\SPRING\\median genesets 3.21\\"
path_to_write  = "C:\\Users\\mkw5c\\OneDrive\\Documents\\Neuro Capstone\\SPRING\\median results 3.22\\"

#-----define the files that you want to perform the enrichment on

#--- **files should be saved in format: "hippoc_##.txt" or "cortex_##.txt" where ##
#                                        is the cluster number (eg. 01, 02...16)

files = dir(path_to_read, 
            recursive = TRUE, 
            pattern="*.rnk", 
            full.names=T)

#----- GSEA run the analysis!

for (file in files){
  d <- read.delim(file, header = F)
  gene_list<- d[,2]
  names(gene_list)<- as.character(d[,1])
  gene_list<- sort(gene_list, decreasing = T)
  
  GSEA_results<- gseGO(gene_list, ont = "BP", OrgDb = "org.Mm.eg.db", keyType = "SYMBOL", exponent = 1,
                       nPerm = 1000, minGSSize = 130, maxGSSize = 2000, pvalueCutoff = 0.05,
                       pAdjustMethod = "BH", verbose = F, by = "fgsea")

  file = paste0("med_GSEAresults_cluster", substr(file, 105, 106), "_", substr(file, 78, 83), ".csv")
  write.csv(as.data.frame(GSEA_results), paste0(path_to_write, file))
}


#----- OREA run the analysis!

for (file in files){
  d <- read.delim(file, header = F)
  gene_list<- d[,2]
  names(gene_list)<- as.character(d[,1])
  gene_list<- sort(gene_list, decreasing = T)
  
  OREA_results<- enrichGO(names(gene_list[1:500]), OrgDb = "org.Mm.eg.db", keyType = "SYMBOL", ont = "BP",
                          pvalueCutoff = 0.05, pAdjustMethod = "BH", universe = names(gene_list), qvalueCutoff = 0.2,
                          minGSSize = 10, maxGSSize = 1000)
  
  file = paste0("ae_OREAresults_cluster", substr(file, 98, 99), "_", substr(file, 85, 89), "_node_", substr(file, 135, 136), ".csv")
  write.csv(OREA_results, paste0(path_to_write, file, ".csv"))
  
}


#---- Compare results to WEBgestalt
auto<- read_csv("GSEAresults_cluster_.csv")
webg<- read_tsv("test_webg_cluster1.txt")

