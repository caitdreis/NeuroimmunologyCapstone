# -*- coding: utf-8 -*-
"""
Created on Wed Dec  6 18:19:46 2017

@author: mkw5c
"""

from GEO_metadata_scraper_functions_final import *
import pandas as pd
import numpy as np


#create an empty dataframe to store the metadata in
columns = ["series", "exptype", "organism", "mouseline", "cellline", "strain", "source",\
           "selectionmarker", "celltype", "treatment", "age", "devstage", "sex"]

index = GSM_dictionary.keys()
GSM_df = pd.DataFrame(index = index, columns = columns) 


##use the functions
for index in GSM_df.index.values: 
    GSM_df.loc[index, "series"] = findSeries(index, GSM_dictionary, GSM_df)

GSM_df = GSM_df[GSM_df.series != "gse79816 "]
GSM_df = GSM_df[GSM_df.series != "gse98970 "]



for index in GSM_df.index.values: 
    GSM_df.loc[index, "exptype"] = findExpType(index, GSM_dictionary, GSM_df)

for index in GSM_df.index.values: 
    GSM_df.loc[index, "organism"] = findOrganism(index, GSM_dictionary, GSM_df)

for index in GSM_df.index.values: 
    GSM_df.loc[index, "mouseline"] = findMouseline(index, GSM_dictionary, GSM_df)

for index in GSM_df.index.values: 
    GSM_df.loc[index, "cellline"] = findCellline(index, GSM_dictionary, GSM_df)
    
for index in GSM_df.index.values: 
    GSM_df.loc[index, "strain"] = findStrain(index, GSM_dictionary, GSM_df)  

for index in GSM_df.index.values: 
    GSM_df.loc[index, "source"] = findSource_Tissue(index, GSM_dictionary, GSM_df) 

for index in GSM_df.index.values: 
   GSM_df.loc[index, "selectionmarker"] = findSelectionMarker(index, GSM_dictionary, GSM_df)

for index in GSM_df.index.values: 
    GSM_df.loc[index, "celltype"] = findCelltype(index, GSM_dictionary, GSM_df)
    
for index in GSM_df.index.values: 
    GSM_df.loc[index, "treatment"] = findTreatment(index, GSM_dictionary, GSM_df)
    
for index in GSM_df.index.values: 
   GSM_df.loc[index, "age"] = findAge(index, GSM_dictionary, GSM_df)

for index in GSM_df.index.values: 
    GSM_df.loc[index, "devstage"] = findDevelopment(index, GSM_dictionary, GSM_df)

for index in GSM_df.index.values: 
    GSM_df.loc[index, "sex"] = findSex(index, GSM_dictionary, GSM_df)

######################### CLEAN UP #############################################
### source/tissue ###



GSM_df.source = [row.replace("tissue: ", "") for row in GSM_df.source]
GSM_df.source = [row.replace("source name ", "") for row in GSM_df.source]
GSM_df.source = [re.sub(" organism .*:", "", row) for row in GSM_df.source]
GSM_df.source = [re.sub("cell type:", "", row) for row in GSM_df.source]
GSM_df.source = [re.sub("selection marker:", "", row) for row in GSM_df.source]
GSM_df.source = [re.sub("sex:", "", row) for row in GSM_df.source]
GSM_df.source = [re.sub("strain:", "", row) for row in GSM_df.source]
GSM_df.source = [re.sub("gender:", "", row) for row in GSM_df.source]
GSM_df.source = [re.sub("l5 drg injury single cell|l5 drg intact single cell|l5 drg intact bulk cell", "dorsal root ganglion", row) for row in GSM_df.source]
GSM_df.source = [re.sub("dorsal root ganglion ", "dorsal root ganglion", row) for row in GSM_df.source]
GSM_df.source = [re.sub("whole brain |brain ", "brain", row) for row in GSM_df.source]
GSM_df.source = [re.sub("whole cortex |cortex ", "cortex", row) for row in GSM_df.source]
GSM_df.source = [re.sub("striatum ", "striatum", row) for row in GSM_df.source]
GSM_df.source = [re.sub("hes da commercial|rna from es cells or differentiated es cells ", "stem cells", row) for row in GSM_df.source]
GSM_df.source = [re.sub("developing ventral midbraincells extracted", "ventral midbrain", row) for row in GSM_df.source]

