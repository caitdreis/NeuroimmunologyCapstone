# -*- coding: utf-8 -*-
"""
Created on Wed Dec  6 18:19:46 2017

@author: mkw5c
"""

from GEO_metadata_scraper_functions import *
import pandas as pd
import numpy as np


#create an empty dataframe to store the metadata in
columns = ["series", "exptype", "organism", "mouseline", "cellline", "strain", "organ", "source",\
           "selectionmarker", "celltype", "treatment", "age", "devstage", "sex"]
index = sample_ids
GSM_df = pd.DataFrame(index = index, columns = columns) 

n = 0
for sample in sample_ids: 
    if sample in GSM_dictionary.keys():
        n +=1
    else:
        print(sample + "\n")
print(n)

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

#for index in GSM_df.index.values: 
   # GSM_df.loc[index, "organ"] = findOrgan(index, GSM_dictionary, GSM_df)  

for index in GSM_df.index.values: 
    GSM_df.loc[index, "source"] = findSource_Tissue(index, GSM_dictionary, GSM_df) 

for index in GSM_df.index.values: 
   GSM_df.loc[index, "selection marker"] = findSelectionMarker(index, GSM_dictionary, GSM_df)

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

########### CHECK FOR NA's ###############################################################

keep_going = "yes"
while keep_going != 'no':
    column_to_check = input("Enter the name of the column you want to check for completion: ")
    print(GSM_df[column_to_check].value_counts())
    print(GSM_df.loc[GSM_df[column_to_check] == "Not Found", column_to_check])
    print(GSM_df.loc[GSM_df[column_to_check] == "Not Found", "series"])
    keep_going = input("Would you like to check another column? ").lower()
    