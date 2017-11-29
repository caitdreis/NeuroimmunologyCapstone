library(readr)
library(SCAN.UPC)


mrna.counts <- read.delim("C:/Users/mkw5c/OneDrive/Documents/Capstone/MRNA LUN.txt", 
                          stringsAsFactors=FALSE, header=FALSE, row.names=1, skip=11)[,-1]

mrna.counts2<- read.delim("C:/Users/mkw5c/OneDrive/Documents/Capstone/lun.mrna.counts2.txt", header = FALSE)
mrna.counts2[1:5, 1:5]
delete= c(10773, 18089)
mrna.counts3<- mrna.counts2[-delete, ]

write.table(mrna.counts3[1:200, ], "C:/Users/mkw5c/OneDrive/Documents/Capstone/lun.mrna.counts4.txt", 
            sep = "\t", col.names = FALSE, row.names = FALSE)
dim(mrna.counts2)
UPC_RNASeq("C:/Users/mkw5c/OneDrive/Documents/Capstone/lun.mrna.counts4.txt", 
           outFilePath = "C:\\Users\\mkw5c\\OneDrive\\Documents\\Capstone\\upc_outfile.csv", 
           verbose = FALSE)
###what is a singular matrix
