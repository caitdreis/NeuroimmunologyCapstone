**TFIDF**

**Purpose**: Determine distingushing gene sets for various regions of the brain using term frequency and inverse document frequency scores.  In the future we will use these techniques across disease states rather than brain regions.  

**Summary of methodology**: Consider genes to be terms and regions of the brain to be "documents".  Use the normalized expression level as a 'word count'.  Determine term frequency for a document by determining the summed expression of the gene across all cells within the region divided by the total expression of all genes across all cells in the region. Calculate the inverse document frequency by taking the log of the total number of documents divided by the number of documents "positive" for a gene.  We are still investigating appropriate methods for defining "positive". 

**Files**: 
>**Lun Workflow**: added in spike and mitochondrial data, removed cells with library size below three normal median average deviations, removed cells with gene expression counts lower than three normal median average deviations, removed cells with proportion of mitochondrial expression greater than three normal median average deviations, and removed cells with proportion of spike expression greater than three normal median average deviations. Removed mitochondrial and spike features as well as some other metadata features. Copied workflow from:  https://f1000research.com/articles/5-2122/v1
>**tfidf4**: Initial attempt at applying TFIDF methods to single cell RNA seq data.  Needs to be adjusted to determine a more valid method for defining regions "positive" or "negative" for expression of a gene. 

>**processed_Lun.csv**: data resulting from the "Lun Workflow" and used for tfidf analysis
>**MRNA LUN.txt, MITO LUN.txt, ERCC LUN.txt**: original files downloaded from: http://linnarssonlab.org/cortex/ [GSE60361]