GSM_df.source.value_counts()


#####################################################

### Cell Type ###

missing = GSM_df[GSM_df.celltype == "Not Found"]
missing.series.value_counts()

GSM_df.celltype = [re.sub("protocol:|location:|age:|group:|strain:", "", row) for row in GSM_df.celltype]
GSM_df.celltype = [re.sub("cell type: |cell population: |cell_type: ", "", row) for row in GSM_df.celltype]
GSM_df.celltype = [re.sub("\n.*", "", row) for row in GSM_df.celltype]
GSM_df.celltype = [re.sub("astro[^ ]*", "astrocyte", row) for row in GSM_df.celltype]
GSM_df.celltype = [re.sub(".* pyramidal", "pyramidal", row) for row in GSM_df.celltype]
GSM_df.celltype = [re.sub(".* granule", "granule", row) for row in GSM_df.celltype]
GSM_df.celltype = [re.sub("cells", "cell", row) for row in GSM_df.celltype]
GSM_df.celltype = [re.sub("munclassified|unk", "unknown", row)for row in GSM_df.celltype]
GSM_df.celltype = [re.sub("newly|oligo", "oligodendrocyte", row)for row in GSM_df.celltype]
GSM_df.celltype = [re.sub("myelinating", "myelinating oligodendrocyte", row)for row in GSM_df.celltype]


### modifications based on GSE76381
GSM_df.celltype = [re.sub("(hnbml|mnbml|enbml)[0-9]?", "mediolateral neuroblasts", row)for row in GSM_df.celltype]
GSM_df.celltype = [re.sub("(hnbm|mnbm|enbm)[0-9]?", "medial neuroblast", row)for row in GSM_df.celltype]
GSM_df.celltype = [re.sub("(homtn|momtn|eomtn)[0-9]?", "oculomotor and trochlear nucleus", row)for row in GSM_df.celltype]
GSM_df.celltype = [re.sub("(hnbda|mnbda|enbda)[0-9]?", "neuroblast dopaminergic", row)for row in GSM_df.celltype]
GSM_df.celltype = [re.sub("(hda|mda|eda|ida)[abcvt0-9]+|da-.*", "dopaminergic neuron", row)for row in GSM_df.celltype]
GSM_df.celltype = [re.sub("(hrn|mrn)[0-9]?", "red nucleus", row)for row in GSM_df.celltype]
GSM_df.celltype = [re.sub("(hgaba|mgaba|egaba)[ab0-9]*", "GABAergic neurons", row)for row in GSM_df.celltype]
GSM_df.celltype = [re.sub("(hmnb|mmnbl|emnbl)[0-9]?", "lateral neuroblasts", row)for row in GSM_df.celltype]
GSM_df.celltype = [re.sub("(hnb|mnb|enb|inb)[0-9]?", "lateral neuroblasts", row)for row in GSM_df.celltype]
GSM_df.celltype = [re.sub("(hnprog|mnprog|enprog)[0-9]?", "neuronal progenitor", row)for row in GSM_df.celltype]
GSM_df.celltype = [re.sub("(hprog|mprog|eprog|iprog)[abc0-9]*", "progenitor", row)for row in GSM_df.celltype]
GSM_df.celltype = [re.sub("(hrgl|mrgl|ergl|irgl)[acb0-9]*", "radial glia-like cells", row)for row in GSM_df.celltype]
GSM_df.celltype = [re.sub("(hmgl|mmgl|emgl)[0-9]?", "microglia", row)for row in GSM_df.celltype]
GSM_df.celltype = [re.sub("(hperic|mperic|eperic)[0-9]?", "pericytes", row)for row in GSM_df.celltype]
GSM_df.celltype = [re.sub("(hepend|mepend|eepend|ependy.*)[0-9]?", "ependymal", row)for row in GSM_df.celltype]
GSM_df.celltype = [re.sub("(hendo|mendo|eendo)[0-9]?", "endothelial", row)for row in GSM_df.celltype]
GSM_df.celltype = [re.sub("(hopc|mopc|eopc|opc)[0-9]?", "oligodendrocyte precursor", row)for row in GSM_df.celltype]
GSM_df.celltype = [re.sub("(hsert|msert|esert|sert)[0-9]?", "serotonergic", row)for row in GSM_df.celltype]
GSM_df.celltype = [re.sub("esc[abc]?|ES: .*", "stem cells", row)for row in GSM_df.celltype]
GSM_df.celltype = [re.sub("irn", "red nucleus", row)for row in GSM_df.celltype]

