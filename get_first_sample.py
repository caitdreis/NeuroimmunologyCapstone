# -*- coding: utf-8 -*-
"""
Created on Wed Nov 29 16:38:36 2017

@author: mkw5c
"""

from GEO_metadata_scraper_functions import *
import pandas as pd

series_to_sample = ["GSE98969","GSE98563", "GSE67833", "GSE52564","GSE71585",
                     "GSE60361", "GSE94579", "GSE87069", "GSE79819", "GSE56638", "GSE82187", 
                     "GSE67403", "GSE74985", "GSE71453","GSE79539","GSE83948","GSE76381", "GSE98971"]

first_samples = getfirstsample(series_to_sample)
metadata = getsamplemetadata(first_samples.keys())

metadata_list = []
for v in metadata.items(): 
    metadata_list.append(str(v))

new_meta = [item.replace("-", " ") for item in metadata_list]

n = 0
with open('first samples.txt', 'w') as file:
    for item in new_meta: 
        print(n)
        file.write(str(item) + "\n\n\n\n\n")
        n = n+1

print(new_meta[0][1200:1220])




