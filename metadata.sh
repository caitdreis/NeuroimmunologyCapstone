#!/bin/bash

#Functions that support the scraper
python Metadata_scraper/GEO_metadata_scraper_functions.py

#Pulling specific GEO series IDs for which we are interested in pulling the metadata
python Metadata_scraper/using_metadata_scraper.py

#Execution of the search functions on our dataframe and searching for missing values
python Metadata_scraper/using_the_search_functions.py
