# ------------------- set working directory - Hippocampus Cluster 1
library(tools)
files <- list.files(path="~/Dropbox (Personal)/Research/Data Science Capstone Neuroimmunology/Autoencoder/cluster_ csvs/Cluster01_Hippoc50", 
                    pattern="*.tsv", all.files=T, full.names=T)
filelist <- lapply(files, read.table, header=F)
names(filelist) <- paste0(basename(file_path_sans_ext(files)))
list2env(filelist, envir=.GlobalEnv)
node17 <- head(hippoc_node17$V1, n=500)
node23 <- head(hippoc_node23$V1, n=500)
node27 <- head(hippoc_node27$V1, n=500)
node29 <- head(hippoc_node29$V1, n=500)
node30 <- head(hippoc_node30$V1, n=500)

h.cluster1 <- Reduce(intersect, list(node17, node23, node27, node29, node30))
#[1] "Gpm6a"         "Syt1"          "Gnao1"         "Ttc3"          "Son"           "Cst3"         
#[7] "Meg3"          "Map1b"         "Fkbp1a"        "3110035E14Rik"

# ------------------- set working directory - Hippocampus Cluster 2
files <- list.files(path="~/Dropbox (Personal)/Research/Data Science Capstone Neuroimmunology/Autoencoder/cluster_ csvs/Cluster02_Hippoc50", 
                    pattern="*.tsv", all.files=T, full.names=T)
filelist <- lapply(files, read.table, header=F)
names(filelist) <- paste0(basename(file_path_sans_ext(files)))
list2env(filelist, envir=.GlobalEnv)
node2 <- head(hippoc_node02$V1, n=700)
node10 <- head(hippoc_node10$V1, n=700)
node13 <- head(hippoc_node13$V1, n=700)
node28 <- head(hippoc_node28$V1, n=700)
node31 <- head(hippoc_node31$V1, n=700)
node35 <- head(hippoc_node35$V1, n=700)
node45 <- head(hippoc_node45$V1, n=700)

h.cluster2 <- Reduce(intersect, list(node2, node10, node13, node28, node31, node35, node45))
#[1] "Cox7c"

# ------------------- set working directory - Hippocampus Cluster 3
files <- list.files(path="~/Dropbox (Personal)/Research/Data Science Capstone Neuroimmunology/Autoencoder/cluster_ csvs/Cluster03_Hippoc50", 
                    pattern="*.tsv", all.files=T, full.names=T)
filelist <- lapply(files, read.table, header=F)
names(filelist) <- paste0(basename(file_path_sans_ext(files)))
list2env(filelist, envir=.GlobalEnv)
node23 <- head(hippoc_node23$V1, n=700)
node24 <- head(hippoc_node24$V1, n=700)
node28 <- head(hippoc_node28$V1, n=700)
node38 <- head(hippoc_node38$V1, n=700)

h.cluster3 <- Reduce(intersect, list(node23, node24, node28, node38))
#[1] "Gpm6a"  "Tmsb4x" "Mdh1"   "Cpe"    "Atp1b1" "Itm2b"  "Sorl1"  "Zranb2" "Nrxn1"  "Map1b" 

# ------------------- set working directory - Hippocampus Cluster 4
files <- list.files(path="~/Dropbox (Personal)/Research/Data Science Capstone Neuroimmunology/Autoencoder/cluster_ csvs/Cluster04_Hippoc50", 
                    pattern="*.tsv", all.files=T, full.names=T)
filelist <- lapply(files, read.table, header=F)
names(filelist) <- paste0(basename(file_path_sans_ext(files)))
list2env(filelist, envir=.GlobalEnv)
node4 <- head(hippoc_node04$V1, n=500)
node12 <- head(hippoc_node12$V1, n=500)
node15 <- head(hippoc_node15$V1, n=500)
node16 <- head(hippoc_node16$V1, n=500)
node17 <- head(hippoc_node17$V1, n=500)
node19 <- head(hippoc_node19$V1, n=500)
node24 <- head(hippoc_node24$V1, n=500)
node37 <- head(hippoc_node37$V1, n=500)
node39 <- head(hippoc_node39$V1, n=500)

h.cluster4 <- Reduce(intersect, list(node4, node12, node15, node16, node17, node19, node24, node37, node39))
#[1] "Ncdn"

