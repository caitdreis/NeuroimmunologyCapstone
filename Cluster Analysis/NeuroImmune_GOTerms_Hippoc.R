setwd("~/Downloads")

goterms <- read.csv("autoencoder GO term results GSEA.csv")
View(goterms)
attach(goterms)

#----------- Hippocampus cluster 1

h.node17 <- goterms[ which(tissue == "Hippoc" & cluster=="cluster01" & node == "node17"),]
h.node23 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster01' & node == 'node23'),]
h.node27 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster01' & node == 'node27'),]
h.node29 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster01' & node == 'node29'),]
h.node30 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster01' & node == 'node30'),]

h.node17 <- h.node17$ID
h.node23 <- h.node23$ID
h.node27 <- h.node27$ID
h.node29 <- h.node29$ID
h.node30 <- h.node30$ID

intersect.go.cluster1.hippoc <- Reduce(intersect, list(h.node17, h.node23, h.node27, h.node29, h.node30))

#----------- Hippocampus cluster 2

h.node2 <- goterms[ which(tissue == "Hippoc" & cluster=="cluster02" & node == "node02"),]
h.node10 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster02' & node == 'node10'),]
h.node13 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster02' & node == 'node13'),]
h.node28 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster02' & node == 'node28'),]
h.node31 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster02' & node == 'node31'),]
h.node35 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster02' & node == 'node35'),]
h.node45 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster02' & node == 'node45'),]

h.node2 <- h.node2$ID
h.node10 <- h.node10$ID
h.node13 <- h.node13$ID
h.node28 <- h.node28$ID
h.node31 <- h.node31$ID
h.node35 <- h.node35$ID
h.node45 <- h.node45$ID

intersect.go.cluster2.hippoc <- Reduce(intersect, list(h.node2, h.node10, h.node13, 
                                                       h.node28, h.node31, h.node35,
                                                       h.node45))

#----------- Hippocampus cluster 3

h.node23 <- goterms[ which(tissue == "Hippoc" & cluster=="cluster03" & node == "node23"),]
h.node24 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster03' & node == 'node24'),]
h.node28 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster03' & node == 'node28'),]
h.node38 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster03' & node == 'node38'),]

h.node23 <- h.node23$ID
h.node24 <- h.node24$ID
h.node28 <- h.node28$ID
h.node38 <- h.node38$ID

intersect.go.cluster3.hippoc <- Reduce(intersect, list(h.node23, h.node24, h.node28, h.node38))

#----------- Hippocampus cluster 4

h.node4 <- goterms[ which(tissue == "Hippoc" & cluster=="cluster04" & node == "node04"),]
h.node12 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster04' & node == 'node12'),]
h.node15 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster04' & node == 'node15'),]
h.node16 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster04' & node == 'node16'),]
h.node17 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster04' & node == 'node17'),]
h.node19 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster04' & node == 'node19'),]
h.node24 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster04' & node == 'node24'),]
h.node37 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster04' & node == 'node37'),]
h.node39 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster04' & node == 'node39'),]

h.node4 <- h.node4$ID
h.node12 <- h.node12$ID
h.node15 <- h.node15$ID
h.node16 <- h.node16$ID
h.node17 <- h.node17$ID
h.node19 <- h.node19$ID
h.node24 <- h.node24$ID
h.node37 <- h.node37$ID
h.node39 <- h.node39$ID

intersect.go.cluster4.hippoc <- Reduce(intersect, list(h.node4, h.node12, h.node15, 
                                                       h.node16, h.node17, h.node19,
                                                       h.node24, h.node37, h.node39))

#----------- Hippocampus cluster 5

h.node4 <- goterms[ which(tissue == "Hippoc" & cluster=="cluster05" & node == "node04"),]
h.node17 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster05' & node == 'node17'),]
h.node21 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster05' & node == 'node21'),]
h.node32 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster05' & node == 'node32'),]
h.node37 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster05' & node == 'node37'),]
h.node46 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster05' & node == 'node46'),]

h.node4 <- h.node4$ID
h.node17 <- h.node17$ID
h.node21 <- h.node21$ID
h.node32 <- h.node32$ID
h.node37 <- h.node37$ID
h.node46 <- h.node46$ID

intersect.go.cluster5.hippoc <- Reduce(intersect, list(h.node4, h.node17, h.node21, 
                                                       h.node32, h.node37, h.node46))

#----------- Hippocampus cluster 6

