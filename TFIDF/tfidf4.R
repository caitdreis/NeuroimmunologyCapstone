
#libraries
library(readr) 
library(tm)
library(tidytext) 
library(plyr) 
library(dplyr) 

brain<- read.csv("processed_Lun.csv", row.names = NULL) #2902 obs of 8857 vars
brain["X"]<- NULL
brain[1:2 , c(1:10,8851:8856)]

#################################################################################################################
### make a copy of the dataframe excluding metadata
tfidf_brain = brain
tfidf_brain[,1:5]<- apply(tfidf_brain[,1:5], 2, as.character)


###find the mean expression level for each gene  (add 2 zeros at the beginning because those columns are not numeric)
means<- as.vector(apply(tfidf_brain[,6:8856], 2, mean))
means<- c("mean", "mean", "mean", "mean", "mean", means)

#bind the vector containing the mean expression levels to the dataframe
tfidf_brain1.1<- rbind(tfidf_brain, means)

#reshape the dataframe 
tfidf_brain1.2<- cbind(tfidf_brain1.1[1:5], stack(tfidf_brain1.1[6:8856]))
tfidf_brain1.2[1:10, 1:7]

#reorder the columns to: ID, celltype, tissue, age, sex, gene, expression level
tfidf_brain1.2<- tfidf_brain1.2[,c(1,2,3,4,5,7,6)]
tfidf_brain1.2[1:5, 1:7]

#rename the columns
names(tfidf_brain1.2)[c(2,6,7)]<- c("Celltype", "Gene", "Exp.Level")
tfidf_brain1.2[1:10, 1:7]

#check the data types and for missing values (if there are any something has gone wrong!!)
str(tfidf_brain1.2)
sum(is.na(tfidf_brain1.2["Exp.Level"]))

#check the "tissue" values, there should be three: sscortex,ca1hippocampus, and "mean" which is
# the category that we just calculated containing the mean overall expression for each of the genes
unique(tfidf_brain1.2$tissue)


#group by tissue and find total and average expression levels for each gene within the cell type
tfidf_brain1.2$Gene<- as.character(tfidf_brain1.2$Gene)
tfidf_brain1.2$Exp.Level<- as.numeric(tfidf_brain1.2$Exp.Level)

grouped_expression2<- do.call(data.frame, aggregate(tfidf_brain1.2$Exp.Level, 
                            by=list(tfidf_brain1.2$tissue, tfidf_brain1.2$Gene), 
                            FUN=function(x) c(avg.exp = mean(x), total.exp = sum(x))))

### make a copy
tfidf_brain1.3<- grouped_expression2
tfidf_brain1.3[1:5, 1:4]

#rename the columns
colnames(tfidf_brain1.3)<- c("tissue", "gene", "avg.exp", "total.exp")

#create a list that will correspond to every 3rd row
indices<- seq(1, 26553, 3)

#create a new column to store the mean values in
tfidf_brain1.3["avg.allcells"]<- 0

#store the mean for each gene in a new column in the rows corresponding to that gene in each cell type
for (i in indices) {
  tfidf_brain1.3$avg.allcells[i] <- tfidf_brain1.3$avg.exp[i]
  tfidf_brain1.3$avg.allcells[i+1] <- tfidf_brain1.3$avg.exp[i]
  tfidf_brain1.3$avg.allcells[i+2] <- tfidf_brain1.3$avg.exp[i]}

#take a subset of the dataframe to exclude all of the rows where the cell type is "mean"
tfidf_brain1.3<- tfidf_brain1.3[(tfidf_brain1.3$tissue != "mean"), ]

#create a new column for the IDF score
tfidf_brain1.3["IDF"] = 0


#calculate the IDF scores
# define a celltype as "positive" for a gene if the average expression within the type is
# greater than half of the overall average expression for the gene. 

