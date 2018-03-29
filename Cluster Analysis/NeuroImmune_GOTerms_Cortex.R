setwd("~/Downloads")

goterms <- read.csv("autoencoder GO term results GSEA.csv")
#View(goterms)
attach(goterms)

#----------- Cortex cluster 1

c.node32 <- goterms[ which(tissue == "Cortex" & cluster=="cluster01" & node == "node32"),]
c.node35 <- goterms[ which(tissue == "Cortex" & cluster=='cluster01' & node == 'node35'),]
c.node38 <- goterms[ which(tissue == "Cortex" & cluster=='cluster01' & node == 'node38'),]
c.node40 <- goterms[ which(tissue == "Cortex" & cluster=='cluster01' & node == 'node40'),]
c.node43 <- goterms[ which(tissue == "Cortex" & cluster=='cluster01' & node == 'node43'),]
c.node44 <- goterms[ which(tissue == "Cortex" & cluster=='cluster01' & node == 'node44'),]

c.node32 <- c.node32$ID
c.node35 <- c.node35$ID
c.node38 <- c.node38$ID
c.node40 <- c.node40$ID
c.node43 <- c.node43$ID
c.node44 <- c.node44$ID

interset.go.cluster1.cortex <- Reduce(intersect, list(c.node32, c.node35, c.node38, c.node40, c.node43, c.node44))

#----------- Cortex cluster 2

c.node4 <- goterms[ which(tissue == "Cortex" & cluster=="cluster02" & node == "node04"),]
c.node17 <- goterms[ which(tissue == "Cortex" & cluster=='cluster02' & node == 'node17'),]
c.node21 <- goterms[ which(tissue == "Cortex" & cluster=='cluster02' & node == 'node21'),]
c.node28 <- goterms[ which(tissue == "Cortex" & cluster=='cluster02' & node == 'node28'),]
c.node32 <- goterms[ which(tissue == "Cortex" & cluster=='cluster02' & node == 'node32'),]
c.node37 <- goterms[ which(tissue == "Cortex" & cluster=='cluster02' & node == 'node37'),]

c.node4 <- c.node4$ID
c.node17 <- c.node17$ID
c.node21 <- c.node21$ID
c.node28 <- c.node28$ID
c.node32 <- c.node32$ID
c.node37 <- c.node37$ID

interset.go.cluster2.cortex <- Reduce(intersect, list(c.node4, c.node17, c.node21, c.node28, c.node32, c.node37))

#----------- Cortex cluster 3

c.node3 <- goterms[ which(tissue == "Cortex" & cluster=="cluster03" & node == "node03"),]
c.node22 <- goterms[ which(tissue == "Cortex" & cluster=='cluster03' & node == 'node22'),]
c.node37 <- goterms[ which(tissue == "Cortex" & cluster=='cluster03' & node == 'node37'),]
c.node42 <- goterms[ which(tissue == "Cortex" & cluster=='cluster03' & node == 'node42'),]

c.node3 <- c.node3$ID
c.node22 <- c.node22$ID
c.node37 <- c.node37$ID
c.node42 <- c.node42$ID

interset.go.cluster3.cortex <- Reduce(intersect, list(c.node3, c.node22, c.node37, c.node42))

#----------- Cortex cluster 4

c.node2 <- goterms[ which(tissue == "Cortex" & cluster=="cluster04" & node == "node02"),]
c.node10 <- goterms[ which(tissue == "Cortex" & cluster=='cluster04' & node == 'node10'),]
c.node14 <- goterms[ which(tissue == "Cortex" & cluster=='cluster04' & node == 'node14'),]
c.node25 <- goterms[ which(tissue == "Cortex" & cluster=='cluster04' & node == 'node25'),]
c.node27 <- goterms[ which(tissue == "Cortex" & cluster=="cluster04" & node == "node27"),]
c.node28 <- goterms[ which(tissue == "Cortex" & cluster=='cluster04' & node == 'node28'),]
c.node34 <- goterms[ which(tissue == "Cortex" & cluster=='cluster04' & node == 'node34'),]
c.node46 <- goterms[ which(tissue == "Cortex" & cluster=='cluster04' & node == 'node46'),]

