

   f1 = addfile ("../ukesm/data/ta_CFmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_201501-204912.nc","r")
   f2 = addfile ("../ukesm/data/ta_CFmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_210001-210012.nc","r")

   aa = addfile ("../ukesm/data/areacella_fx_UKESM1-0-LL_piControl_r1i1p1f2_gn.nc","r")

   ta1 = dim_avg_n(f1->ta(0:11,0,:,:),0)
   ta2 = dim_avg_n(f2->ta(0:11,0,:,:),0)

   area = aa->areacella


   avg1 = wgt_areaave2(ta1,area,0)
   avg2 = wgt_areaave2(ta2,area,0)

   print(avg1)
   print(avg2)

   f3 = addfile ("../gfdl/data/ta_CFmon_GFDL-ESM4_ssp126_r1i1p1f1_gr1_201501-210012.nc","r")

   aa = addfile ("../gfdl/data/areacella_fx_GFDL-ESM4_historical_r1i1p1f1_gr1.nc","r")

   delete(ta1)
   delete(ta2)
   delete(area)
   ta1 = dim_avg_n(f3->ta(0:11,0,:,:),0)
   ta2 = dim_avg_n(f3->ta(1020:1031,0,:,:),0)

   area = aa->areacella


   avg1 = wgt_areaave2(ta1,area,0)
   avg2 = wgt_areaave2(ta2,area,0)

   print(avg1)
   print(avg2)   

   f4 = addfile ("../mri/data/ta_CFmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_201501-202412.nc","r")
   f5 = addfile ("../mri/data/ta_CFmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_209501-210012.nc","r")

   aa = addfile ("../mri/data/areacella_fx_MIROC-ES2L_historical_r1i1p1f2_gn.nc","r")

   lattemp = f4->lat
   lontemp = f4->lon

   lat1 = aa->lat
   lon1 = aa->lon

   delete(ta1)
   delete(ta2)
   delete(area)
   ta1 = dim_avg_n(f4->ta(0:11,0,:,:),0)
   ta2 = dim_avg_n(f5->ta(60:71,0,:,:),0)

   ta3 = linint2(lontemp,lattemp,ta1,True,lon1,lat1,0)
   ta4 = linint2(lontemp,lattemp,ta2,True,lon1,lat1,0)

   area = aa->areacella

   avg1 = wgt_areaave2(ta3,area,0)
   avg2 = wgt_areaave2(ta4,area,0)

   print(avg1)
   print(avg2)


