# -*- coding: utf-8 -*-
"""
Created on Wed Dec 13 19:34:19 2017

@author: mkw5c
"""

import re

### source/tissue ###

GSM_df.source.value_counts()

source2 = [row.replace("tissue: ", "") for row in GSM_df.source]
GSM_df.source = source2

source3 = [row.replace("source name ", "") for row in GSM_df.source]
GSM_df.source = source3

source4 = [re.sub(" organism .*:", "", row) for row in GSM_df.source]
GSM_df.source = source4

source5 = [re.sub("cell type:", "", row) for row in GSM_df.source]
GSM_df.source = source5

source6 = [re.sub("selection marker:", "", row) for row in GSM_df.source]
GSM_df.source = source6

source7 = [re.sub("sex:", "", row) for row in GSM_df.source]
GSM_df.source = source7

source8 = [re.sub("strain:", "", row) for row in GSM_df.source]
GSM_df.source = source8

source9 = [re.sub("gender:", "", row) for row in GSM_df.source]
GSM_df.source = source9

source10 = [re.sub("l5 drg injury single cell|l5 drg intact single cell|l5 drg intact bulk cell", "dorsal root ganglion", row) for row in GSM_df.source]
GSM_df.source = source10

source11 = [re.sub("dorsal root ganglion ", "dorsal root ganglion", row) for row in GSM_df.source]
GSM_df.source = source11

source12 = [re.sub("whole brain |brain ", "brain", row) for row in GSM_df.source]
GSM_df.source = source12

source13 = [re.sub("whole cortex |cortex ", "cortex", row) for row in GSM_df.source]
GSM_df.source = source13

source14 = [re.sub("striatum ", "striatum", row) for row in GSM_df.source]
GSM_df.source = source14

source15 = [re.sub("hes da commercial|rna from es cells or differentiated es cells ", "stem cells", row) for row in GSM_df.source]
GSM_df.source = source15

source16 = [re.sub("developing ventral midbraincells extracted", "ventral midbrain", row) for row in GSM_df.source]
GSM_df.source = source16



#####################################################

### Cell Type ###

GSM_df.celltype.value_counts()
missing = GSM_df[GSM_df.celltype == "Not Found"]
missing.series.value_counts()

cell2= [re.sub("protocol:|location:|age:|group:|strain:", "", row) for row in GSM_df.celltype]
GSM_df.celltype = cell2

cell3= [re.sub("cell type: |cell population: |cell_type: ", "", row) for row in GSM_df.celltype]
GSM_df.celltype = cell3

cell4 = [re.sub("\n.*", "", row) for row in GSM_df.celltype]
GSM_df.celltype = cell4

cell5 = [re.sub("astro[^ ]*", "astrocyte", row) for row in GSM_df.celltype]
GSM_df.celltype = cell5

cell6= [re.sub(".* pyramidal", "pyramidal", row) for row in GSM_df.celltype]
GSM_df.celltype = cell6

cell7= [re.sub(".* granule", "granule", row) for row in GSM_df.celltype]
GSM_df.celltype = cell7

cell8 = [re.sub("cells", "cell", row) for row in GSM_df.celltype]
GSM_df.celltype = cell8

cell9= [re.sub("munclassified|unk", "unknown", row)for row in GSM_df.celltype]
GSM_df.celltype = cell9

cell10 = [re.sub("newly|oligo", "oligodendrocyte", row)for row in GSM_df.celltype]
GSM_df.celltype = cell10

cell11 = [re.sub("myelinating", "myelinating oligodendrocyte", row)for row in GSM_df.celltype]
GSM_df.celltype = cell11

GSM_df.celltype.value_counts()
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


################################################################################

### sex ###

GSM_df.sex.value_counts()

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

################################################################################3

### age ###

GSM_df.age.value_counts()

GSM_df.age = [row.lower() for row in GSM_df.age]
GSM_df.age = [re.sub("\n.*|strain:|age: |inferred cell|tissue:|growth|treatment", "", row) for row in GSM_df.age]
GSM_df.age = [re.sub(" weeks| week| wks| wk|wk", "w", row) for row in GSM_df.age]
GSM_df.age = [re.sub(" months| month", "mo", row) for row in GSM_df.age]
GSM_df.age = [re.sub(" days| day", "d", row) for row in GSM_df.age]
GSM_df.age = [re.sub(" days| day", "d", row) for row in GSM_df.age]

###################################################################################

### cellline ###

GSM_df.cellline.value_counts()
GSM_df.cellline = [re.sub("\n.*", "", row) for row in GSM_df.cellline]

################################################################################

### strain ###

GSM_df.strain.value_counts()
GSM_df.strain = [row.lower() for row in GSM_df.strain]
GSM_df.strain = [re.sub("strain: |gender:|inferred|tissue:|organ:|genotype:|developmental", "", row) for row in GSM_df.strain]
GSM_df.strain = [re.sub("cd-1", "cd1", row) for row in GSM_df.strain]

##################################################################################

### exptype ###

GSM_df.exptype.value_counts()
GSM_df.exptype = [re.sub("sample type ", "", row) for row in GSM_df.exptype]

###################################################################################

### organism ###
GSM_df.organism.value_counts()
GSM_df.organism = [re.sub("organism ", "", row) for row in GSM_df.organism]

####################################################################################

### treatment ###

GSM_df.treatment.value_counts()
GSM_df.treatment = [re.sub("treatment: |variation: |developmental|sample group: |mouse", "", row) for row in GSM_df.treatment]
GSM_df.treatment = [re.sub("\n.*|;", "", row) for row in GSM_df.treatment]

#####################################################################

### selection marker ###
GSM_df.selectionmarker.value_counts()
GSM_df.selectionmarker= [re.sub("treatment:|genotype/variation:|developmental", "", row) for row in GSM_df.selectionmarker]

#########################################################################

### dev stage ###

GSM_df.devstage.value_counts()
GSM_df.devstage = [re.sub("tissue:|\n.*", "", row) for row in GSM_df.devstage]

#########################################################################

GSM_df2 = GSM_df[GSM_df.series != "gse79816 "]
GSM_df3 = GSM_df2[GSM_df2.series != "gse98970 "]