# ------------------- set working directory - Hippocampus Cluster 5
files <- list.files(path="~/Dropbox (Personal)/Research/Data Science Capstone Neuroimmunology/Autoencoder/cluster_ csvs/Cluster05_Hippoc50", 
                    pattern="*.tsv", all.files=T, full.names=T)
filelist <- lapply(files, read.table, header=F)
names(filelist) <- paste0(basename(file_path_sans_ext(files)))
list2env(filelist, envir=.GlobalEnv)
node4 <- head(hippoc_node04$V1, n=500)
node17 <- head(hippoc_node17$V1, n=500)
node21 <- head(hippoc_node21$V1, n=500)
node32 <- head(hippoc_node32$V1, n=500)
node37 <- head(hippoc_node37$V1, n=500)
node46 <- head(hippoc_node46$V1, n=500)

h.cluster5 <- Reduce(intersect, list(node4, node17, node21, node32, node37, node46))
#[1] "Calm2"  "Atp2b1" "Chn1"   "Sept7" 

# ------------------- set working directory - Hippocampus Cluster 6
files <- list.files(path="~/Dropbox (Personal)/Research/Data Science Capstone Neuroimmunology/Autoencoder/cluster_ csvs/Cluster06_Hippoc50", 
                    pattern="*.tsv", all.files=T, full.names=T)
filelist <- lapply(files, read.table, header=F)
names(filelist) <- paste0(basename(file_path_sans_ext(files)))
list2env(filelist, envir=.GlobalEnv)
node30 <- head(hippoc_node30$V1, n=500)
node33 <- head(hippoc_node33$V1, n=500)
node35 <- head(hippoc_node35$V1, n=500)

h.cluster6 <- Reduce(intersect, list(node30, node33, node35))
#[1] "Calm1"   "App"     "Lars2"   "Ddx5"    "Snap25"  "Ckb"     "Ywhag"   "Tcf4"    "Celf4"   "Atp5e"  
#[11] "Dclk1"   "Rnasek"  "Canx"    "Rtn1"    "Aldoa"   "Ywhaq"   "Mdh1"    "Snhg11"  "Polr2l"  "Cltc"   
#[21] "Atp5o"   "Gprasp2" "St13"    "Rps29"   "Vdac2"   "Gpx4"    "Txn1"    "Elmod1"  "Micu3"   "Rpl4"   
#[31] "Ankrd12" "Psmc4" 

# ------------------- set working directory - Hippocampus Cluster 7
files <- list.files(path="~/Dropbox (Personal)/Research/Data Science Capstone Neuroimmunology/Autoencoder/cluster_ csvs/Cluster07_Hippoc50", 
                    pattern="*.tsv", all.files=T, full.names=T)
filelist <- lapply(files, read.table, header=F)
names(filelist) <- paste0(basename(file_path_sans_ext(files)))
list2env(filelist, envir=.GlobalEnv)
node17 <- head(hippoc_node17$V1, n=500)
node23 <- head(hippoc_node23$V1, n=500)
node27 <- head(hippoc_node27$V1, n=500)
node29 <- head(hippoc_node29$V1, n=500)

h.cluster7 <- Reduce(intersect, list(node17, node23, node27, node29))
#[1] "Cnr1"     "Syt1"     "Mdh1"     "Prdx2"    "Atp6v1a"  "Zcchc18"  "Gnao1"    "Araf"     "Ppia"    
#[10] "Gpm6a"    "Vamp2"    "Cycs"     "Atp5b"    "Gad1"     "Skp1a"    "BC031181" "Atp1b1"   "Ptma"    
#[19] "Calm1"    "Cadm2"    "Grpel1"   "Nrxn3"    "Hspe1"    "Map1b"    "Dnajc5"   "Nap1l5"   "Dner"

# ------------------- set working directory - Hippocampus Cluster 8
files <- list.files(path="~/Dropbox (Personal)/Research/Data Science Capstone Neuroimmunology/Autoencoder/cluster_ csvs/Cluster08_Hippoc50", 
                    pattern="*.tsv", all.files=T, full.names=T)
filelist <- lapply(files, read.table, header=F)
names(filelist) <- paste0(basename(file_path_sans_ext(files)))
list2env(filelist, envir=.GlobalEnv)
node10 <- head(hippoc_node10$V1, n=500)
node20 <- head(hippoc_node20$V1, n=500)

