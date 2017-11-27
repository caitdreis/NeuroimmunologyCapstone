# -*- coding: utf-8 -*-
"""
Created on Mon Nov 20 11:36:57 2017

@author: mkw5c
"""

import requests
from bs4 import BeautifulSoup
import re
import os



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
        GSM_dict.update({id: sample_info.lower()})
    return(GSM_dict)

###################################################################################################

#create functions to search for metadata categories
def findExpType(key, dictionary, df):
        search = re.search('sample type ([a-z]*) ', dictionary[key])
        if search:
            return(search.group(0))
        else: 
            return(0)
def findOrganism(key, dictionary, df):
        search = re.search('organism ([a-z]*) ([a-z]*) ', dictionary[key])
        if search:
            return(search.group(0))
        else: 
            return(0)
        
def findAge(key, dictionary, df):
    trythis = GSM_dictionary[key].split()
    for x in range(0, len(trythis)):
        search = re.search("age ", trythis[x])
        if search:
            return(trythis[(x-10):(x+10)])
        else: 
            return(0)

def findMouseline(key, dictionary, df):
        search = re.search('mouse line([:]?) ([^ ]*)', dictionary[key])
        if search:
            return(search.group(0))
        else: 
            return("Not Found")

def findCellline(key, dictionary, df):
        search = re.search('cell line([:]?) ([^ ]*)', dictionary[key])
        if search:
            return(search.group(0))
        else: 
            return(0)
        
def findStrain(key, dictionary, df):
        search = re.search('strain([:]?) ([^ ]*)', dictionary[key])
        if search:
            return(search.group(0))
        else: 
            return("Not Found")
        
def findOrgan(key, dictionary, df): 
    search = re.search('organ([:]?) ([^ ]*)', dictionary[key])
    if search:
        return(search.group(0))
    else: 
        return(0)

def findSource_Tissue(key, dictionary, df):
    search = re.search('source name([:]?) ([^ ]*)|tissue([:]?) ([^ ]*)', dictionary[key])
    if search:
        return(search.group(0))
    else: 
        return("Not Found")

def findSelectionMarker(key, dictionary, df):
    search = re.search('selection marker([:]?) ([^ ]*)', dictionary[key])
    if search:
        return(search.group(0))
    else: 
        return(0)

def findCelltype(key, dictionary, df):
    search = re.search('cell type([:]?) ([^ ]*)', dictionary[key])
    if search:
        return(search.group(0))
    else: 
        return(0)
def findDiseaseState(key, dictionary, df):
    search = re.search('treatment([:]?) ([^ ]*)', dictionary[key])
    if search:
        return(search.group(0))
    else: 
        return(0)
    
def findDevelopment(key, dictionary, df):
    search = re.search('development stage([:]?) ([^ ]*)', dictionary[key])
    if search:
        return(search.group(0))
    else: 
        return(0)
    
def findGender(key, dictionary, df):
    search = re.search('sex([:]?) ([^ ]*)|gender([:]?) ([^ ]*)', dictionary[key])
    if search:
        return(search.group(0))
    else: 
        return(0)

if __name__ == '__main__':
    getgeo()
    getsamplesmanually()
    getsamplemetadata()
    findExpType()
    findOrganism()
    findMouseline()
    findCellline()
    findStrain()
    findAge()
    findOrgan()
    findSource_Tissue()
    findSelectionMarker()
    findCelltype()
    findDiseaseState()
    findDevelopment()
    findGender()
    
########################################################################################

  




