GSM_df.celltype = [re.sub("radial glia-like cells.*", "radial glia-like cells ", row)for row in GSM_df.celltype]
GSM_df.celltype = [re.sub("lateral neuroblasts.*", "lateral neuroblasts", row)for row in GSM_df.celltype]
GSM_df.celltype = [re.sub("progenitor.*", "progenitor", row)for row in GSM_df.celltype]

GSM_df.celltype.value_counts()
################################################################################

### sex ###

GSM_df.sex = [re.sub("\n.*", "", row) for row in GSM_df.sex]
GSM_df.sex = [re.sub("age:", "", row) for row in GSM_df.sex]
GSM_df.sex = [re.sub("sex: |gender: ", "", row) for row in GSM_df.sex]
GSM_df.sex = [re.sub("male", "m", row) for row in GSM_df.sex]
GSM_df.sex = [re.sub("female|fem", "f", row) for row in GSM_df.sex]
GSM_df.sex = [re.sub("mixed", "pooled", row) for row in GSM_df.sex]
GSM_df.sex = [re.sub("na", "none", row) for row in GSM_df.sex]
GSM_df.sex = [re.sub("\?", "Not Found", row) for row in GSM_df.sex]

GSM_df.sex = [re.sub("m", "male", row) for row in GSM_df.sex]
GSM_df.sex = [re.sub("f", "female", row) for row in GSM_df.sex]


GSM_df.sex.value_counts()
################################################################################3

### age ###

GSM_df.age = [row.lower() for row in GSM_df.age]
GSM_df.age = [re.sub("\n.*|strain:|age: |inferred cell|tissue:|growth|treatment", "", row) for row in GSM_df.age]
GSM_df.age = [re.sub(" weeks| week| wks| wk|wk", "w", row) for row in GSM_df.age]
GSM_df.age = [re.sub(" months| month", "mo", row) for row in GSM_df.age]
GSM_df.age = [re.sub(" days| day", "d", row) for row in GSM_df.age]
GSM_df.age = [re.sub(" days| day", "d", row) for row in GSM_df.age]


GSM_df.age.value_counts()
###################################################################################

### cellline ###

GSM_df.cellline = [re.sub("\n.*", "", row) for row in GSM_df.cellline]

GSM_df.cellline.value_counts()
################################################################################

### strain ###

GSM_df.strain = [row.lower() for row in GSM_df.strain]
GSM_df.strain = [re.sub("strain: |gender:|inferred|tissue:|organ:|genotype:|developmental", "", row) for row in GSM_df.strain]
GSM_df.strain = [re.sub("cd-1", "cd1", row) for row in GSM_df.strain]

GSM_df.strain.value_counts()
##################################################################################

### exptype ###

GSM_df.exptype = [re.sub("sample type ", "", row) for row in GSM_df.exptype]

GSM_df.exptype.value_counts()
###################################################################################

### organism ###

GSM_df.organism = [re.sub("organism ", "", row) for row in GSM_df.organism]

GSM_df.organism.value_counts()
####################################################################################

### treatment ###

GSM_df.treatment = [re.sub("treatment: |variation: |developmental|sample group: |mouse", "", row) for row in GSM_df.treatment]
GSM_df.treatment = [re.sub("\n.*|;", "", row) for row in GSM_df.treatment]
GSM_df.treatment.value_counts()
#####################################################################

### selection marker ###

GSM_df.selectionmarker= [re.sub("treatment:|genotype/variation:|developmental", "", row) for row in GSM_df.selectionmarker]
GSM_df.selectionmarker.value_counts()
#########################################################################

### dev stage ###
### (including) move age and development stage to the correct columns


GSM_df.devstage = [re.sub("tissue:|\n.*", "", row) for row in GSM_df.devstage]
GSM_df.devstage = [row if row.lower().startswith("p")|row.lower().startswith("e") else "Not Found"  for row in GSM_df.age ]
GSM_df.devstage.value_counts()
#########################################################################





##break out treatment
#genetic background= mouse line? >>> link to specific disease
#knockout or no
#overexpression
#treatment with a drug
#treatment with any external source
#start with more general>>get specific
#############################################################################