c.node2 <- c.node2$ID
c.node10 <- c.node10$ID
c.node14 <- c.node14$ID
c.node25 <- c.node25$ID
c.node27 <- c.node27$ID
c.node28 <- c.node28$ID
c.node34 <- c.node34$ID
c.node46 <- c.node46$ID

interset.go.cluster4.cortex <- Reduce(intersect, list(c.node2, c.node10, c.node14, 
                                                      c.node25, c.node27, c.node28, 
                                                      c.node34, c.node46))

#----------- Cortex cluster 5

c.node11 <- goterms[ which(tissue == "Cortex" & cluster=="cluster05" & node == "node11"),]
c.node16 <- goterms[ which(tissue == "Cortex" & cluster=='cluster05' & node == 'node16'),]
c.node42 <- goterms[ which(tissue == "Cortex" & cluster=='cluster05' & node == 'node42'),]

c.node11 <- c.node11$ID
c.node16 <- c.node16$ID
c.node42 <- c.node42$ID

interset.go.cluster5.cortex <- Reduce(intersect, list(c.node11, c.node16, c.node42))


#----------- Cortex cluster 6

c.node11 <- goterms[ which(tissue == "Cortex" & cluster=="cluster06" & node == "node11"),]
c.node48 <- goterms[ which(tissue == "Cortex" & cluster=='cluster06' & node == 'node48'),]

c.node11 <- c.node11$ID
c.node48 <- c.node48$ID

interset.go.cluster6.cortex <- Reduce(intersect, list(c.node11, c.node48))

#----------- Cortex cluster 7

c.node13 <- goterms[ which(tissue == "Cortex" & cluster=="cluster07" & node == "node13"),]
c.node17 <- goterms[ which(tissue == "Cortex" & cluster=='cluster07' & node == 'node17'),]
c.node23 <- goterms[ which(tissue == "Cortex" & cluster=="cluster07" & node == "node23"),]
c.node27 <- goterms[ which(tissue == "Cortex" & cluster=='cluster07' & node == 'node27'),]
c.node29 <- goterms[ which(tissue == "Cortex" & cluster=="cluster07" & node == "node29"),]

c.node13 <- c.node13$ID
c.node17 <- c.node17$ID
c.node23 <- c.node23$ID
c.node27 <- c.node27$ID
c.node29 <- c.node29$ID

interset.go.cluster7.cortex <- Reduce(intersect, list(c.node13, c.node17, c.node23, c.node27, c.node29))

#----------- Cortex cluster 8

c.node10 <- goterms[ which(tissue == "Cortex" & cluster=="cluster08" & node == "node10"),]
c.node13 <- goterms[ which(tissue == "Cortex" & cluster=='cluster08' & node == 'node13'),]
c.node14 <- goterms[ which(tissue == "Cortex" & cluster=="cluster08" & node == "node14"),]
c.node17 <- goterms[ which(tissue == "Cortex" & cluster=='cluster08' & node == 'node17'),]
c.node28 <- goterms[ which(tissue == "Cortex" & cluster=="cluster08" & node == "node28"),]
c.node31 <- goterms[ which(tissue == "Cortex" & cluster=="cluster08" & node == "node31"),]

c.node10 <- c.node10$ID
c.node13 <- c.node13$ID
c.node14 <- c.node14$ID
c.node17 <- c.node17$ID
c.node28 <- c.node28$ID
c.node31 <- c.node31$ID

interset.go.cluster8.cortex <- Reduce(intersect, list(c.node10, c.node13, c.node14, 
                                                      c.node17, c.node28, c.node31))

#----------- Cortex cluster 9