h.cluster8 <- Reduce(intersect, list(node10, node20))
#[1] "Mt1"       "Prdx6"     "Slc1a3"    "Gpr37l1"   "Actb"      "Ptn"       "Gja1"      "Itm2b"    
#[9] "Ttyh1"     "Lars2"     "Cd81"      "Cldn10"    "Ppia"      "Mfge8"     "Cpe"       "Glud1"    
#[17] "Fau"       "Abhd3"     "S100b"     "Ntsr2"     "Gstm5"     "Acsbg1"    "Ppap2b"    "Uqcr11"   
#[25] "Rcn2"      "Glul"      "Cox4i1"    "Grcc10"    "Fth1"      "Hopx"      "Cox7a2"    "Lcat"     
#[33] "Hnrnpa2b1" "H3f3b"     "Ubc"       "Malat1"    "Sec62"     "Grm3"      "Scp2"      "Ctsl"     
#[41] "Ndufc2"    "Uqcrc2"    "Mlc1"      "Atp1a2"    "Son"       "BC002163"  "Slc4a4"    "Apoe"     
#[49] "Nrxn2"     "Htra1"     "Meg3"      "Bsg"       "Rps14"     "Hsp90b1"   "Ddx17"     "Ppib"     
#[57] "Atp5o"     "Rps24"     "Gnai2"     "Pgk1"      "Pon2"      "Cox7c"     "Atp5j"     "Aldoa"    
#[65] "Ntrk2"     "Tmem256"   "Gm2a"      "Sfxn5"     "Uqcr10"    "Prnp"      "S100a13"   "Sparcl1"  
#[73] "Chchd10"   "Cisd1"     "Atp5f1"    "Tspan7"    "Rpl36"     "Kmt2e"     "Ndrg2"     "Ier3ip1"  
#[81] "Ankrd11"   "Cbx3"      "Atp5g3"    "Clu"       "Tmem66"    "Psmb2"     "Ckb"       "Atp6v1f"  
#[89] "Sec61g"    "Cwf19l2"   "Abcd3"     "Ndufa7"    "Dbi"       "Ube2i"     "Qk"        "Vps29"    
#[97] "Rps18"     "Selk"      "Actg1"     "Abcf1"     "Vapa"      "Uqcrq"     "Plcb1"     "Cyb5"     
#[105] "Dnaja1"    "Ube2l3"    "Psap"      "Galnt1"    "Slc20a1"   "Paqr4"     "Acat2"     "Cd164"    
#[113] "Emc7"      "Aldoc"     "Acadvl"    "Synj2bp"   "Snord104"  "Igdcc4"    "Hepacam"   "Smox"     
#[121] "Gpd2"      "Mat2a"     "Aimp1"     "Slu7"      "Lars"      "Cyp4f15"   "Rpl18"     "Mia3"     
#[129] "Ap3d1"     "Supt16"    "Dynll2"    "Cbx5"      "Cfdp1"     "Slc6a1"  

# ------------------- set working directory - Hippocampus Cluster 9
files <- list.files(path="~/Dropbox (Personal)/Research/Data Science Capstone Neuroimmunology/Autoencoder/cluster_ csvs/Cluster09_Hippoc50", 
                    pattern="*.tsv", all.files=T, full.names=T)
filelist <- lapply(files, read.table, header=F)
names(filelist) <- paste0(basename(file_path_sans_ext(files)))
list2env(filelist, envir=.GlobalEnv)
node4 <- head(hippoc_node04$V1, n=500)
node9 <- head(hippoc_node09$V1, n=500)
node12 <- head(hippoc_node12$V1, n=500)
node13 <- head(hippoc_node13$V1, n=500)
node19 <- head(hippoc_node19$V1, n=500)
node26 <- head(hippoc_node26$V1, n=500)

h.cluster9 <- Reduce(intersect, list(node4, node9, node12, node13, node19, node26))
#[1] "Nxph3"  "Hint1"  "Eif4a2"

# ------------------- set working directory - Hippocampus Cluster 10
files <- list.files(path="~/Dropbox (Personal)/Research/Data Science Capstone Neuroimmunology/Autoencoder/cluster_ csvs/Cluster10_Hippoc50", 
                    pattern="*.tsv", all.files=T, full.names=T)
