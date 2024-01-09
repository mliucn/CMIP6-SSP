

  f11 = addfile ("../mri/data/oh_AERmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_201501-202412.nc", "r")
  f21 = addfile ("../mri/data/ta_CFmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_201501-202412.nc","r")

  f12 = addfile ("../mri/data/oh_AERmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_202501-203412.nc", "r")
  f22 = addfile ("../mri/data/ta_CFmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_202501-203412.nc","r")

  f13 = addfile ("../mri/data/oh_AERmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_203501-204412.nc", "r")
  f23 = addfile ("../mri/data/ta_CFmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_203501-204412.nc","r")

  f14 = addfile ("../mri/data/oh_AERmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_204501-205412.nc", "r")
  f24 = addfile ("../mri/data/ta_CFmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_204501-205412.nc","r")

  f15 = addfile ("../mri/data/oh_AERmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_205501-206412.nc", "r")
  f25 = addfile ("../mri/data/ta_CFmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_205501-206412.nc","r")

  f16 = addfile ("../mri/data/oh_AERmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_206501-207412.nc", "r")
  f26 = addfile ("../mri/data/ta_CFmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_206501-207412.nc","r")

  f17 = addfile ("../mri/data/oh_AERmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_207501-208412.nc", "r")
  f27 = addfile ("../mri/data/ta_CFmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_207501-208412.nc","r")

  f18 = addfile ("../mri/data/oh_AERmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_208501-209412.nc", "r")
  f28 = addfile ("../mri/data/ta_CFmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_208501-209412.nc","r")

  f19 = addfile ("../mri/data/oh_AERmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_209501-210012.nc", "r")
  f29 = addfile ("../mri/data/ta_CFmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_209501-210012.nc","r")


  plev = (/ 1000,975,925,850,700,600,500,400,300,200,100/)
  plev@units     = "hPa"

  lat = f11->lat
  lon = f11->lon
  lev = f11->lev

  lata = f21->lat
  lona = f21->lon

  nt = 12*10*8+12*6
  temp1 = new((/nt,dimsizes(lev),dimsizes(lata),dimsizes(lona)/),float)

  temp1(0:119,:,:,:) = f21->ta(:,:,:,:)
  temp1(120:239,:,:,:) = f22->ta(:,:,:,:)
  temp1(240:359,:,:,:) = f23->ta(:,:,:,:)
  temp1(360:479,:,:,:) = f24->ta(:,:,:,:)
  temp1(480:599,:,:,:) = f25->ta(:,:,:,:)
  temp1(600:719,:,:,:) = f26->ta(:,:,:,:)
  temp1(720:839,:,:,:) = f27->ta(:,:,:,:)
  temp1(840:959,:,:,:) = f28->ta(:,:,:,:)
  temp1(960:1031,:,:,:) = f29->ta(:,:,:,:)

  ta1 = linint2(lona,lata,temp1,True,lon,lat,0)
  delete(temp1)

  ps1 = new((/nt,dimsizes(lat),dimsizes(lon)/),float)
  ps1(0:119,:,:)  = f11->ps(:,:,:)
  ps1(120:239,:,:)  = f12->ps(:,:,:)
  ps1(240:359,:,:)  = f13->ps(:,:,:)
  ps1(360:479,:,:)  = f14->ps(:,:,:)
  ps1(480:599,:,:)  = f15->ps(:,:,:)  
  ps1(600:719,:,:) = f16->ps(:,:,:)
  ps1(720:839,:,:) = f17->ps(:,:,:)
  ps1(840:959,:,:) = f18->ps(:,:,:)
  ps1(960:1031,:,:) = f19->ps(:,:,:)

  bc1 = new((/nt,dimsizes(lev),dimsizes(lat),dimsizes(lon)/),float)
  bc1(0:119,:,:,:) = f11->oh(:,:,:,:)
  bc1(120:239,:,:,:) = f12->oh(:,:,:,:)
  bc1(240:359,:,:,:) = f13->oh(:,:,:,:)
  bc1(360:479,:,:,:) = f14->oh(:,:,:,:)
  bc1(480:599,:,:,:) = f15->oh(:,:,:,:)
  bc1(600:719,:,:,:) = f16->oh(:,:,:,:)
  bc1(720:839,:,:,:) = f17->oh(:,:,:,:)
  bc1(840:959,:,:,:) = f18->oh(:,:,:,:)
  bc1(960:1031,:,:,:) = f19->oh(:,:,:,:)

  pres1 = bc1
  ndims = dimsizes(pres1)
  print(doubletofloat(lev))

  do k=0,ndims(1)-1
   pres1(:,k,:,:) = ps1 * doubletofloat(lev(k))
  end do
  delete(ps1)

  bc1 =   bc1/(8.314*ta1/pres1) * 1.e-6 * 6.02e23/1.e5  ; 1.e6/cm3
  delete(ta1)

  pres1 = pres1/100.
  bc11 = linint1_n(pres1, bc1, False, plev, 0, 1)

  bc2 = dim_avg_n(bc11,3)

  system("/bin/rm -f ./data/oh126_mri.nc")
  ff = addfile ("./data/oh126_mri.nc","c")
  ff->lat = lat
  ff->pres = plev
  ff->OH = bc2
