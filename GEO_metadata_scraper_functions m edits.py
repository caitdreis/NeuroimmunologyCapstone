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
            if a.get_text() == 'You can also download a list of all accessions here':
                print(id + ": Too Many Samples: download a list of all accessions from GEO")
                Download_manually.append(id)
            elif a.get_text().startswith("GSM"):
                GSM_ids.append(a.get_text())

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

def findSeries(key, dictionary, df):
        search = re.search('gse[0-9]+ ', dictionary[key])
        if search:
            return(search.group(0))
        else: 
            return("Not Found")

def findExpType(key, dictionary, df):
        search = re.search('sample type ([a-z]*) ', dictionary[key])
        if search:
            return(search.group(0))
        else: 
            return("Not Found")

def findOrganism(key, dictionary, df):
        search = re.search('organism ([a-z]*) ([a-z]*) ', dictionary[key])
        if search:
            return(search.group(0))
        else: 
            return("Not Found")
###############################################################################################
## Need Formatting

def findAge(key, dictionary, df):
    search = re.search("age: ([a-z0-9.?]+) ([a-z]+)|age: ([a-z0-9.?]+) ([a-z]+):|age: ([a-z0-9.?]+):", dictionary[key])
    if search:
        return(search.group(0))
    else: 
        search2 = re.search('[0-9]*-[0-9*] [^ ]* [^ ]* age([:]?)', dictionary[key])
        if search2:
            return(search2.group(0))
        else:
            if (df.series.loc[key] == "gse71585 "):
                return("P56+-3")
            elif (df.series.loc[key] == "gse71453 "):
                return("2 mo")
            elif (df.series.loc[key] == "gse52564 "):
                return("P7")
            elif (df.series.loc[key] == "gse82187 "):
                return("5-7 wks")
            elif (df.series.loc[key] == "gse59739 "):
                return("6-8 wks")
            else:
                return("Not Found")

def findCellline(key, dictionary, df):
        search = re.search('cell line([:]?) ([^ ]*)|icell dopaneurons', dictionary[key])
        if search:
            return(search.group(0))
        else: 
            return("Not Found")

def findStrain(key, dictionary, df):
        search = re.search('strain([:]?) ([^ ]*)|5xfad|c57bl/6|cd-1|cd1', dictionary[key])
        if search:
            return(search.group(0))
        else:
            if (df.series.loc[key] == "gse82187 ")|(df.series.loc[key] == "gse67403 ")|(df.series.loc[key] == "gse74985 "):
                return("C57Bl/6J")
            else: 
                return("Not Found")

def findTreatment(key, dictionary, df):
    search = re.search('treatment: ([^ ]* )|sample group: ([^ ]* )|variation: ([^ ]* [^ ]* )', dictionary[key])
    if search:
        return(search.group(0))
    else: 
        if df.series.loc[key] == "gse71453 ":
            return("sciatic transection")
        elif (df.series.loc[key] == "gse76381 ")|(df.series.loc[key] == "gse60361 ")|\
             (df.series.loc[key] == "gse71585 ")|(df.series.loc[key] == "gse82187 ")|\
             (df.series.loc[key] == "gse83948 ")|(df.series.loc[key] == "gse94579 ")|\
             (df.series.loc[key] == "gse56638 ")|(df.series.loc[key] == "gse74985 ")|\
             (df.series.loc[key] == "gse79818 ")|(df.series.loc[key] == "gse52564 ")|\
             (df.series.loc[key] == "gse67403 ")|(df.series.loc[key] == "gse59739 "):
            return("healthy")
        else:
            return("Not Found")

def findSex(key, dictionary, df):
    search = re.search('sex([:]?) ([^ ]*)|gender([:]?) ([^ ]*)', dictionary[key])
    if search:
        return(search.group(0))
    elif (df.series.loc[key] == "gse87069 "):
        return("none")
    elif (df.series.loc[key] == "gse67403 "):
        return("male")
    elif (df.series.loc[key] == "gse98563 ")|(df.series.loc[key] == "gse74985 ")|(df.series.loc[key] == "gse52564 "):
        return("mixed")      
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

def findSource_Tissue(key, dictionary, df):
    search = re.search('tissue: ([^ :]* )*[a-z]*:', dictionary[key])
    if search:
        return(search.group(0))
    else: 
        search2 = re.search('source name([:]?) ([^ :]* )*[a-z]*: ', dictionary[key])
        if search2: 
            return(search2.group(0))
        elif df.series.loc[key] == "gse83948 ":
            search3 = re.search('source name([:]?) ([^ ]*) ', dictionary[key])
            if search3: 
                return(search3.group(0))
            else:
                return("Not Found")
        else: 
            return("Not Found")
###############################################################################################
## Not Complete        

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

########################################################################################

## May Need to Abandon

def findSelectionMarker(key, dictionary, df):
    search = re.search('selection marker([:]?) ([^ ]*)', dictionary[key])
    if search:
        return(search.group(0))
    else: 
        return("Not Found")

         
def findDevelopment(key, dictionary, df):
    search = re.search('developmental stage([:]?) ([^ ]*)', dictionary[key])
    if search:
        return(search.group(0))
    else: 
        return("Not Found")

def findMouseline(key, dictionary, df):
        if df.series.loc[key] == "gse82187 ":    
            if "neuron" in df.loc[key, "celltype"]:
                return("D1- tdTomato (tdTom)/D2-GFP")
            elif "astro" in df.loc[key, "celltype"]:
                return("Aldhl1-GFP")
        else:
            search = re.search('mouse line([:]?) ([^ ]*)|mouse line abbreviation([:]?) ([^ ]*) ', dictionary[key])
            if search:
                return(search.group(0))
            else: 
                return("Not Found")