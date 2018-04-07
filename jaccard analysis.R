
library(readr)

##---- GO Term Jaccard

data<- read_csv("autoencoder GO term results GSEA.csv")

#--- do jaccard test between clusters in hippocampus and cortex to see what is similar

#---give each a node a primary key consisting of cluster and node num combined and tissue
data$primkey = paste0(data$tissue, data$cluster, data$node)


#- define function
find_jacc<- function(set1, set2){
  denom<- length(union(set1, set2))
  numerator<- length(intersect(set1, set2))
  jacc_index<- numerator/denom*100
  return(jacc_index)}
#--- Split the data by region

c_data<- data[which(data$tissue == "Cortex"), ]
h_data <- data[which(data$tissue == "Hippoc"), ]


#--- get a list of every geneset id for each node cluster
prim_keys<- as.list(unique(c_data$primkey))
cortex_node_sets<- rep(0, 58)
for (i in 1:58) {
  var_find<- prim_keys[i]
  cortex_node_sets[i]<-  as.list(c_data[which(c_data$primkey == var_find), 4] )
}
names(cortex_node_sets)<- prim_keys

h_prim_keys<- as.list(unique(h_data$primkey))
hippo_node_sets<- rep(0, 90)
for (i in 1:90) {
  var_find<- h_prim_keys[i]
  hippo_node_sets[i]<- as.list(h_data[which(h_data$primkey == var_find), 4] )
}
names(hippo_node_sets)<- h_prim_keys


#----- find scores between for a node against all other nodes in region
#--- Cortex
N2allN_cortex<- data.frame(row.names = prim_keys)
for (i in 1:58){
  N2allN_cortex[,i]<- sapply(cortex_node_sets, find_jacc, set2 = cortex_node_sets[[i]])
}
colnames(N2allN_cortex)<- prim_keys

#--- Hippocampus
N2allN_hippo<- data.frame(row.names = h_prim_keys)
for (i in 1:90){
  N2allN_hippo[,i]<- sapply(hippo_node_sets, find_jacc, set2 = hippo_node_sets[[i]])
}
colnames(N2allN_hippo)<- h_prim_keys




#----- find scores between each node within a cluster

N2N_cortex<- list()

for (i in 1:12){
  temp_data = cortex_node_sets[which(substr(names(cortex_node_sets), 14, 15) == ifelse(i <10, paste0("0", i), i))]
  temp_primkeys = names(temp_data)
  temp_df = data.frame(row.names = temp_primkeys)
  for (j in 1:length(temp_primkeys)){
    temp_df[,j] <- sapply(temp_data, find_jacc, set2 = temp_data[[j]])}
  colnames(temp_df)<- temp_primkeys
  N2N_cortex[[i]]<- temp_df
}



N2N_hippo<- list()

for (i in 1:16){
  temp_data = hippo_node_sets[which(substr(names(hippo_node_sets), 14, 15) == ifelse(i <10, paste0("0", i), i))]
  temp_primkeys = names(temp_data)
  temp_df = data.frame(row.names = temp_primkeys)
  for (j in 1:length(temp_primkeys)){
    temp_df[,j] <- sapply(temp_data, find_jacc, set2 = temp_data[[j]])}
  colnames(temp_df)<- temp_primkeys
  N2N_hippo[[i]]<- temp_df
}

#----- Find Similarities between CLUSTERS
cortex_cluster_sets<- rep(0, 12)
for (i in 1:12) {
  var_find<- paste0("cluster", ifelse(i<10, paste0("0", i), i))
  cortex_cluster_sets[i]<- as.list(c_data[which(c_data$cluster == var_find), 4] )
}

C2C_cortex<- data.frame(row.names = 1:12)
for (i in 1:12){
  C2C_cortex[,i]<- sapply(cortex_cluster_sets, find_jacc, set2 = cortex_cluster_sets[[i]])
}
colnames(C2C_cortex)<- 1:12



hippo_cluster_sets<- rep(0, 16)
for (i in 1:16) {
  var_find<- paste0("cluster", ifelse(i<10, paste0("0", i), i))
  hippo_cluster_sets[i]<- as.list(h_data[which(h_data$cluster == var_find), 4] )
}

C2C_hippo<- data.frame(row.names = 1:16)
for (i in 1:16){
  C2C_hippo[,i]<- sapply(hippo_cluster_sets, find_jacc, set2 = hippo_cluster_sets[[i]])
}
colnames(C2C_hippo)<- 1:16




#----- Make heatmaps
png("jaccard heatmap N2all cortex.png")
color2D.matplot(N2allN_cortex, cs1 = c(1,0), cs2 = c(1,0.6), cs3 = c(1,0.65), border = "white")
dev.off()

png("jaccard heatmap N2all hippo.png")
color2D.matplot(N2allN_hippo, cs1 = c(1,0.8 ), cs2 = c(1,0), cs3 = c(1,0.4), border = "white")
dev.off()


 for (i in 1:12){
   file = paste0("TRI2 jaccard heatmap N2N cortex cluster", i, ".png")
   png(file)
   N2N_cortex[[i]][upper.tri(N2N_cortex[[i]], diag = T)]<-0
   color2D.matplot(N2N_cortex[[i]], cs1 = c(1,0 ), cs2 = c(1,0.6), cs3 = c(1,0.65), border = "white")
   dev.off()}

for (i in 1:16){
  file = paste0("H TRI jaccard heatmap N2N cluster", i, ".png")
  png(file)
  N2N_hippo[[i]][upper.tri(N2N_hippo[[i]], diag = T)]<-0
  color2D.matplot(N2N_hippo[[i]], cs1 = c(1,0.8), cs2 = c(1,0), cs3 = c(1,0.4), border = "white")
  dev.off()}

png("jaccard heatmap C2C cortex.png")
color2D.matplot(C2C_cortex, cs1 = c(1,0 ), cs2 = c(1,0.6), cs3 = c(1,0.65), border = "white")
dev.off()

png("jaccard heatmap C2C hippocampus.png")
color2D.matplot(C2C_hippo, cs1 = c(1,0.8 ), cs2 = c(1,0), cs3 = c(1,0.4), border = "white")
dev.off()


