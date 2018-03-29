# ------------------- set working directory - Cortex Cluster 1
library(tools)
files <- list.files(path="~/Dropbox (Personal)/Research/Data Science Capstone Neuroimmunology/Autoencoder/cluster_ csvs/Cluster01_Cortex50", 
                    pattern="*.tsv", all.files=T, full.names=T)
filelist <- lapply(files, read.table, header=F)
names(filelist) <- paste0(basename(file_path_sans_ext(files)))
list2env(filelist, envir=.GlobalEnv)
node32 <- head(cortex_node32$V1, n=500)
node35 <- head(cortex_node35$V1, n=500)
node38 <- head(cortex_node38$V1, n=500)
node40 <- head(cortex_node40$V1, n=500)
node43 <- head(cortex_node43$V1, n=500)
node44 <- head(cortex_node44$V1, n=500)

#comparison of nodes with highest activated node in cluster
# from top 10
intersect(node40, node32) #"Mt1"  "Fth1" "Scd2"
intersect(node40, node35) #"Cst3"  "Cpe"   "Mt1"   "Gpm6b"
intersect(node40, node38) #"Cst3" "Apoe"
intersect(node40, node43) #"Cst3" "Cpe"  "Mt1" 
intersect(node40, node44) #"Cst3" "Ntm" 

setdiff(node40, node38) #in node 40 but not in node 38
#[1] "Cpe"    "Mt1"    "Gpm6b"  "Fth1"   "Slc1a3" "Actb"   "Ntm"    "Scd2"  

setdiff(node38, node40) #in node38 but not in node40
#[1] "Slc1a2" "Atp1a2" "Lars2"  "Gpm6a"  "Prdx6"  "Ptn"    "Bcan"   "Aqp4"  

c.cluster1 <- Reduce(intersect, list(node32, node35, node38, node40, node43, node44))
#[1] "Sparcl1"  "Mt1"      "Slc1a2"   "Hsp90ab1" "Ckb"      "Plp1"     "Actg1"    "Cst3"    
#[9] "Gja1"     "Qk"       "Gpm6a"    "Gria2"    "Prdx6"    "Id2"      "Cox4i1"   "Atp1a2"  
#[17] "Glul"     "Ednrb"    "Ptn"      "Actb"     "Dbi"      "Luc7l2"   "Rpl24"    "Apoe"    
#[25] "Prnp"     "Acsl6"    "Ubc"      "Ntm"      "Bcan"     "Appl2"    "Gm6654"   "Nrxn1"   
#[33] "Ntrk2"    "Ppap2b"   "Mt2"      "Slc1a3"   "Rps28"    "Clu"      "Cpe"      "Gpr37l1" 


# ------------------- set working directory - Cortex Cluster 2
files_cluster2 <- list.files(path="~/Dropbox (Personal)/Research/Data Science Capstone Neuroimmunology/Autoencoder/cluster_ csvs/Cluster02_Cortex50", 
                    pattern="*.tsv", all.files=T, full.names=T)
filelist <- lapply(files_cluster2, read.table, header=F)
names(filelist) <- paste0(basename(file_path_sans_ext(files_cluster2)))
list2env(filelist, envir=.GlobalEnv)
node4 <- head(cortex_node04$V1, n=500)
node17 <- head(cortex_node17$V1, n=500)
node21 <- head(cortex_node21$V1, n=500)
node28 <- head(cortex_node28$V1, n=500)
node32 <- head(cortex_node32$V1, n=500)
node37 <- head(cortex_node37$V1, n=500)

#tried 50, 100, 200, 500*
c.cluster2 <- Reduce(intersect, list(node4, node17, node21, node28, node32, node37))
#[1] "Atp1b1" "Ppia"   "Eef1a1" "Mtpn" 

# ------------------- set working directory - Cortex Cluster 3
files_cluster3 <- list.files(path="~/Dropbox (Personal)/Research/Data Science Capstone Neuroimmunology/Autoencoder/cluster_ csvs/Cluster03_Cortex50", 
                             pattern="*.tsv", all.files=T, full.names=T)