#take the log of the total number of cell types divided by the number of celltypes positive for the gene
indices = seq(1, 17702, 2)
for (i in indices) {
  count_pos = 0
  if (tfidf_brain1.3$avg.exp[i]>= (tfidf_brain1.3$avg.allcells[i]/2)){
    count_pos = count_pos + 1}
  if (tfidf_brain1.3$avg.exp[i+1]>= (tfidf_brain1.3$avg.allcells[i]/2)){
    count_pos = count_pos + 1}
  tfidf_brain1.3$IDF[i] = log(2/count_pos)
  tfidf_brain1.3$IDF[i+1] = log(2/count_pos)}

unique(tfidf_brain1.3["IDF"])  ## 2 unique values- correct 0 if all docs express.  0.69 if not all docs express


#bind the tfidf to get a true term frequency rather than term count
tfidf_brain1.4<- bind_tf_idf(tbl = tfidf_brain1.3, term = gene, document = tissue,  n = total.exp)

tfidf_brain1.4["idf"]<- NULL
tfidf_brain1.4["tf_idf"]<- NULL
tfidf_brain1.4[1:15, 1:8]

#create a new column for the tfidf score
tfidf_brain1.4["TFIDF"]<- 0

#calculate the tfidf scores
for (i in 1:nrow(tfidf_brain1.4)){tfidf_brain1.4$TFIDF[i] = tfidf_brain1.4$tf[i]*tfidf_brain1.4$IDF[i]}


## plot the tope 15 genes by "gene frequency idf"
plot_brain_gfidf <- tfidf_brain1.4 %>%
  arrange(desc(TFIDF)) %>%
  mutate(gene = factor(gene, levels = rev(unique(gene)))) %>%
  mutate(celltype = factor(tissue, levels = c("ca1hippocampus", "sscortex")))

plot_brain_gfidf %>%
  group_by(tissue) %>%
  top_n(15, TFIDF) %>%
  ungroup() %>%
  mutate(gene = reorder(gene, TFIDF)) %>%
  ggplot(aes(gene, TFIDF, fill = tissue)) +
  geom_col(show.legend = FALSE) +
  labs(x = NULL, y = "Gene Frequency x IDF score") +
  facet_wrap(~celltype, ncol = 2, scales = "free") +
  coord_flip()
####################################################################################################
                      #############################
                      ##  TOTAL EXPRESSION x IDF ##
                      #############################
                      #############################

#create a new column for expression IDF
tfidf_brain1.3["expIDF"]<- 0

#calculate the expIDF values by multiplying the total summed expression of the gene in the cell type
# by the IDF value
for (i in 1:nrow(tfidf_brain1.3)){tfidf_brain1.3$expIDF[i] = tfidf_brain1.3$total.exp[i]*tfidf_brain1.3$IDF[i]}


unique(tfidf_brain1.3$expIDF)  ##385 unique values ! good. 
tfidf_brain1.3[1:5, 1:7]
str(tfidf_brain1.3)

#make a dataset to plot the top 15 genes by EXPIDF value
plot_brain <- tfidf_brain1.3 %>%  
  arrange(desc(expIDF))  %>%                                          ##arrange by decsending expIDF value
  mutate(gene = factor(gene, levels = rev(unique(gene)))) %>%           ##treat each gene as a different cat
  mutate(celltype = factor(tissue, levels = c("ca1hippocampus", "sscortex"))) ##treat each celltype as a new cat

plot_brain%>%
  group_by(tissue) %>%    ##group by celltype category
  top_n(15, expIDF) %>%     ##within each category take the 15 genes with the highest expIDF values
  ungroup() %>%             
  mutate(gene = reorder(gene, expIDF)) %>%    
  ggplot(aes(gene, expIDF, fill = tissue)) +                  ##plot
  geom_col(show.legend = FALSE) +
  labs(x = NULL, y = "Total Expression Level x IDF score") +
  facet_wrap(~tissue, ncol = 2, scales = "free") +
  coord_flip()
