# CMIP6-SSP

This package made by M. Liu (liumingxu@pku.edu.cn) is used to analyze the global OH budget and its effect on CH4 from the CMIP6 model outputs. 

When using the codes for your study, please cite the referecne:
Liu et al.: Enhanced atmospheric oxidation toward carbon neutrality reduces methane’s climate forcing, Under review.

Instructions:

1. Please first install the NCL language following the guideline from the website: https://www.ncl.ucar.edu/Download/
2. Download the CMIP model data from the ESGF: https://esgf-node.llnl.gov/search/cmip6/
3. In this example, we use UKESM, GFDL, and MRI. Any other model ouputs can be avaialble, depending on the specific variables.
   Please put the original CMIP6 data into the corresponding directories, like /UKESM/data
4. Run NCL scripts to obtain the resutls. The analysis focuses on time series of global OH, CH4, and other compositions, estimation of CH4 lifetime and atmospheric abundance, and CH4 radiative forcing by 2100. 
