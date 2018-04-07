
library(readr)

setwd("C:/Users/mkw5c/OneDrive/Documents/Neuro Capstone/SPRING/autoencoder results 3.26")

files = dir("C:\\Users\\mkw5c\\OneDrive\\Documents\\Neuro Capstone\\SPRING\\autoencoder results 3.26\\", 
            recursive = TRUE, 
            pattern="*.csv", 
            full.names=F)


n = 0

for (file in files){
  n = n+1
  temp_df = read_csv(file)
  temp_df$tissue = substr(file, 31, 36)
  temp_df$cluster = substr(file, 21, 29)
  temp_df$node = substr(file, 37, 42)
  
  if (n == 1){
    perm_df = temp_df}
  
  else{
    perm_df = rbind(perm_df, temp_df)
  }
}

perm_df<- perm_df[,c(13, 14, 15, 1:12)]
write.csv(perm_df, "autoencoder GO term results GSEA.csv", row.names = F)

###===========================================================================================================

#--- split by region

cortex_data<- perm_df[which(perm_df$tissue == "cortex"), ]
hippo_data<-  perm_df[which(perm_df$tissue == "hippoc"), ]

#--- get a list of every geneset id for each cluster
cortex_sets<- rep(0, 12)
for (i in 1:12) {
  var_find<- paste0("cluster", i)
  cortex_sets[i]<-  as.list(cortex_data[which(cortex_data$cluster == var_find), 1] )
}

hippo_sets<- rep(0, 16)
for (i in 1:16) {
  var_find<- paste0("cluster", i)
  hippo_sets[i]<- as.list(hippo_data[which(hippo_data$cluster == var_find), 1 ] )

}





#--- get the annotated functional definitions of each gene set


#--- put all of this in a doc term matrix for each cluster?




