## GEO Metadata Scraper Information

1. The File "GEO_metadata_scraper_functions_final" defines all of the functions for collecting and parsing sample information from the Gene Expression Omnibus.  

2.  The spydata file "GEO_metadata_environment_pre_dataframe" is a python environment including a list of the Series IDs for our specific project, and a dictionary containing key value pairs in which each sample ID is a key, and the text scraped from the corresponding GEO page for that sample as the value. 

3.  The file "using_metadata_scraper_final" is a python file which uses some of the functions from the "GEO_metadata_scraper_functions_final" file to create the "GEO_metadata_environment_pre_dataframe" environment. ** This file takes a bit of time to run: if working on this specific project you can import "GEO_metadata_environment_pre_dataframe" to avoid running this file. 

4.  The file "using_the_search_functions_final" is a python script in which some of the functions from "GEO_metadata_scraper_functions_final" are used to parse through the text "values" in the dictionary and store the information in a dataframe containing all samples.  

5.  The file "GEO_metadata_environment_12.13.6.48.spydata" is the most current collection of the metadata for our specific investigation

## Short Instructions
1. import "GEO_metadata_environment_pre_dataframe" 
2. run "using_the_search_functions_final"



