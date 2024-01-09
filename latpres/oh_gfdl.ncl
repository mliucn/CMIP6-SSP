

  f1 = addfile ("../gfdl/data/oh_AERmon_GFDL-ESM4_ssp126_r1i1p1f1_gr1_201501-210012.nc", "r")
  f2 = addfile ("../gfdl/data/ps_Amon_GFDL-ESM4_ssp126_r1i1p1f1_gr1_201501-210012.nc", "r")
  f3 = addfile ("../gfdl/data/ta_CFmon_GFDL-ESM4_ssp126_r1i1p1f1_gr1_201501-210012.nc","r")

  f = addfile ("../gfdl/data/ptp_AERmon_GFDL-ESM4_ssp126_r1i1p1f1_gr1_201501-210012.nc","r")

  plev = (/ 1000,975,925,850,700,600,500,400,300,200,100/)
  plev@units     = "hPa"

  ptp = dim_avg_n(f->ptp(0:11,:,:),0)/100.
  longpt = dim_avg_n(ptp,1)

  lat = f1->lat
  lev = f1->lev

  ta1 = f3->ta(:,:,:,:)
  ps1  = f2->ps(:,:,:)
  bc1  = f1->oh(:,:,:,:)                          ; temp: hybrid mid-levels

  pres1 = bc1
  ndims = dimsizes(pres1)
  print(doubletofloat(lev))

  do k=0,ndims(1)-1
   pres1(:,k,:,:) = ps1 * doubletofloat(lev(k))
  end do

  bc1 =   bc1/(8.314*ta1/pres1) * 1.e-6 * 6.02e23/1.e5  ; 1.e6/cm3

  pres1 = pres1/100.
  bc11 = linint1_n(pres1, bc1, False, plev, 0, 1)

  bc2 = dim_avg_n(bc11,3)

  system("/bin/rm -f ./data/oh126_gfdl.nc")
  ff = addfile ("./data/oh126_gfdl.nc","c")
  ff->lat = lat
  ff->pres = plev
  ff->OH = bc2
