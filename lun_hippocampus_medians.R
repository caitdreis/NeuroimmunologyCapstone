
write_path = "C:\\Users\\mkw5c\\OneDrive\\Documents\\Neuro Capstone\\SPRING\\median genesets 3.22\\"

hippo<- read.csv("hippocampus_df.csv")
rownames(hippo)<- hippo[,1]
hippo[,1]<- NULL

#----- remove mitochondrial and spike in data
hippo_red<- hippo[1:1312, c(1:19803, 19895)]

#----- libraries
library(readr) 
library(tm)
library(tidytext) 
library(plyr) 
library(dplyr) 
library(ggplot2)

#------ reshape the dataframe 
hippo_reshape<- cbind(hippo$cluster_mem, stack(hippo[1:19803]))
hippo_reshape[1:5, ]

#------ rename the columns
colnames(hippo_reshape)<- c("cluster", "expression", "gene")

#------ check data types and for missing values
str(hippo_reshape)
sum(is.na(hippo_reshape["expression"]))

#------ verify that there are 16 clusters
unique(hippo_reshape$cluster)

#------ group by cluster and determine the total and median expression 
#       levels for each gene
hippo_reshape$gene<- as.character(hippo_reshape$gene)
hippo_reshape$expression<- as.numeric(hippo_reshape$expression)
hippo_reshape$cluster<- as.character(hippo_reshape$cluster)

hippo_grouped<- do.call(data.frame, aggregate(hippo_reshape$expression, 
                                              by=list(hippo_reshape$cluster, hippo_reshape$gene), 
                                              FUN=function(x) c(med.exp = median(x),avg.exp = mean(x), total.exp = sum(x))))

#----- make a copy
hippo_copy<- hippo_grouped
hippo_copy[1:5, 1:5]

#----- rename the columns
colnames(hippo_copy)<- c("cluster", "gene", "med.exp", "avg.exp", "total.exp")
colnames(hippo_grouped)<- c("cluster", "gene", "med.exp", "avg.exp", "total.exp")


#----- sort the genes by MEDIAN expression within a cluster
print_hippo <- hippo_grouped %>%  
  dplyr::arrange(desc(med.exp))  %>%                                          
  dplyr::mutate(gene = factor(gene, levels = rev(unique(gene)))) %>%           
  dplyr::mutate(cluster = factor(cluster, levels = rev(unique(cluster))))

print_me<- arrange(print_hippo, cluster, desc(med.exp))

save_the_genes<- function(df, clust_count){
  for (i in 1:clust_count){
    clust_genes<- df[which(df$cluster == i),c(2, 3)]
    file =  ifelse(i < 10, paste0("med_hippo_0", i, ".txt"), paste0("med_hippo_", i, ".txt"))
    write.table(clust_genes, paste0(write_path, file), sep = "\t", row.names = F, col.names = F)}}


save_the_genes(print_me, 16)

length(unique(print_me[(print_me$cluster == 4), ]$gene))