filelist <- lapply(files_cluster2, read.table, header=F)
names(filelist) <- paste0(basename(file_path_sans_ext(files_cluster3)))
list2env(filelist, envir=.GlobalEnv)
node3 <- head(cortex_node03$V1, n=500)
node22 <- head(cortex_node22$V1, n=500)
node37 <- head(cortex_node37$V1, n=500)
node42 <- head(cortex_node42$V1, n=500)

c.cluster3 <- Reduce(intersect, list(node3, node22, node37, node42))
#[1] "Atp1b1"   "Atp2b1"   "Osbpl1a"  "Sept7"    "Grin2b"   "Dnm1"     "Prkar1b"  "Stmn2"   
#[9] "Ppia"     "Arpp21"   "Cmip"     "Pld3"     "Mdh2"     "Tcf25"    "Lars2"    "Atp6v0e2"
#[17] "Mapt"     "Rgs7bp"   "Ldhb"     "Eef1a1"   "Mtpn"     "Ndufb5" 

# ------------------- set working directory - Cortex Cluster 4
files_cluster4 <- list.files(path="~/Dropbox (Personal)/Research/Data Science Capstone Neuroimmunology/Autoencoder/cluster_ csvs/Cluster04_Cortex50", 
                             pattern="*.tsv", all.files=T, full.names=T)
filelist <- lapply(files_cluster2, read.table, header=F)
names(filelist) <- paste0(basename(file_path_sans_ext(files_cluster4)))
list2env(filelist, envir=.GlobalEnv)
node2 <- head(cortex_node02$V1, n=500)
node10 <- head(cortex_node10$V1, n=500)
node14 <- head(cortex_node14$V1, n=500)
node25 <- head(cortex_node25$V1, n=500)

c.cluster4 <- Reduce(intersect, list(node2, node10, node14, node25))
#[1] "Map1b"  "Rplp1"  "Ndufb8" "Timm8b"

# ------------------- set working directory - Cortex Cluster 5
files_cluster5 <- list.files(path="~/Dropbox (Personal)/Research/Data Science Capstone Neuroimmunology/Autoencoder/cluster_ csvs/Cluster05_Cortex50", 
                             pattern="*.tsv", all.files=T, full.names=T)
filelist <- lapply(files_cluster2, read.table, header=F)
names(filelist) <- paste0(basename(file_path_sans_ext(files_cluster5)))
list2env(filelist, envir=.GlobalEnv)
node11 <- head(cortex_node11$V1, n=500)
node16 <- head(cortex_node16$V1, n=500)
node42 <- head(cortex_node42$V1, n=500)

c.cluster5 <- Reduce(intersect, list(node11, node16, node42))
#[1] "Ryr2"   "Mycbp2" "Gdi1"   "Hprt"   "Sfpq"   "Snap91" "Nsg2"   "Tuba4a" "Rps27a" "Ank"   
#[11] "Nol4"   "Scn2a1" "Nrxn2"  "Ankhd1"

# ------------------- set working directory - Cortex Cluster 6
files_cluster6 <- list.files(path="~/Dropbox (Personal)/Research/Data Science Capstone Neuroimmunology/Autoencoder/cluster_ csvs/Cluster06_Cortex50", 
                             pattern="*.tsv", all.files=T, full.names=T)
filelist <- lapply(files_cluster2, read.table, header=F)
names(filelist) <- paste0(basename(file_path_sans_ext(files_cluster6)))
list2env(filelist, envir=.GlobalEnv)
node11 <- head(cortex_node11$V1, n=500)
node48 <- head(cortex_node48$V1, n=500)

c.cluster6 <- Reduce(intersect, list(node11, node48))
#[1] "Atp2b1"   "Atp5b"    "Atxn7l3b" "Ncam1"    "Stmn2"    "Dync1h1"  "Dlgap1"   "Mycbp2"  
#[9] "Gp1bb"    "Pcsk2"    "Tpt1"     "Nrxn2"    "Myeov2"   "Osbpl1a"  "Nfasc"    "Prkar1b" 
#[17] "Rpl5"     "Pfdn5"    "Eif4h"    "Mapt"     "Eid1"     "Pam"      "Ldhb"     "Cd47"    
#[25] "Mir684-1" "Snap47"   "Rgs7bp"   "Myl6"     "Kcnma1"   "Ehmt1"    "Dip2b"    "Tbca"    
#[33] "Ywhae"    "Ckb"      "Snap91"   "Otub1"    "Cox7a2"   "Rps16"    "Luc7l3"   "Tecr"    
#[41] "Cttn"     "Dlgap2"   "Rasgrf1"  "Nmt2"     "Nucks1"   "Mtpn"     "Ncoa6"    "Smarcd1" 
#[49] "Nsf"      "Actr2"    "Kif5a"    "Tom1l2"   "Drp2"     "Ndufs6"   "Psap"     "Kcnh5"   
#[57] "Gnas"     "Slirp"  

