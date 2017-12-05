# -*- coding: utf-8 -*-
"""
Created on Mon Nov 20 11:36:57 2017

@author: mkw5c
"""

import requests
from bs4 import BeautifulSoup
import re
import os



def getsampleid(series_id):
    GSM_ids = []
    Download_manually = []
    for id in series_id: 
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

def getsamplesmanually(file_path):
    files = []
    sample_list = []
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
        if item.endswith(" ") == True: 
            print('delete space for ' + item)
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

####  This function extracts the first sample id for each GEO series from the GEO series page 
####  and stores the sample id as a key in a dictionary with the series id as the value.  Then
####  the function calls the getsamplemetadata function to get the text from the sample page. 

def getfirstsample(series_id): 
    sample_ids = {}
    Download_manually = []
    for id in series_id: 
        #download the page for the series
        page = requests.get("https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=" + id)
        #check if the page downloaded correctly
        print("\n"+ id + " Status: " + str(page.status_code))
    
        #create an instance of the beautiful soup class
        soup = BeautifulSoup(page.content, 'html.parser')
    
        #find all of the "a" tags, get text from the a tags that have links to samples
        a_tags = soup.find_all('a')
        n = 0
        for a in a_tags:          
            if a.get_text().startswith("GSM"):
                sample_ids.update({a.get_text(): id})
                n += 1
            if n == 1:
                break
    return(sample_ids)   

###################################################################################################

#create functions to search for metadata categories
#### FINISHED:  the function returns all data in correct format
#### NEEDS FORMATTING:  function returns all the data and the data is correct but needs to be
#                        formatted for consistency
#### POINTING CORRECTLY:   the function returns data from the intended location for all samples
#                            but parsing may have led to incorrect entry                         
#### NEEDS MORE KEYWORDS: the function does not find the necessary information for all samples





#### FINISHED
def findSeries(key, dictionary, df):
        search = re.search('gse[0-9]+ ', dictionary[key])
        if search:
            return(search.group(0))
        else: 
            return("Not Found")
        
#### FINISHED
def findExpType(key, dictionary, df):
        search = re.search('sample type ([a-z]*) ', dictionary[key])
        if search:
            return(search.group(0))
        else: 
            return("Not Found")
        
#### FINISHED
def findOrganism(key, dictionary, df):
        search = re.search('organism ([a-z]*) ([a-z]*) ', dictionary[key])
        if search:
            return(search.group(0))
        else: 
            return("Not Found")

#### NEEDS MORE KEYWORDS
def findMouseline(key, dictionary, df, index):
        if "j14" in df.loc[index, "cellline"]:
            return("Lhx6-GFP")
        else: 
            search = re.search('mouse line([:]?) ([^ ]*)', dictionary[key])
            if search:
                return(search.group(0))
            else: 
                return("Not Found")

#### NEEDS FORMATTING
def findCellline(key, dictionary, df):
        search = re.search('cell line([:]?) ([^ ]*)|icell dopaneurons', dictionary[key])
        if search:
            return(search.group(0))
        else: 
            search = re.search('gse[0-9]+ ', dictionary[key])
            if "94579|76381" in search.group(0):
                return("Not Found")
            else:
                return("no cell line used")
        
#### POINTING CORRECTLY     
def findStrain(key, dictionary, df):
        search = re.search('strain([:]?) ([^ ]*)|c57bl/6|cd-1|cd1|5xfad', dictionary[key])
        if search:
            return(search.group(0))
        else: 
            return("Not Found")
        
###  USE TISSUE DATA TO INFER ORGAN       
#def findOrgan(index, df): 

    
    
#### POINTING CORRECTLY
def findSource_Tissue(key, dictionary, df):
    search = re.search('tissue: ([^ ]*)', dictionary[key])
    if search:
        return(search.group(0))
    else: 
        search2 = re.search('source name([:]?) ([^ ]*)', dictionary[key])
        if search2: 
            return(search2.group(0))
        else: 
            return("Not Found")
###  Not on most GEO sample sites... may be in the paper
def findSelectionMarker(key, dictionary, df):
    search = re.search('selection marker([:]?) ([^ ]*)', dictionary[key])
    if search:
        return(search.group(0))
    else: 
        return("Not Found")
#### POINTING CORRECTLY
def findCelltype(key, dictionary, df):
    search = re.search('cell[_ ]?type([:]?) ([^ ]*)|cell population: ([^ ]*)', dictionary[key])
    if search:
        return(search.group(0))
    else: 
        search2 = re.search('group: ([^ ]*)', dictionary[key])
        if search2:
            return("ES: " + str(search2.group(0)))
        else:
            return("Not Found")
#### function pointing well... need to check papers for other treatments/disease states    
def findTreatment(key, dictionary, df):
    search = re.search('treatment: ([^ ]* )', dictionary[key])
    if search:
        return(search.group(0))
    else: 
        if df.loc[key, "series"] == "gse71453 ":
            return("sciatic transection")
        else:
            return("Not Found")


def findAge(key, dictionary, df):
    search = re.search("age: ([a-z0-9]+) ([a-z]+) ", dictionary[key])
    if search:
        return(search.group(0))
    else: 
        search2 = re.search('[0-9]*-[0-9*] [^ ]* [^ ]* age([:]?)', dictionary[key])
        if search2:
            return(search2.group(0))
        else:
            return("Not Found")
    
def findDevelopment(key, dictionary, df):
    search = re.search('developmental stage([:]?) ([^ ]*)', dictionary[key])
    if search:
        return(search.group(0))
    else: 
        return("Not Found")

#### Pointing Correctly  
def findSex(key, dictionary, df):
    search = re.search('sex([:]?) ([^ ]*)|gender([:]?) ([^ ]*)', dictionary[key])
    if search:
        return(search.group(0))
    else: 
        search2 = re.search('(growth|extraction) protocol .* (extracted|library)', dictionary[key])
        if search2:
            search3 = re.search('male|female', search2.group(0))
            if search3:
                return(search3.group(0))
            else: 
                return("Not Found")
        else: 
            return("Error")


if __name__ == '__main__':
    getsampleid()
    getsamplesmanually()
    getsamplemetadata()
    getfirstsample()

########################################################################################





