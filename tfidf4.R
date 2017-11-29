load("C:/Users/mkw5c/OneDrive/Documents/Capstone/topic modeling and RNA seq/TFIDF envirionment 11.9.RData")
brain<- read_csv("C:\\Users\\mkw5c\\OneDrive\\Documents\\Capstone\\r codes\\brain.csv")
cell.type<- read_csv("C:\\Users\\mkw5c\\OneDrive\\Documents\\Capstone\\cells2902.csv")

library(readr)
library(stringr)
library(tm)
library(NLP)
library(tidytext)
library(tidyverse)
library(plyr)
library(dplyr)
library(boot)
library(data.table)
library(SCAN.UPC)


#add the celltype metadata 
brain<- cbind.data.frame(brain, cell.type)

##Create an ID column
brain$ID<- seq.int(nrow(brain))

brain[1:5, 1:5]
brain[1, c(1:5, 8955:8960)]

#Move the ID and celltype columns to positions 1 and 2
brain<- brain[ ,c(8957, 8958, 1:8956)]


#remove columns that are not genes
brain<- brain[1:8907]
brain[1, c(1:5, 8900:8907)]


######## FIND THE IDF SCORES 
#find the number of cells that are positive for each gene
numcellspos<- rep(0, 8905)
for (i in 3:8907) {
  numcellspos[i]<- sum(as.numeric(brain[,i])>0)
}

print(numcellspos[1:10])
numcellspos<- numcellspos[3:8907]

#find the idf weight for each gene
idf<- function(n, npos) {
  log(n/npos)
}

idf_scores<- sapply(numcellspos, idf, n=nrow(brain))
print(idf_scores[1:10])


#################################################################################################################
gene_means<- as.vector(apply(brain[,3:8907], 2, mean))
gene_means<-c(0,0,gene_means)

brain_w_means<- rbind(brain, gene_means)
brain_w_means[2895:2903,1:10]

#treat gene columns as characters
brain_w_means[sapply(brain_w_means, is.factor)] = lapply(brain2[sapply(brain_w_means, is.factor)], as.character)

#reshape the dataframe 
brain_means1.1<- cbind(brain_w_means[1:2], stack(brain_w_means[3:8907]))

#reorder the columns
brain_means1.1<- brain_means1.1[,c(1,2,4,3)]


#rename the columns
names(brain_means1.1)[3:4]<- c("Gene", "Exp.Level")
brain_means1.1[1:5, ]
str(brain_means1.1)
sum(is.na(brain_means1.1["Exp.Level"]))

unique(brain_means1.1$celltype)


#group by cell type and find total and average expression levels for each gene 
grouped_expression2<- do.call(data.frame, aggregate(brain_means1.1$Exp.Level, 
                            by=list(brain_means1.1$celltype, brain_means1.1$Gene), 
                            FUN=function(x) c(avg.exp = mean(x), total.exp = sum(x))))
brain_m1.3<- grouped_expression2
brain_m1.3[1:5, 1:7]
colnames(brain_m1.3)<- c("celltype", "gene", "avg.exp", "total.exp")
indices<- seq(1, 26713, 3)

brain_m1.3["avg.allcells"]<- 0

for (i in indices) {
  brain_m1.3$avg.allcells[i] <- brain_m1.3$avg.exp[i]
  brain_m1.3$avg.allcells[i+1] <- brain_m1.3$avg.exp[i]
  brain_m1.3$avg.allcells[i+2] <- brain_m1.3$avg.exp[i]}
  
brain_m1.3<- brain_m1.3[(brain_m1.3$celltype !=0), ]
brain_m1.3["IDF"] = 0

indices = seq(1, 17809, 2)
for (i in indices) {
  count_pos = 0
  if (brain_m1.3$avg.exp[i]>= (brain_m1.3$avg.allcells[i]/2)){
    count_pos = count_pos + 1}
  if (brain_m1.3$avg.exp[i+1]>= (brain_m1.3$avg.allcells[i]/2)){
    count_pos = count_pos + 1}
  brain_m1.3$IDF[i] = log(2/count_pos)
  brain_m1.3$IDF[i+1] = log(2/count_pos)}

unique(brain_m1.3$celltype)

brain_m1.3["expIDF"]<- 0

for (i in 1:nrow(brain_m1.3)){brain_m1.3$expIDF[i] = brain_m1.3$total.exp[i]*brain_m1.3$IDF[i]}
unique(brain_m1.3$expIDF)


plot_brain_new <- brain_m1.3 %>%
  arrange(desc(expIDF)) %>%
  mutate(gene = factor(gene, levels = rev(unique(gene)))) %>%
  mutate(celltype = factor(celltype, levels = c("ca1hippocampus", "sscortex")))

plot_brain_new %>%
  group_by(celltype) %>%
  top_n(15, expIDF) %>%
  ungroup() %>%
  mutate(gene = reorder(gene, expIDF)) %>%
  ggplot(aes(gene, expIDF, fill = celltype)) +
  geom_col(show.legend = FALSE) +
  labs(x = NULL, y = "Total Expression Level x IDF score") +
  facet_wrap(~celltype, ncol = 2, scales = "free") +
  coord_flip()


brain_m1.4<- bind_tf_idf(tbl = brain_m1.3, term = gene, document = celltype,  n = total.exp)

brain_m1.4["idf"]<- NULL
brain_m1.4["tf_idf"]<- NULL
brain_m1.4[1:15, 1:9]


brain_m1.4["TFIDF"]<- 0

for (i in 1:nrow(brain_m1.4)){brain_m1.4$TFIDF[i] = brain_m1.4$tf[i]*brain_m1.4$IDF[i]}
unique(brain_m1.3$expIDF)


plot_brain_1.4 <- brain_m1.4 %>%
  arrange(desc(TFIDF)) %>%
  mutate(gene = factor(gene, levels = rev(unique(gene)))) %>%
  mutate(celltype = factor(celltype, levels = c("ca1hippocampus", "sscortex")))

plot_brain_1.4 %>%
  group_by(celltype) %>%
  top_n(15, TFIDF) %>%
  ungroup() %>%
  mutate(gene = reorder(gene, TFIDF)) %>%
  ggplot(aes(gene, TFIDF, fill = celltype)) +
  geom_col(show.legend = FALSE) +
  labs(x = NULL, y = "Gene Frequency x IDF score") +
  facet_wrap(~celltype, ncol = 2, scales = "free") +
  coord_flip()
#######################################################################################################

brain2[1:5, c(1:5, 8955:8959)]

#add the celltype metadata 
brain2<- cbind.data.frame(brain2, cell.type)

##Create an ID column
brain2$ID<- seq.int(nrow(brain2))

#Move the ID and celltype columns to positions 1 and 2


#remove columns that are not genes
brain2<- brain2[1:8907]
brain2[1:5,1:5]

#Find the kmeans clusters using exp*IDF
kmeansBrain2<- kmeans(as.matrix(brain2[,3:8907]), 2)
kmeansBrain2$centers[[1]]

center<- as.data.frame(kmeansBrain2$centers)
center<-as.data.frame(t(center))
center$genes<- rownames(center)
colnames(center)<- c("cluster1", "cluster2", "genes")


#Find the 15 most discriminating genes in each cluster
top15cluster1<- center%>%
                arrange(desc(cluster2))%>%
                top_n(15, center[,2])
top15cluster1[,3]



top15cluster2<- center%>%
                arrange(desc(cluster2))%>%
                top_n(15, center[,2])
top15cluster2[,3]