# ------------------- set working directory - Cortex Cluster 7
files_cluster7 <- list.files(path="~/Dropbox (Personal)/Research/Data Science Capstone Neuroimmunology/Autoencoder/cluster_ csvs/Cluster07_Cortex50", 
                             pattern="*.tsv", all.files=T, full.names=T)
filelist <- lapply(files_cluster2, read.table, header=F)
names(filelist) <- paste0(basename(file_path_sans_ext(files_cluster7)))
list2env(filelist, envir=.GlobalEnv)
node13 <- head(cortex_node13$V1, n=500)
node17 <- head(cortex_node17$V1, n=500)
node23 <- head(cortex_node23$V1, n=500)
node27 <- head(cortex_node27$V1, n=500)
node29 <- head(cortex_node29$V1, n=500)

c.cluster7 <- Reduce(intersect, list(node13, node17, node23, node27, node29))
#[1] "Ywhae"  "Cox7a2" "Mtpn"   

# ------------------- set working directory - Cortex Cluster 8
files_cluster8 <- list.files(path="~/Dropbox (Personal)/Research/Data Science Capstone Neuroimmunology/Autoencoder/cluster_ csvs/Cluster08_Cortex50", 
                             pattern="*.tsv", all.files=T, full.names=T)
filelist <- lapply(files_cluster2, read.table, header=F)
names(filelist) <- paste0(basename(file_path_sans_ext(files_cluster8)))
list2env(filelist, envir=.GlobalEnv)
node10 <- head(cortex_node10$V1, n=500)
node13 <- head(cortex_node13$V1, n=500)
node14 <- head(cortex_node14$V1, n=500)
node17 <- head(cortex_node17$V1, n=500)
node28 <- head(cortex_node28$V1, n=500)
node31 <- head(cortex_node31$V1, n=500)

c.cluster8 <- Reduce(intersect, list(node10, node13, node14, node17, node28, node31))
#[1] "Calm2"

# ------------------- set working directory - Cortex Cluster 9
files_cluster9 <- list.files(path="~/Dropbox (Personal)/Research/Data Science Capstone Neuroimmunology/Autoencoder/cluster_ csvs/Cluster09_Cortex50", 
                             pattern="*.tsv", all.files=T, full.names=T)
filelist <- lapply(files_cluster2, read.table, header=F)
names(filelist) <- paste0(basename(file_path_sans_ext(files_cluster9)))
list2env(filelist, envir=.GlobalEnv)
node24 <- head(cortex_node24$V1, n=500)
node27 <- head(cortex_node27$V1, n=500)
node31 <- head(cortex_node31$V1, n=500)
node34 <- head(cortex_node34$V1, n=500)
node36 <- head(cortex_node36$V1, n=500)
node39 <- head(cortex_node39$V1, n=500)

c.cluster9 <- Reduce(intersect, list(node24, node27, node31, node34, node36, node39))
#[1] "Sub1" "Gdi1" "Mtpn"

# ------------------- set working directory - Cortex Cluster 10
files_cluster10 <- list.files(path="~/Dropbox (Personal)/Research/Data Science Capstone Neuroimmunology/Autoencoder/cluster_ csvs/Cluster10_Cortex50", 
                             pattern="*.tsv", all.files=T, full.names=T)
filelist <- lapply(files_cluster2, read.table, header=F)
names(filelist) <- paste0(basename(file_path_sans_ext(files_cluster10)))
list2env(filelist, envir=.GlobalEnv)
node7 <- head(cortex_node07$V1, n=700)
node11 <- head(cortex_node11$V1, n=700)
node17 <- head(cortex_node17$V1, n=700)
node43 <- head(cortex_node43$V1, n=700)
node46 <- head(cortex_node46$V1, n=700)
node48 <- head(cortex_node48$V1, n=700)

