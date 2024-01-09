

  f1 = addfile ("../ukesm/data/oh_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_201501-204912.nc", "r")
  f2 = addfile ("../ukesm/data/pfull_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_201501-204912.nc", "r")
  f3 = addfile ("../ukesm/data/ta_CFmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_201501-204912.nc","r")

  f = addfile ("../ukesm/data/ptp_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_201501-204912.nc","r")

  f4 = addfile ("../ukesm/data/oh_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_205001-209912.nc", "r")
  f5 = addfile ("../ukesm/data/pfull_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_205001-209912.nc", "r")
  f6 = addfile ("../ukesm/data/ta_CFmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_205001-209912.nc","r")

  f7 = addfile ("../ukesm/data/oh_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_210001-210012.nc", "r")
  f8 = addfile ("../ukesm/data/pfull_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_210001-210012.nc", "r")
  f9 = addfile ("../ukesm/data/ta_CFmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_210001-210012.nc","r")

  plev = (/ 1000,975,925,850,700,600,500,400,300,200,100/)
  plev@units     = "hPa"

  ptp = dim_avg_n(f->ptp(0:11,:,:),0)/100.
  longpt = dim_avg_n(ptp,1)

  lat = f1->lat

  ta1 = array_append_record(f3->ta(:,:,:,:),f6->ta(:,:,:,:),0)
  ta2 = array_append_record(ta1,f9->ta(:,:,:,:),0)

  pres1  =  array_append_record(f2->pfull(:,:,:,:),f5->pfull(:,:,:,:),0)
  pres2 = array_append_record(pres1,f8->pfull(:,:,:,:),0)

  bc1 = array_append_record(f1->oh(:,:,:,:),f4->oh(:,:,:,:),0) ; mol/mol
  bc2 = array_append_record(bc1,f7->oh(:,:,:,:),0)

  bc2 =   bc2/(8.314*ta2/pres2) * 1.e-6 * 6.02e23/1.e5  ; 1.e6/cm3

  pres2 = pres2/100.
  bc11 = linint1_n(pres2, bc2, False, plev, 0, 1)

  bc3 = dim_avg_n(bc11,3)

  system("/bin/rm -f ./data/oh126_ukesm.nc")
  ff = addfile ("./data/oh126_ukesm.nc","c")
  ff->lat = lat
  ff->pres = plev
  ff->OH = bc3
