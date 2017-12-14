library(readr)
library(SCAN.UPC)


# mrna.counts <- read.delim("C:/Users/mkw5c/OneDrive/Documents/Capstone/MRNA LUN.txt", 
#                           stringsAsFactors=FALSE, header=FALSE, row.names=1, skip=11)[,-1]
# 
mrna.counts2<- read.delim("C:/Users/mkw5c/OneDrive/Documents/Capstone/lun.mrna.counts2.txt", header = FALSE)
# mrna.counts2[1:5, 1:5]
# delete= c(10773, 18089)
#mrna.counts3<- mrna.counts2[-delete, ]

#write.table(mrna.counts3[1:200, ], "C:/Users/mkw5c/OneDrive/Documents/Capstone/lun.mrna.counts4.txt", 
#            sep = "\t", col.names = FALSE, row.names = FALSE)

mrnacounts4<- read.delim("C:/Users/mkw5c/OneDrive/Documents/Capstone/lun.mrna.counts3.txt", header = F)

corr_mrna<- cor(t(mrnacounts4[ ,2:3006]))
max_correlations<-apply(corr_mrna, 1, function (x) which(x==max(x[x<1])))

corr_values <- rep(0, 200)
for (i in 1:200){
  corr_values[i]<- corr_mrna[i, max_correlations[i]]
  if (corr_values[i] > 0.8){
    print(i) 
    print(max_correlations[i])}
}

diff_subset<- c(8,67, 90, 135)

mrnacounts5<-mrnacounts4[-2, ]
write.table(mrnacounts5, "C:/Users/mkw5c/OneDrive/Documents/Capstone/lun.mrna.counts5.txt", 
            sep = "\t", col.names = FALSE, row.names = FALSE)


mrna.counts2[1:5, 1:5]
delete= c(10773, 18089, 67)
mrna.counts3<- mrna.counts2[-delete, ]

write.table(mrna.counts3, "C:/Users/mkw5c/OneDrive/Documents/Capstone/lun.mrna.counts3.txt", 
                       sep = "\t", col.names = FALSE, row.names = FALSE)

           
UPC_RNASeq("C:/Users/mkw5c/OneDrive/Documents/Capstone/lun.mrna.counts5.txt", 
           outFilePath = "C:\\Users\\mkw5c\\OneDrive\\Documents\\Capstone\\upc_outfile.csv", 
           verbose = FALSE)

UPC_Generic(mrna.counts3[401:600,2])