h.node30 <- goterms[ which(tissue == "Hippoc" & cluster=="cluster06" & node == "node30"),]
h.node33 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster06' & node == 'node33'),]
h.node35 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster06' & node == 'node35'),]

h.node30 <- h.node30$ID
h.node33 <- h.node33$ID
h.node35 <- h.node35$ID

intersect.go.cluster6.hippoc <- Reduce(intersect, list(h.node30, h.node33, h.node35))

#----------- Hippocampus cluster 7

h.node17 <- goterms[ which(tissue == "Hippoc" & cluster=="cluster07" & node == "node17"),]
h.node23 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster07' & node == 'node23'),]
h.node27 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster07' & node == 'node27'),]
h.node29 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster07' & node == 'node29'),]

h.node17 <- h.node17$ID
h.node23 <- h.node23$ID
h.node27 <- h.node27$ID
h.node29 <- h.node29$ID

intersect.go.cluster7.hippoc <- Reduce(intersect, list(h.node17, h.node23, h.node27, h.node29))

#----------- Hippocampus cluster 8

h.node10 <- goterms[ which(tissue == "Hippoc" & cluster=="cluster08" & node == "node10"),]
h.node20 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster08' & node == 'node20'),]

h.node10 <- h.node10$ID
h.node20 <- h.node20$ID

intersect.go.cluster8.hippoc <- Reduce(intersect, list(h.node10, h.node20))

#----------- Hippocampus cluster 9

h.node4 <- goterms[ which(tissue == "Hippoc" & cluster=="cluster09" & node == "node04"),]
h.node9 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster09' & node == 'node09'),]
h.node12 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster09' & node == 'node12'),]
h.node13 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster09' & node == 'node13'),]
h.node19 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster09' & node == 'node19'),]
h.node26 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster09' & node == 'node26'),]

h.node4 <- h.node4$ID
h.node9 <- h.node9$ID
h.node12 <- h.node12$ID
h.node13 <- h.node13$ID
h.node19 <- h.node19$ID
h.node26 <- h.node26$ID

intersect.go.cluster9.hippoc <- Reduce(intersect, list(h.node4, h.node9, h.node12, 
                                                       h.node13, h.node19, h.node26))

#----------- Hippocampus cluster 10

h.node1 <- goterms[ which(tissue == "Hippoc" & cluster=="cluster10" & node == "node01"),]
h.node4 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster10' & node == 'node04'),]
h.node7 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster10' & node == 'node07'),]
h.node15 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster10' & node == 'node15'),]
h.node26 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster10' & node == 'node26'),]
h.node32 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster10' & node == 'node32'),]
h.node36 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster10' & node == 'node36'),]
h.node40 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster10' & node == 'node40'),]

h.node1 <- h.node1$ID
h.node4 <- h.node4$ID
h.node7 <- h.node7$ID
h.node15 <- h.node15$ID
h.node26 <- h.node26$ID
h.node32 <- h.node32$ID
h.node36 <- h.node36$ID
h.node40 <- h.node40$ID

intersect.go.cluster10.hippoc <- Reduce(intersect, list(h.node4, h.node12, h.node15, 
                                                       h.node16, h.node17, h.node19,
                                                       h.node24, h.node37, h.node39))


#----------- Hippocampus cluster 11

h.node32 <- goterms[ which(tissue == "Hippoc" & cluster=="cluster11" & node == "node32"),]
h.node33 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster11' & node == 'node33'),]
h.node38 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster11' & node == 'node38'),]
h.node40 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster11' & node == 'node40'),]
h.node43 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster11' & node == 'node43'),]

h.node32 <- h.node32$ID
h.node33 <- h.node33$ID
h.node38 <- h.node38$ID
h.node40 <- h.node40$ID
h.node43 <- h.node43$ID

intersect.go.cluster11.hippoc <- Reduce(intersect, list(h.node32, h.node33, h.node38, 
                                                       h.node40, h.node43))

#----------- Hippocampus cluster 12

h.node1 <- goterms[ which(tissue == "Hippoc" & cluster=="cluster12" & node == "node01"),]
h.node23 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster12' & node == 'node23'),]
h.node30 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster12' & node == 'node30'),]
h.node34 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster12' & node == 'node34'),]

h.node1 <- h.node1$ID
h.node23 <- h.node23$ID
h.node30 <- h.node30$ID
h.node34 <- h.node34$ID

intersect.go.cluster12.hippoc <- Reduce(intersect, list(h.node1, h.node23, h.node30, 
                                                        h.node34))


#----------- Hippocampus cluster 13

