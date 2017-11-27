# -*- coding: utf-8 -*-
"""
Created on Mon Nov 27 07:40:34 2017

@author: mkw5c
"""
from GEO_metadata_scraper_functions import *
import pandas as pd

#GEO series IDs for which we want sample metadata
series_ids = ["GSE98969"] #"GSE98563", "GSE67833", "GSE52564","GSE71585",
                     #"GSE60361", "GSE94579", "GSE87069", "GSE79819", "GSE56638", "GSE82187", 
                    # "GSE67403", "GSE74985", "GSE71453","GSE79539","GSE83948","GSE76381", "GSE98971"]

#use the getgeo function to get the sample IDs for each series. 
sample_ids = getgeo(series_ids)

#get sample ids from manually downloaded files
#sample_ids = getsamplesmanually("C:/Users/mkw5c/documents/Neuro Capstone/GEO sample lists", sample_ids)

#use the getsamplemetadata function to scrape the metadata for each sample from the GEO page
#returns a dictionary with the sample id as the key and the metadata as a string value
GSM_dictionary = getsamplemetadata(sample_ids)
GSM_dictionary.keys()
GSM_dictionary['GSM2629401']
#create an empty dataframe to store the metadata in
columns = ["exptype", "organism", "mouseline", "cellline", "strain", "organ", "source",\
           "selectionmarker", "celltype", "disease_state", "age", "devstage", "gender"]
index = sample_ids
GSM_df = pd.DataFrame(index = index, columns = columns) 
GSM_df= GSM_df.fillna(0) 


##use the functions

for index in GSM_df.index.values: 
    GSM_df.loc[index, "exptype"] = findExpType(index, GSM_dictionary, GSM_df)

for index in GSM_df.index.values: 
    GSM_df.loc[index, "organism"] = findOrganism(index, GSM_dictionary, GSM_df)

for index in GSM_df.index.values: 
    GSM_df.loc[index, "age"] = findAge(index, GSM_dictionary, GSM_df)

for index in GSM_df.index.values: 
    GSM_df.loc[index, "mouseline"] = findMouseline(index, GSM_dictionary, GSM_df)

for index in GSM_df.index.values: 
    GSM_df.loc[index, "cellline"] = findCellline(index, GSM_dictionary, GSM_df)
    
for index in GSM_df.index.values: 
    GSM_df.loc[index, "strain"] = findStrain(index, GSM_dictionary, GSM_df)  


########### TROUBLESHOOTING ###############################################################
trythis = GSM_dictionary['GSM2599762'].split()
for x in range(0, len(trythis)):
    search = re.search(" age ", trythis[x])
    if search:
        print(trythis[(x-10):(x+10)])
        

    search= re.search('strain: ([^ ]*)', GSM_dictionary['GSM2599762'])
    if search: 
        print(search.group(0))
        
print(GSM_dictionary['GSM2599762'])
print(GSM_df["strain"])
     