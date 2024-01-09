
  f11 = addfile("../mri/data/lossco_AERmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_201501-202412.nc","r")
  f21 = addfile ("../mri/data/ta_CFmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_201501-202412.nc","r")
  f31 = addfile ("../mri/data/co_AERmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_201501-202412.nc","r")

  f12 = addfile("../mri/data/lossco_AERmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_202501-203412.nc","r")
  f22 = addfile ("../mri/data/ta_CFmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_202501-203412.nc","r")
  f32 = addfile ("../mri/data/co_AERmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_202501-203412.nc","r")

  f13 = addfile("../mri/data/lossco_AERmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_203501-204412.nc","r")
  f23 = addfile ("../mri/data/ta_CFmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_203501-204412.nc","r")
  f33 = addfile ("../mri/data/co_AERmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_203501-204412.nc","r")

  f14 = addfile("../mri/data/lossco_AERmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_204501-205412.nc","r")
  f24 = addfile ("../mri/data/ta_CFmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_204501-205412.nc","r")
  f34 = addfile ("../mri/data/co_AERmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_204501-205412.nc","r")

  f15 = addfile("../mri/data/lossco_AERmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_205501-206412.nc","r")
  f25 = addfile ("../mri/data/ta_CFmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_205501-206412.nc","r")
  f35 = addfile ("../mri/data/co_AERmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_205501-206412.nc","r")

  f = addfile ("../mri/data/areacella_fx_MIROC-ES2L_historical_r1i1p1f2_gn.nc","r")

  area = f->areacella

  lat = f11->lat
  lon = f11->lon
  lev = f11->lev

  lata = f21->lat
  lona = f21->lon

  nt = 12*10*5
  temp1 = new((/nt,dimsizes(lev),dimsizes(lata),dimsizes(lona)/),float)
  temp1(0:119,:,:,:) = f21->ta(:,:,:,:)
  temp1(120:239,:,:,:) = f22->ta(:,:,:,:)
  temp1(240:359,:,:,:) = f23->ta(:,:,:,:)
  temp1(360:479,:,:,:) = f24->ta(:,:,:,:)
  temp1(480:599,:,:,:) = f25->ta(:,:,:,:)

  ta1 = linint2(lona,lata,temp1,True,lon,lat,0)
  delete(temp1)

  loss1 = new((/nt,dimsizes(lev),dimsizes(lat),dimsizes(lon)/),float)
  loss1(0:119,:,:,:) = f11->lossco(:,:,:,:) ; mol/m3/s
  loss1(120:239,:,:,:) = f12->lossco(:,:,:,:)
  loss1(240:359,:,:,:) = f13->lossco(:,:,:,:)
  loss1(360:479,:,:,:) = f14->lossco(:,:,:,:)
  loss1(480:599,:,:,:) = f15->lossco(:,:,:,:)

  bc1 = new((/nt,dimsizes(lev),dimsizes(lat),dimsizes(lon)/),float)
  bc1(0:119,:,:,:) = f31->co(:,:,:,:)
  bc1(120:239,:,:,:) = f32->co(:,:,:,:)
  bc1(240:359,:,:,:) = f33->co(:,:,:,:)
  bc1(360:479,:,:,:) = f34->co(:,:,:,:)
  bc1(480:599,:,:,:) = f35->co(:,:,:,:)

  ps1 = new((/nt,dimsizes(lat),dimsizes(lon)/),float)
  ps1(0:119,:,:)  = f11->ps(:,:,:)
  ps1(120:239,:,:)  = f12->ps(:,:,:)
  ps1(240:359,:,:)  = f13->ps(:,:,:)
  ps1(360:479,:,:)  = f14->ps(:,:,:)
  ps1(480:599,:,:)  = f15->ps(:,:,:)

  dims = dimsizes(loss1)
  nt = dims(0)
  nz = dims(1)
  ny = dims(2)
  nx = dims(3)
  print(dims)


  abnd = doubletofloat(f11->a_bnds)
  bbnd = doubletofloat(f11->b_bnds)

  pres1 = ta1
  preshigh = ta1
  preslow = ta1
  ndims = dimsizes(pres1)
  do k=0,ndims(1)-1
   pres1(:,k,:,:) = ps1 * doubletofloat(lev(k))
   preshigh(:,k,:,:) = abnd(k,0)*100000. + bbnd(k,0) *  ps1  ; Pa layer    pressure at interface
   preslow(:,k,:,:) = abnd(k,1)*100000. + bbnd(k,1) *  ps1
  end do

  height1 = (1-((preslow/101350.)^0.1902))*153.8*(273.2+20.0) \  ; layer height m
     - (1-((preshigh/101350.)^0.1902))*153.8*(273.2+20.0)

  delete(ps1)
  
  mm = (/31.,28.,31.,30.,31.,30.,31.,31.,30.,31.,30.,31./)
  mm0 = conform_dims((/nt/12,12,nz,ny,nx/),mm,1)
  mm1 = reshape(mm0,(/nt,nz,ny,nx/))
  print(dimsizes(mm1))

  area1 = conform_dims((/nt,nz,ny,nx/),area,(/2,3/))

  bc1 = bc1/(8.314*ta1/pres1) ; from mol/mol to mol/m3
  bc1 = 1.0e-12 * bc1 * 16. * height1 * area1
  burden = month_to_annual(bc1,1) ; Tg
  delete(bc1)

  loss1 = loss1 * 3600. * 24. * mm1  ;mol/m3/month
  loss1 = 1.0e-12 * loss1 * 16. * height1 * area1  ; Tg/yr

  loss1all = month_to_annual(loss1,0)  ; Tg/yr
  data1 = dim_sum_n(burden,(/1,2,3/))/dim_sum_n(loss1all,(/1,2,3/))

  nt = dimsizes(data1)
  data2 = new((/nt,2/),float)

  do it=0,nt-1
   data2(it,:) = (/data1(it),sum(loss1all(it,:,:,:))/)
  end do

  asciiwrite("life_mri1.txt",data2)