filelist <- lapply(files, read.table, header=F)
names(filelist) <- paste0(basename(file_path_sans_ext(files)))
list2env(filelist, envir=.GlobalEnv)
node1 <- head(hippoc_node01$V1, n=2000)
node4 <- head(hippoc_node04$V1, n=2000)
node7 <- head(hippoc_node07$V1, n=2000)
node15 <- head(hippoc_node15$V1, n=2000)
node26 <- head(hippoc_node26$V1, n=2000)
node32 <- head(hippoc_node32$V1, n=2000)
node36 <- head(hippoc_node36$V1, n=2000)
node40 <- head(hippoc_node40$V1, n=2000)

h.cluster10 <- Reduce(intersect, list(node1, node4, node7, node15, node26, node32, node36, node40))
#character(0)
#[1] "Actb" "Bex4" (set at 2,000)


# ------------------- set working directory - Hippocampus Cluster 11
files <- list.files(path="~/Dropbox (Personal)/Research/Data Science Capstone Neuroimmunology/Autoencoder/cluster_ csvs/Cluster11_Hippoc50", 
                    pattern="*.tsv", all.files=T, full.names=T)
filelist <- lapply(files, read.table, header=F)
names(filelist) <- paste0(basename(file_path_sans_ext(files)))
list2env(filelist, envir=.GlobalEnv)
node32 <- head(hippoc_node32$V1, n=500)
node33 <- head(hippoc_node33$V1, n=500)
node38 <- head(hippoc_node38$V1, n=500)
node40 <- head(hippoc_node40$V1, n=500)
node43 <- head(hippoc_node43$V1, n=500)

h.cluster11 <- Reduce(intersect, list(node32, node33, node38, node40, node43))
#[1] "Fth1"    "Calm1"   "Gria2"   "Rps3"    "Fkbp1a"  "Gpm6a"   "Serinc1" "Actb"    "Eif4a2"  "Gm15421"
#[11] "Rps28"   "Hspa8"   "Cdc42"  

# ------------------- set working directory - Hippocampus Cluster 12
files <- list.files(path="~/Dropbox (Personal)/Research/Data Science Capstone Neuroimmunology/Autoencoder/cluster_ csvs/Cluster12_Hippoc50", 
                    pattern="*.tsv", all.files=T, full.names=T)
filelist <- lapply(files, read.table, header=F)
names(filelist) <- paste0(basename(file_path_sans_ext(files)))
list2env(filelist, envir=.GlobalEnv)
node1 <- head(hippoc_node01$V1, n=500)
node23 <- head(hippoc_node23$V1, n=500)
node30 <- head(hippoc_node30$V1, n=500)
node34 <- head(hippoc_node34$V1, n=500)

h.cluster12 <- Reduce(intersect, list(node1, node23, node30, node34))
#[1] "Malat1"   "Hsp90aa1" "Actg1"    "Sparcl1"  "Prdx6"    "Ccdc37"   "Prdx1"    "Ppia"     "Psap"    
#[10] "Cox6c"    "Timp2"    "Jun"      "Mtpn"     "Ndufc1"   "Scg3"     "Txn1"     "Slc2a1"   "Sparc"   
#[19] "Gpr37l1"  "Apoe" 

# ------------------- set working directory - Hippocampus Cluster 13
files <- list.files(path="~/Dropbox (Personal)/Research/Data Science Capstone Neuroimmunology/Autoencoder/cluster_ csvs/Cluster13_Hippoc50", 
                    pattern="*.tsv", all.files=T, full.names=T)
filelist <- lapply(files, read.table, header=F)
names(filelist) <- paste0(basename(file_path_sans_ext(files)))
list2env(filelist, envir=.GlobalEnv)
node2 <- head(hippoc_node02$V1, n=3000)
node5 <- head(hippoc_node05$V1, n=3000)
node10 <- head(hippoc_node10$V1, n=3000)
node12 <- head(hippoc_node12$V1, n=3000)
node13 <- head(hippoc_node13$V1, n=3000)
node15 <- head(hippoc_node15$V1, n=3000)
node21 <- head(hippoc_node21$V1, n=3000)
node22 <- head(hippoc_node22$V1, n=3000)
node29 <- head(hippoc_node29$V1, n=3000)
node44 <- head(hippoc_node44$V1, n=3000)