c.node24 <- goterms[ which(tissue == "Cortex" & cluster=="cluster09" & node == "node24"),]
c.node27 <- goterms[ which(tissue == "Cortex" & cluster=='cluster09' & node == 'node27'),]
c.node31 <- goterms[ which(tissue == "Cortex" & cluster=="cluster09" & node == "node31"),]
c.node34 <- goterms[ which(tissue == "Cortex" & cluster=='cluster09' & node == 'node34'),]
c.node36 <- goterms[ which(tissue == "Cortex" & cluster=="cluster09" & node == "node36"),]
c.node39 <- goterms[ which(tissue == "Cortex" & cluster=="cluster09" & node == "node39"),]

c.node24 <- c.node24$ID
c.node27 <- c.node27$ID
c.node31 <- c.node31$ID
c.node34 <- c.node34$ID
c.node36 <- c.node36$ID
c.node39 <- c.node39$ID

interset.go.cluster9.cortex <- Reduce(intersect, list(c.node24, c.node27, c.node31, 
                                                      c.node34, c.node36, c.node39))

#----------- Cortex cluster 10

c.node7 <- goterms[ which(tissue == "Cortex" & cluster=="cluster10" & node == "node07"),]
c.node11 <- goterms[ which(tissue == "Cortex" & cluster=='cluster10' & node == 'node11'),]
c.node17 <- goterms[ which(tissue == "Cortex" & cluster=="cluster10" & node == "node17"),]
c.node43 <- goterms[ which(tissue == "Cortex" & cluster=='cluster10' & node == 'node43'),]
c.node46 <- goterms[ which(tissue == "Cortex" & cluster=="cluster10" & node == "node46"),]
c.node48 <- goterms[ which(tissue == "Cortex" & cluster=="cluster10" & node == "node48"),]

c.node7 <- c.node7$ID
c.node11 <- c.node11$ID
c.node17 <- c.node17$ID
c.node43 <- c.node43$ID
c.node46 <- c.node46$ID
c.node48 <- c.node48$ID

interset.go.cluster10.cortex <- Reduce(intersect, list(c.node7, c.node11, c.node17, 
                                                      c.node43, c.node46, c.node48))

#----------- Cortex cluster 11

c.node12 <- goterms[ which(tissue == "Cortex" & cluster=="cluster11" & node == "node12"),]
c.node45 <- goterms[ which(tissue == "Cortex" & cluster=='cluster11' & node == 'node45'),]

c.node12 <- c.node12$ID
c.node45 <- c.node45$ID

interset.go.cluster11.cortex <- Reduce(intersect, list(c.node12, c.node45))


#----------- Cortex cluster 12

c.node4 <- goterms[ which(tissue == "Cortex" & cluster=="cluster12" & node == "node04"),]
c.node17 <- goterms[ which(tissue == "Cortex" & cluster=='cluster12' & node == 'node17'),]
c.node22 <- goterms[ which(tissue == "Cortex" & cluster=="cluster12" & node == "node22"),]
c.node24 <- goterms[ which(tissue == "Cortex" & cluster=='cluster12' & node == 'node24'),]

c.node4 <- c.node4$ID
c.node17 <- c.node17$ID
c.node22 <- c.node22$ID
c.node24 <- c.node24$ID

interset.go.cluster12.cortex <- Reduce(intersect, list(c.node4, c.node17, c.node22, c.node24))

all.insersect.cortex <- Reduce(intersect, list(interset.go.cluster1.cortex,
                                        interset.go.cluster2.cortex,
                                        interset.go.cluster3.cortex,
                                        interset.go.cluster4.cortex,
                                        interset.go.cluster5.cortex,
                                        interset.go.cluster6.cortex,
                                        interset.go.cluster7.cortex,
                                        interset.go.cluster8.cortex,
                                        interset.go.cluster9.cortex,
                                        interset.go.cluster10.cortex,
                                        interset.go.cluster11.cortex,
                                        interset.go.cluster12.cortex))

#[1] "GO:0006461" "GO:0006886" "GO:0034613" "GO:0034622" "GO:0042886" "GO:0043933" "GO:0046907" "GO:0065003"
#[9] "GO:0070271" "GO:0070727" "GO:0071705" "GO:0006518" "GO:0043603" "GO:0006412" "GO:0043604" "GO:0043043"