c.cluster10 <- Reduce(intersect, list(node7, node11, node17, node43, node46, node48))
#[1] "Cox8a"

# ------------------- set working directory - Cortex Cluster 11
files_cluster11 <- list.files(path="~/Dropbox (Personal)/Research/Data Science Capstone Neuroimmunology/Autoencoder/cluster_ csvs/Cluster11_Cortex50", 
                              pattern="*.tsv", all.files=T, full.names=T)
filelist <- lapply(files_cluster2, read.table, header=F)
names(filelist) <- paste0(basename(file_path_sans_ext(files_cluster11)))
list2env(filelist, envir=.GlobalEnv)
node12 <- head(cortex_node12$V1, n=500)
node45 <- head(cortex_node45$V1, n=500)

c.cluster11 <- Reduce(intersect, list(node12, node45))
#[1] "Map1b"         "Syt1"          "Sub1"          "Atp2b1"        "Camk2n1"      
#[6] "Ncam1"         "Arf3"          "Gabrb2"        "Stmn2"         "Tuba4a"       
#[11] "Epha4"         "Gdi1"          "Gda"           "Marcks"        "Elavl4"       
#[16] "Ndufa4"        "Psmb1"         "Gp1bb"         "Calm1"         "Fkbp3"        
#[21] "Ddx5"          "Sptbn1"        "Osbpl1a"       "1110008P14Rik" "Appl1"        
#[26] "Timp2"         "Kalrn"         "Tcp1"          "Nfib"          "Prkar1b"      
#[31] "Grin1"         "Adora1"        "Rnf14"         "Pfdn5"         "Gm6682"       
#[36] "Eif4h"         "Rpl24"         "Mapt"          "Tomm20"        "Tax1bp1"      
#[41] "Gap43"         "Ldhb"          "Abi1"          "Tspan7"        "Rpl7"         
#[46] "Brd3"          "Cul3"          "Nrep"          "Rgs7bp"        "Ppp2r5c"      
#[51] "Uqcr10"        "Pum2"          "Ywhae"         "Atp2a2"        "Elmod1"       
#[56] "Cox7a2"        "Atp6v1g1"      "Ndufs7"        "Btbd1"         "Pura"         
#[61] "Gprasp1"       "Gnptg"         "Hprt"          "Atp5k"         "Rps27a"       
#[66] "Pip4k2a"       "Mtpn"          "Ctnnd2"        "Slc6a17"       "B3galt2"      
#[71] "Smpd1"         "Nsf"           "Tm9sf2"        "Nicn1"         "Kif5a"        
#[76] "Cadm3"         "Tom1l2"        "Vmp1"          "BC031181"      "Psmc2"        
#[81] "Tubb3"         "Pdha1"         "Scd2"          "U05342"        "Psap"         
#[86] "Mfsd6"         "Lnp"           "P4htm"         "Cse1l"     

# ------------------- set working directory - Cortex Cluster 12
files_cluster12 <- list.files(path="~/Dropbox (Personal)/Research/Data Science Capstone Neuroimmunology/Autoencoder/cluster_ csvs/Cluster12_Cortex50", 
                              pattern="*.tsv", all.files=T, full.names=T)
filelist <- lapply(files_cluster2, read.table, header=F)
names(filelist) <- paste0(basename(file_path_sans_ext(files_cluster12)))
list2env(filelist, envir=.GlobalEnv)
node4 <- head(cortex_node04$V1, n=500)
node17 <- head(cortex_node17$V1, n=500)
node22 <- head(cortex_node22$V1, n=500)
node24 <- head(cortex_node24$V1, n=500)

c.cluster11 <- Reduce(intersect, list(node4, node17, node22, node24))
#[1] "Scg5"     "Gpm6a"    "Atpif1"   "Got1"     "Itm2b"    "Ppia"     "Gdi1"     "Rtn1"    
#[9] "Hsp90aa1" "Cadm2"    "Hsp90ab1" "Ndufb8"   "Ppp2r5c" 


