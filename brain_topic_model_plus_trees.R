

#import libraries
library(readr)
library(stringr)
library (tm)
library (topicmodels)
library(XML)
library(randomForest)
library(MASS)
library(tree)
library (ISLR)
library(gbm)
library(boot)

#create the dataset
brain_genes<- read_csv("C:\\Users\\mkw5c\\OneDrive\\Documents\\Capstone\\r codes\\brain2.csv")
brain_gene_df<- brain_genes[ ,2:8906]
#find the mean level of expression for each gene
gene_means = as.vector(apply(brain_gene_df, 2, function(col) mean(col)))
genes = as.vector(colnames(brain_gene_df))

#create a binary matrix so that if the expression of a gene is greater than or equal to the mean for that gene
#the value becomes 1 and if the expression is less than the mean, the value becomes 0

# make_binary<- function(x, y) {
#   ifelse (x >= y, 1, 0) 
# }
# 
# for (i in 1:8){ 
#   if (i%%10 == 0) {print(i)}
#   brain_gene_df[,i] <-apply(brain_gene_df[,i], 1, make_binary, y = gene_means[i] )}
# 
# # Now replace all ones with the name of the gene represented and all 0's with "na"
# 
# 
# 
# make_terms<- function(x, y) {
#   ifelse (x == 1, y, NA) 
# }
# 
# for (i in 1:8905){ 
#   if (i%%10 == 0) {print(i)}
#   brain_gene_df[,i] <- apply(brain_gene_df[,i], 1, make_terms, y = genes[i])}
 


make_terms_fast<- function(x, y, z) {
  ifelse (x >= y, z, NA) 
}

for (i in 1:8905){ 
  if (i%%10 == 0) {print(i)}
  brain_gene_df[,i] <-apply(brain_gene_df[,i], 1, make_terms_fast, y = gene_means[i], z = genes[i] )}



# Make a Document Corpus
brain_gene_corpus<- VCorpus(DataframeSource(brain_gene_df))
brain_gene_corpus[[1]]$content
# Make a Document Term Matrix
brain_gene.tf<- DocumentTermMatrix(brain_gene_corpus, control = list(weighting = weightTf))
as.matrix(brain_gene.tf[1:5, 805:815])

##check if there are any empty documents
row.sums<- apply(brain_gene.tf, 1, sum)
which(row.sums==0)

#Create Topic Models
brain_TM2<- LDA(brain_gene.tf, 2)

terms(brain_TM2, 10)[ ,1:2]
topics(brain_TM2, 5)[,1:10]

brain_TM5<- LDA(brain_gene.tf, 5)

terms(brain_TM5, 10)[ ,1:5]
topics(brain_TM5, 5)[,1:10]

brain_TM10<- LDA(brain_gene.tf, 10)

terms(brain_TM10, 10)[ ,1:5]
topics(brain_TM10, 5)[,1:10]

brain_TM20<- LDA(brain_gene.tf, 20) 
 
terms(brain_TM20, 10)[ ,1:10]
topics(brain_TM20, 5)[,1:10]

#find the probabilities of each topic for each document and store in new dataframe
brain_TM10_probs<- as.data.frame(brain_TM10@gamma)
brain_TM20_probs<- as.data.frame(brain_TM20@gamma)
#add a new column with the cell source for each observation

cellsource<- read_csv("C:/Users/mkw5c/OneDrive/Documents/Capstone/cells2902.csv")
cellsource["X1"]<- NULL

brain_TM10_probs["cellsource"]<- cellsource
brain_TM10_probs["cellsource"]<- as.factor(brain_TM10_probs$cellsource)

brain_TM20_probs["cellsource"]<- cellsource
brain_TM20_probs["cellsource"]<- as.factor(brain_TM20_probs$cellsource)

# Use Random Forest to predict the Cell Source using the probabilities of the topics as predictors
train <- sample(2902, 1800, replace = FALSE)

brain_TM10_train<- brain_TM10_probs[train,]
brain_TM10_test<- brain_TM10_probs[-train, ]

err_rate<- rep(0, 10)
for (i in 1:10){
  rf.brain<- randomForest(cellsource~., data = brain_TM10_train, ntrees = 300, mtry = i, importance = TRUE)
  source_preds= as.vector(predict(rf.brain, data = brain_TM10_train, type = "class"))
  table<- table(source_preds, brain_TM10_train$cellsource)
  err_rate[i] = (table[1,2]+table[2,1])/1800}
  
m<- seq(1,10, 1)

plot(m, err_rate, type="b")

rf.brain<- randomForest(cellsource~., data = brain_TM10_train, ntrees = 300, mtry = 4, importance = TRUE)
source_preds= as.vector(predict(rf.brain, newdata = brain_TM10_test, type = "class"))
table<- table(source_preds, brain_TM10_test$cellsource)
err_rate = (table[1,2]+table[2,1])/(2902-1800)
err_rate

#######  TM20


rf.brain<- randomForest(cellsource~., data = brain_TM20_probs, ntrees = 300, mtry = 15, importance = TRUE)
print(rf.brain)

varImpPlot(rf.brain, type = )