h.cluster13 <- Reduce(intersect, list(node2, node5, node10, node12, node13, node15, node21, node22, node29, node44))
#[1] "Homer1"

# ------------------- set working directory - Hippocampus Cluster 14
files <- list.files(path="~/Dropbox (Personal)/Research/Data Science Capstone Neuroimmunology/Autoencoder/cluster_ csvs/Cluster14_Hippoc50", 
                    pattern="*.tsv", all.files=T, full.names=T)
filelist <- lapply(files, read.table, header=F)
names(filelist) <- paste0(basename(file_path_sans_ext(files)))
list2env(filelist, envir=.GlobalEnv)
node6 <- head(hippoc_node06$V1, n=500)
node12 <- head(hippoc_node12$V1, n=500)
node21 <- head(hippoc_node21$V1, n=500)

h.cluster14 <- Reduce(intersect, list(node6, node12, node21))
#[1] "Sparc"      "Malat1"     "Actg1"      "Calm1"      "Ftl1"       "Gpx1"       "Rps3a1"     "Tmsb4x"    
#[9] "Calm2"      "Oaz1-ps"    "Crip1"      "Itgb1"      "Esam"       "Rplp1"      "Rbm39"      "Myl6"      
#[17] "Ier3"       "Pfdn5"      "Myl9"       "Usmg5"      "Pltp"       "Cav2"       "Rpl31-ps12" "Timp3"     
#[25] "Pdgfrb"     "Btf3"       "Itm2a"      "Atp6v1e1"   "Hprt"       "Eef1a1"     "Fry"        "Utrn"      
#[33] "Atp5g3"     "Shfm1"      "Rps24"      "H3f3a"      "Itm2b"      "Prkar1a"    "H3f3b"      "Rhoa"      
#[41] "Col4a2"     "Ddost"      "Mllt3"      "Sdc3"       "Jun"        "Sec13"      "Psma4"      "Ddx24"     
#[49] "Sdha"       "Gas6"       "Id3"        "Sparcl1"    "Selk"  

# ------------------- set working directory - Hippocampus Cluster 15
files <- list.files(path="~/Dropbox (Personal)/Research/Data Science Capstone Neuroimmunology/Autoencoder/cluster_ csvs/Cluster15_Hippoc50", 
                    pattern="*.tsv", all.files=T, full.names=T)
filelist <- lapply(files, read.table, header=F)
names(filelist) <- paste0(basename(file_path_sans_ext(files)))
list2env(filelist, envir=.GlobalEnv)
node5 <- head(hippoc_node05$V1, n=500)
node15 <- head(hippoc_node15$V1, n=500)
node17 <- head(hippoc_node17$V1, n=500)
node24 <- head(hippoc_node24$V1, n=500)
node39 <- head(hippoc_node39$V1, n=500)
node44 <- head(hippoc_node44$V1, n=500)

h.cluster15 <- Reduce(intersect, list(node5, node15, node17, node24, node39, node44))
#[1] "Ppp2r1a"

# ------------------- set working directory - Hippocampus Cluster 16
files <- list.files(path="~/Dropbox (Personal)/Research/Data Science Capstone Neuroimmunology/Autoencoder/cluster_ csvs/Cluster16_Hippoc50", 
                    pattern="*.tsv", all.files=T, full.names=T)
filelist <- lapply(files, read.table, header=F)
names(filelist) <- paste0(basename(file_path_sans_ext(files)))
list2env(filelist, envir=.GlobalEnv)
node1 <- head(hippoc_node01$V1, n=1000)
node13 <- head(hippoc_node13$V1, n=1000)
node21 <- head(hippoc_node21$V1, n=1000)
node23 <- head(hippoc_node23$V1, n=1000)
node31 <- head(hippoc_node31$V1, n=1000)
node34 <- head(hippoc_node34$V1, n=1000)
node39 <- head(hippoc_node39$V1, n=1000)
node46 <- head(hippoc_node46$V1, n=1000)

h.cluster16 <- Reduce(intersect, list(node1, node13, node21, node23, node31, node34, node39, node46))
#[1] "Meg3" "Ttc3"
