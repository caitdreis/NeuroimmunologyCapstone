# -*- coding: utf-8 -*-
"""
Created on Mon Nov 27 07:40:34 2017

@author: mkw5c
"""
from GEO_metadata_scraper_functions import *
import pandas as pd
import numpy as np
#GEO series IDs for which we want sample metadata
series_id = ["GSE98969", "GSE98563", "GSE67833", "GSE52564","GSE71585",\
              "GSE60361","GSE94579", "GSE87069", "GSE79819", "GSE56638",\
              "GSE82187", "GSE67403", "GSE74985", "GSE71453","GSE59739",\
              "GSE83948","GSE76381", "GSE98971"]

#use the getgeo function to get the sample IDs for each series. 
sample_ids = getsampleid(series_id)


#get sample ids from manually downloaded files
sample_ids += getsamplesmanually("C:/Users/mkw5c/Documents/NeuroimmunologyCapstone/GEO sample lists")


#use the getsamplemetadata function to scrape the metadata for each sample from the GEO page
#returns a dictionary with the sample id as the key and the metadata as a string value

GSM_dictionary = {}
GSM_dictionary.update(getsamplemetadata(sample_ids)













     