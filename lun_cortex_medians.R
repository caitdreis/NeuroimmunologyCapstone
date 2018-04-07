
write_path = "C:\\Users\\mkw5c\\OneDrive\\Documents\\Neuro Capstone\\SPRING\\median genesets 3.22\\"
  
  
cortex<- read.csv("cortex_df.csv")
rownames(cortex)<- cortex[,1]
cortex[,1]<- NULL

#----- remove mitochondrial and spike in data
cortex_red<- cortex[1:1677, c(1:19803, 19895)]

#----- libraries
library(readr) 
library(tm)
library(tidytext) 
library(plyr) 
library(dplyr) 
library(ggplot2)

#------ reshape the dataframe 
cortex_reshape<- cbind(cortex$cluster_mem, stack(cortex[1:19803]))
cortex_reshape[1:5, ]

#------ rename the columns
colnames(cortex_reshape)<- c("cluster", "expression", "gene")

#------ check data types and for missing values
str(cortex_reshape)
sum(is.na(cortex_reshape["expression"]))

#------ verify that there are 12 clusters
unique(cortex_reshape$cluster)

#------ group by cluster and determine the total and median expression 
#       levels for each gene
cortex_reshape$gene<- as.character(cortex_reshape$gene)
cortex_reshape$expression<- as.numeric(cortex_reshape$expression)
cortex_reshape$cluster<- as.character(cortex_reshape$cluster)

cortex_grouped<- do.call(data.frame, aggregate(cortex_reshape$expression, 
                                               by=list(cortex_reshape$cluster, cortex_reshape$gene), 
                                               FUN=function(x) c(med.exp = median(x),avg.exp = mean(x), total.exp = sum(x))))

#----- make a copy
cortex_copy<- cortex_grouped
cortex_copy[1:5, 1:5]

#----- rename the columns
colnames(cortex_copy)<- c("cluster", "gene", "med.exp", "avg.exp", "total.exp")
colnames(cortex_grouped)<- c("cluster", "gene", "med.exp", "avg.exp", "total.exp")


#----- sort the genes by MEDIAN expression within a cluster
print_cortex <- cortex_grouped %>%  
  dplyr::arrange(desc(med.exp))  %>%                                          
  dplyr::mutate(gene = factor(gene, levels = rev(unique(gene)))) %>%           
  dplyr::mutate(cluster = factor(cluster, levels = rev(unique(cluster))))

print_me<- arrange(print_cortex, cluster, desc(med.exp))

save_the_genes<- function(df, clust_count){
  for (i in 1:clust_count){
    clust_genes<- df[which(df$cluster == i),c(2, 3)]
    file =  ifelse(i < 10, paste0("med_cortex_0", i, ".txt"), paste0("med_cortex_", i, ".txt"))
    write.table(clust_genes, paste0(write_path, file), sep = "\t", row.names = F, col.names = F)}}


save_the_genes(print_me, 12)

length(unique(print_me[(print_me$cluster == 4), ]$gene))





