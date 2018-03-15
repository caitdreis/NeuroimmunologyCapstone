

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

#----- delete rows where the median expression is equal to zero
cortex_copy<- cortex_copy[which(cortex_copy$med.exp >0), ]

#----- bind the tfidf matrix using median as the threshold
cortex_tfidf<- bind_tf_idf(tbl = cortex_copy, term = gene, document = cluster,  n = med.exp)

#----- make a dataset to plot the top 15 genes by TF-IDF value
plot_cortex <- cortex_tfidf %>%  
  dplyr::arrange(desc(tf_idf))  %>%                                          
  dplyr::mutate(gene = factor(gene, levels = rev(unique(gene)))) %>%           
  dplyr::mutate(cluster = factor(cluster, levels = rev(unique(cluster))))

# to_print<- plot_cortex%>%
#            group_by(cluster) %>%    
#            top_n(1000, tf_idf) %>%
#            ungroup() %>%
#            dplyr::mutate(gene = reorder(gene, tf_idf))

 # to_plot%>%
 #     ggplot(aes(gene, tf_idf, fill = cluster)) +                 
 #     geom_col(show.legend = FALSE) +
 #     labs(x = NULL, y = "TFIDF score") +
 #     facet_wrap(~cluster, ncol = 4, scales = "free") +
 #     coord_flip()
    
print_me<- arrange(plot_cortex, cluster, desc(tf_idf))

save_the_genes<- function(df, clust_count){
  for (i in 1:clust_count){
    clust_genes<- df[which(df$cluster == i),c(2, 8)]
    file =  ifelse(i < 10, paste0("cortex_0", i, ".txt"), paste0("cortex_", i, ".txt"))
    write.table(clust_genes, file, sep = "\t", row.names = F, col.names = F)}}

save_the_genes(print_me, 12)
