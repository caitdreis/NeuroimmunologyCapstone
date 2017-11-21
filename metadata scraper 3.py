# -*- coding: utf-8 -*-
"""
Created on Mon Nov 20 11:36:57 2017

@author: mkw5c
"""

import requests
from bs4 import BeautifulSoup
import re
import os
import numpy as np
import pandas as pd


def getgeo(series_ids):
    GSM_ids = []
    Download_manually = []
    for id in series_ids: 
        #download the page for the series
        page = requests.get("https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=" + id)
        #check if the page downloaded correctly
        print("\n"+ id + " Status: " + str(page.status_code))
    
        #create an instance of the beautiful soup class
        soup = BeautifulSoup(page.content, 'html.parser')
    
        #find all of the "a" tags, get text from the a tags that have links to samples
        a_tags = soup.find_all('a')
        for a in a_tags: 
            if a.get_text().startswith("GSM"):
                GSM_ids.append(a.get_text())
                if a.get_text() == 'You can also download a list of all accessions here':
                    print(id + ": Too Many Samples: download a list of all accessions from GEO")
                    Download_manually.append(id)
    print("Need to Download: " + str(Download_manually))
    return(GSM_ids)

def getsamplesmanually(file_path, sample_list):
    files = []
    for file in os.listdir(file_path):
        if file.endswith(".txt"):
            files.append(os.path.join(file_path, file))
    for file in files: 
        hand = open(file)
        for line in hand: 
            if line.startswith("!Series_sample_id"): 
                sample_list.append(line[20:30])

    for item in sample_list: 
        item.strip()
        if item.startswith("G") == False: 
            print("fix" + item)
    return(sample_list)
        
        
def getsamplemetadata(sample_ids):
    i = 0       
    GSM_dict = {} 
    for id in sample_ids:
        i = i +1
        if i%100 == 0: 
            print(i)
        page = requests.get("https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=" + id)
        soup = BeautifulSoup(page.content, 'html.parser')  
        td_tags = soup.find_all("td")
        
        sample_info = str()
        for td in td_tags:
            sample_info+= str(td.get_text()) + " "
        GSM_dict.update({id: sample_info})
    return(GSM_dict)

###################################################################################################
#GEO series IDs for which we want sample metadata
series_ids = ["GSE98969", "GSE98563", "GSE67833", "GSE52564","GSE71585",
                     "GSE60361", "GSE94579", "GSE87069", "GSE79819", "GSE56638", "GSE82187", 
                     "GSE67403", "GSE74985", "GSE71453","GSE79539","GSE83948","GSE76381", "GSE98971"]

#use the getgeo function to get the sample IDs for each series. 
sample_ids = getgeo(series_ids)

#get sample ids from manually downloaded files
#sample_ids = getsamplesmanually("C:/Users/mkw5c/documents/Neuro Capstone/GEO sample lists", sample_ids)

#use the getsamplemetadata function to scrape the metadata for each sample from the GEO page
#returns a dictionary with the sample id as the key and the metadata as a string value
GSM_dictionary = getsamplemetadata(sample_ids)

#create an empty dataframe to store the metadata in
columns = ["exptype", "organism", "mouseline", "cellline", "strain", "organ", "source",\
           "selectionmarker", "celltype", "disease_state", "age", "devstage", "gender"]
index = sample_ids
GSM_df = pd.DataFrame(index = index, columns = columns) 
GSM_df= GSM_df.fillna(0) 

#################################################################################################

#create functions to search for metadata categories
def findExpType(key, dictionary, df):
        search = re.search('Sample type ([A-Za-z]*) ', dictionary[key])
        if search:
            return(search.group(0))
        else: 
            return("Not Found")
def findOrganism(key, dictionary, df):
        search = re.search('Organism ([A-Za-z]*) ([A-Za-z]*) ', dictionary[key])
        if search:
            return(search.group(0))
        else: 
            return("Not Found")
        
def findAge(key, dictionary, df):
    trythis = GSM_dictionary[key].split()
    for x in range(0, len(trythis)):
        search = re.search("age ", trythis[x])
        if search:
            return(trythis[(x-10):(x+10)])
        else: 
            return("Not Found")

def findMouseline(key, dictionary, df):
        search = re.search('mouse line: ([^ ]*)|Mouse line: ([^ ]*)|Mouse line ([^ ]*)|mouse line ([^ ]*)', dictionary[key])
        if search:
            return(search.group(0))
        else: 
            return("Not Found")

def findCellline(key, dictionary, df):
        search = re.search('cell line: ([^ ]*)|Cell line: ([^ ]*)|Cell line ([^ ]*)|cell line ([^ ]*)', dictionary[key])
        if search:
            return(search.group(0))
        else: 
            return("Not Found")
        
def findStrain(key, dictionary, df):
        search = re.search('strain: ([^ ]*)|Strain: ([^ ]*)|Strain ([^ ]*)', dictionary[key])
        if search:
            return(search.group(0))
        else: 
            return("Not Found")
        
def findOrgan(key, dictionary, df): 
def findSource_Tissue(key, dictionary, df):
def findSelectionmMarker(key, dictionary, df):
def findCelltype(key, dictionary, df):
def findDiseaseState(key, dictionary, df):
def findDevelopment(key, dictionary, df):
def findGender(key, dictionary, df):


########################################################################################
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

     

########### PRACTICE ###############################################################
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