h.node2 <- goterms[ which(tissue == "Hippoc" & cluster=="cluster13" & node == "node02"),]
h.node5 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster13' & node == 'node05'),]
h.node10 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster13' & node == 'node10'),]
h.node12 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster13' & node == 'node12'),]
h.node13 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster13' & node == 'node13'),]
h.node15 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster13' & node == 'node15'),]
h.node21 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster13' & node == 'node21'),]
h.node22 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster13' & node == 'node22'),]
h.node29 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster13' & node == 'node29'),]
h.node44 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster13' & node == 'node44'),]

h.node2 <- h.node2$ID
h.node5 <- h.node5$ID
h.node10 <- h.node10$ID
h.node12 <- h.node12$ID
h.node13 <- h.node13$ID
h.node15 <- h.node15$ID
h.node21 <- h.node21$ID
h.node22 <- h.node22$ID
h.node29 <- h.node29$ID
h.node44 <- h.node44$ID

intersect.go.cluster13.hippoc <- Reduce(intersect, list(h.node2, h.node5, h.node10, 
                                                        h.node12, h.node13, h.node15,
                                                        h.node21, h.node22, h.node29, h.node44))


#----------- Hippocampus cluster 14

h.node6 <- goterms[ which(tissue == "Hippoc" & cluster=="cluster14" & node == "node06"),]
h.node12 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster14' & node == 'node12'),]
h.node21 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster14' & node == 'node21'),]

h.node6 <- h.node6$ID
h.node12 <- h.node12$ID
h.node21 <- h.node21$ID

intersect.go.cluster14.hippoc <- Reduce(intersect, list(h.node6, h.node12, h.node21))


#----------- Hippocampus cluster 15

h.node5 <- goterms[ which(tissue == "Hippoc" & cluster=="cluster15" & node == "node05"),]
h.node15 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster15' & node == 'node15'),]
h.node17 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster15' & node == 'node17'),]
h.node24 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster15' & node == 'node24'),]
h.node39 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster15' & node == 'node39'),]
h.node44 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster15' & node == 'node44'),]

h.node5 <- h.node5$ID
h.node15 <- h.node15$ID
h.node17 <- h.node17$ID
h.node24 <- h.node24$ID
h.node39 <- h.node39$ID
h.node44 <- h.node44$ID

intersect.go.cluster15.hippoc <- Reduce(intersect, list(h.node5, h.node15, h.node17, 
                                                        h.node24, h.node24, h.node39, h.node44))

#----------- Hippocampus cluster 16

h.node1 <- goterms[ which(tissue == "Hippoc" & cluster=="cluster16" & node == "node01"),]
h.node13 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster16' & node == 'node13'),]
h.node21 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster16' & node == 'node21'),]
h.node23 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster16' & node == 'node23'),]
h.node31 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster16' & node == 'node31'),]
h.node34 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster16' & node == 'node34'),]
h.node39 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster16' & node == 'node39'),]
h.node46 <- goterms[ which(tissue == "Hippoc" & cluster=='cluster16' & node == 'node46'),]

h.node1 <- h.node1$ID
h.node13 <- h.node13$ID
h.node21 <- h.node21$ID
h.node23 <- h.node23$ID
h.node31 <- h.node31$ID
h.node34 <- h.node34$ID
h.node39 <- h.node39$ID
h.node46 <- h.node46$ID

intersect.go.cluster16.hippoc <- Reduce(intersect, list(h.node1, h.node13, h.node21, 
                                                        h.node23, h.node31, h.node34, h.node39,
                                                        h.node46))


all.insersect.hippoc <- Reduce(intersect, list(intersect.go.cluster1.hippoc,
                                        intersect.go.cluster2.hippoc,
                                        intersect.go.cluster3.hippoc,
                                        intersect.go.cluster4.hippoc,
                                        intersect.go.cluster5.hippoc,
                                        intersect.go.cluster6.hippoc,
                                        intersect.go.cluster7.hippoc,
                                        intersect.go.cluster8.hippoc,
                                        intersect.go.cluster9.hippoc,
                                        intersect.go.cluster10.hippoc,
                                        intersect.go.cluster11.hippoc,
                                        intersect.go.cluster12.hippoc,
                                        intersect.go.cluster13.hippoc,
                                        intersect.go.cluster14.hippoc,
                                        intersect.go.cluster15.hippoc,
                                        intersect.go.cluster16.hippoc))
#[1] "GO:0034613" "GO:0046907" "GO:0051649" "GO:0070727"
