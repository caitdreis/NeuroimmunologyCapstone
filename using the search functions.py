# -*- coding: utf-8 -*-
"""
Created on Wed Dec  6 18:19:46 2017

@author: mkw5c
"""

from GEO_metadata_scraper_functions import *
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

    
