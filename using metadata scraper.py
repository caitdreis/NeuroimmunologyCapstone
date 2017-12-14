# -*- coding: utf-8 -*-
"""
Created on Mon Nov 27 07:40:34 2017

@author: mkw5c
"""
from GEO_metadata_scraper_functions import *
import pandas as pd
import numpy as np
#GEO series IDs for which we want sample metadata
series_id1 = ["GSE98969", "GSE98563", "GSE67833", "GSE52564","GSE71585"]
series_id2 = ["GSE60361", "GSE94579", "GSE87069", "GSE79819", "GSE56638", "GSE82187"]
series_id3 = ["GSE67403", "GSE74985", "GSE71453","GSE59739","GSE83948","GSE76381", "GSE98971"]

#use the getgeo function to get the sample IDs for each series. 
sample_ids = getsampleid(series_id1)
sample_ids+= getsampleid(series_id2)
sample_ids+= getsampleid(series_id3)

#get sample ids from manually downloaded files
sample_ids += getsamplesmanually("C:/Users/mkw5c/documents/Neuro Capstone/GEO sample lists")


#use the getsamplemetadata function to scrape the metadata for each sample from the GEO page
#returns a dictionary with the sample id as the key and the metadata as a string value

GSM_dictionary = {}

GSM_dictionary.update(getsamplemetadata(sample_ids[0:1000]))
GSM_dictionary.update(getsamplemetadata(sample_ids[1000:2000]))
GSM_dictionary.update(getsamplemetadata(sample_ids[2000:3000]))
GSM_dictionary.update(getsamplemetadata(sample_ids[3000:4000]))
GSM_dictionary.update(getsamplemetadata(sample_ids[4000:5000]))
GSM_dictionary.update(getsamplemetadata(sample_ids[5000:6000]))
GSM_dictionary.update(getsamplemetadata(sample_ids[6000:7000]))
GSM_dictionary.update(getsamplemetadata(sample_ids[7000:8000]))
GSM_dictionary.update(getsamplemetadata(sample_ids[8000:9000]))
GSM_dictionary.update(getsamplemetadata(sample_ids[9000:10000]))
GSM_dictionary.update(getsamplemetadata(sample_ids[10000:11000]))
GSM_dictionary.update(getsamplemetadata(sample_ids[11000:12000]))
GSM_dictionary.update(getsamplemetadata(sample_ids[12000:13000]))
GSM_dictionary.update(getsamplemetadata(sample_ids[13000:14000]))
GSM_dictionary.update(getsamplemetadata(sample_ids[14000:15000]))
GSM_dictionary.update(getsamplemetadata(sample_ids[15000:16000]))
GSM_dictionary.update(getsamplemetadata(sample_ids[16000:16565]))

#####  found bugs-  ran 12/13/207 2:25

sample_ids = getsamplesmanually("C:/Users/mkw5c/documents/Neuro Capstone/GEO sample lists 2")

GSM_dictionary.update(getsamplemetadata(sample_ids[0:300]))
GSM_dictionary.update(getsamplemetadata(sample_ids[300:600]))
GSM_dictionary.update(getsamplemetadata(sample_ids[600:865]))












     