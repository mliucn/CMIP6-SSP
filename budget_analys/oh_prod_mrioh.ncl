
; we calculate 2015 and 2100 OH primary production change

  f2 = addfile ("../mri/data/ta_CFmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_209501-210012.nc","r")

  f3 = addfile ("../mri/data/ch4_AERmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_209501-210012.nc","r")
  f4 = addfile ("../mri/data/o3_AERmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_209501-210012.nc","r")
  f5 = addfile ("../mri/data/co_AERmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_209501-210012.nc","r")

  f6 = addfile ("../mri/data/ho2_AERmonZ_MRI-ESM2-0_ssp126_r1i1p1f1_gnz_201501-210012.nc","r")

  f7 = addfile ("../mri/data/no_AERmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_209501-210012.nc","r")
  f8 = addfile ("../mri/data/no2_AERmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_209501-210012.nc","r")

;  f9 = addfile ("../mri/data/oh_AERmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_201501-202412.nc","r")
  f9 = addfile ("../mri/data/oh_AERmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_209501-210012.nc","r")

  f10 = addfile ("../mri/data/hcho_AERmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_209501-210012.nc","r")

  fp1 = addfile ("../photo1d/MRI/photo1d_AERmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_209501-210012.nc","r")

  f = addfile ("../mri/data/ptp_AERmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_201501-210012.nc","r")

  ff = addfile ("../mri/datah2o/h2o_AERmonZ_MRI-ESM2-0_ssp126_r1i1p1f1_gnz_201501-210012.nc", "r")

  aa = addfile ("../mri/data/areacella_fx_MIROC-ES2L_historical_r1i1p1f2_gn.nc","r")


  ptpa = f->ptp(0:11,:,:)/100.
  lata = f->lat
  lona = f->lon
  longpt = dim_avg_n(ptpa,1)

  lat1 = f3->lat
  lon1 = f3->lon
  lev1 = f3->lev
  ch4  = f3->ch4(60:71,:,:,:)

  ps1  = f3->ps(60:71,:,:)

  temp1    = f2->ta(60:71,:,:,:)
  lattemp = f2->lat
  lontemp = f2->lon

  ta1 = linint2(lontemp,lattemp,temp1,True,lon1,lat1,0)
  delete(temp1)

  dims = dimsizes(ch4)
  nt = dims(0)
  nz = dims(1)
  ny = dims(2)
  nx = dims(3)

  area = aa->areacella  ; m2
  area1 = conform_dims((/nt,nz,ny,nx/),area,(/2,3/))

  ptp = linint2(lona,lata,ptpa,True,lon1,lat1,0)
  ptp1 = conform_dims((/nt,nz,ny,nx/),ptp,(/0,2,3/))

;;;;;;;;;;;;;;;;
  abnd = doubletofloat(f3->a_bnds)
  bbnd = doubletofloat(f3->b_bnds)

  pres1 = ch4
  preshigh = ch4
  preslow = ch4
  ndims = dimsizes(pres1)
  do k=0,ndims(1)-1
   pres1(:,k,:,:) = ps1 * doubletofloat(lev1(k))
   preshigh(:,k,:,:) = abnd(k,0)*100000. + bbnd(k,0) *  ps1  ; Pa layer    pressure at interface
   preslow(:,k,:,:) = abnd(k,1)*100000. + bbnd(k,1) *  ps1
  end do

  height1 = (1-((preslow/101350.)^0.1902))*153.8*(273.2+20.0) \  ; layer height m
     - (1-((preshigh/101350.)^0.1902))*153.8*(273.2+20.0)

  delete(ps1)
;;;;;;;;;;;;;;;

;  ch4  = f3->ch4(0:11,:,:,:)
  o3a = f4->o3(60:71,:,:,:)   ; mol/mol
  o3 = where(pres1/100 .ge. ptp1, o3a, 0.0)  ; only use troposphere o3

  coa = f5->co(60:71,:,:,:) ; mol/mol
  co = where(pres1/100 .ge. ptp1, coa, 0.0)

  ho2 = f6->ho2(60:71,:,:) ; time,plev,lat
  pres2 = f6->plev

  noa = f7->no(60:71,:,:,:)
  no = where(pres1/100 .ge. ptp1, noa, 0.0)

  no2a = f8->no2(60:71,:,:,:)
  no2 = where(pres1/100 .ge. ptp1, no2a, 0.0)

  oha = f9->oh(60:71,:,:,:)
  oh = where(pres1/100 .ge. ptp1, oha, 0.0)

  hcho = f10->hcho(60:71,:,:,:)

  photo = fp1->photo1d(60:71,:,:,:)

;-----------
  lat = ff->lat
  bc = ff->h2o(1020:1031,:,:) ; 660 719  time, lev, lat
  pres = ff->plev

  bc2 = linint1(lat,bc,False,lat1,0)  ; kg/kg
  h2o = linint1_n(pres/100., bc2, False, pres1(0,:,31,0)/100., 0, 1)
  h2o = h2o * 1000.
 
;-----------

  afd = 6.02 * 1.e23
  vole = 8.314*ta1/pres1 ; m3/mol
  dens = pres1/(287.*ta1)  ; kg/m3

  denslon = dim_avg_n(dens,3)
;  print(denslon(0,:,31))

  n2 = vole
  o2 = vole
  n2 = 0.78
  o2 = 0.21

  print(dimsizes(h2o))
  print(dimsizes(denslon))
  h2o = h2o * afd * denslon/(18.*1.e6) ; moles/cm3
  h2ob = conform_dims((/nt,nz,ny,nx/),h2o,(/0,1,2/))

  n2b = n2 * afd/(vole*1.e6) ; time,lev,lat,lon
  o2b = o2 * afd/(vole*1.e6)

  ch4b = ch4*afd/(vole*1.e6) ; time,lev,lat,lon
  o3b = o3*afd/(vole*1.e6)
  cob = co*afd/(vole*1.e6)
  nob = no*afd/(vole*1.e6)
  no2b = no2*afd/(vole*1.e6)
  ohb = oh*afd/(vole*1.e6)
  hchob = hcho*afd/(vole*1.e6)

  volelon = dim_avg_n(vole,3)
  ho2p = linint1_n(pres2/100., ho2, False, pres1(0,:,31,0)/100., 0, 1)
  ho2p = ho2p*afd/(volelon*1.e6)  ; moles/cm3
  ho2b = conform_dims((/nt,nz,ny,nx/),ho2p,(/0,1,2/))

  tempb = ta1 ; time,lev,lat,lon
 
  atm = 1.0 
  j1 = ch4b
  k1 = ch4b
  k2 = k1
  k3 = k1
  k4 = k1
  k6 = k1

  j1 = photo * 1.e-6

  k0 = 3.3 * 1.0e-12 * exp(270./tempb)
  k1 = 1.63 * 1.0e-10 * exp(60./tempb) ; cm3 molecules-1 s-1
  k2 = 2.15 * 1.0e-11 * exp(110./tempb)
  k3 = 3.3 * 1.0e-11 * exp(55./tempb)

  k4 = 2.45 * 1.0e-12 * exp(-1775./tempb) ; cm3 molecules-1 s-1
  k5 = 1.5 * 1.0e-13 * (1.0+0.6*atm) ; cm3 molecules-1 s-1
  k6 = 1.7 * 1.0e-12 * exp(-940./tempb)
  k7 = 4.8 * 1.e-11 * exp(250./tempb)
  k8 = 1.2 * 1.e-14 * tempb * exp(287./tempb)  ; HCHO-OH

  k01 = 1.0e-14 * exp(-490./tempb) ; HO2-O3

;;;;;;;OH-NO2

  M = 2.46e19 ; molecules cm-3
  aaa = 1.8e-30 * (300./tempb)^3.0
  bbb = 2.8e-11 * (300./tempb)^0.0

  ccc = aaa*M/(1.0+aaa*M/bbb)

  k9 = ccc * 0.6^(1.+(log(aaa*M/bbb)^2.)^(-1.))

;;;;;;;;;

;  print(dimsizes(j1))

; prod unit is molecules/cm3/s
  prod = 2.0 * j1 * k1 * o3b * h2ob/(k2*n2b+k3*o2b+k1*h2ob) ;+ k0 * ho2b * nob

  prod2 = k0 * ho2b * nob
  prod3 = k01 * ho2b * o3b

  loss1 = k4 * ohb * ch4b ; use monthly average OH, while online-diagnostic has day-night variation
  loss2 = k5 * ohb * cob
  loss3 = k6 * ohb * o3b
  loss4 = k7 * ohb * ho2b
  loss5 = k8 * ohb * hchob
  loss6 = k9 * ohb * no2b

  mm = (/31.,28.,31.,30.,31.,30.,31.,31.,30.,31.,30.,31./)
  mm0 = conform_dims((/nt/12,12,nz,ny,nx/),mm,1)
  mm1 = reshape(mm0,(/nt,nz,ny,nx/))
;  print(dimsizes(mm1)) 

  prod = prod * 3600. * 24. * mm1  ; molecu/cm3/month
  prod = 1.0e6 * prod/afd * area1 * height1  ; mol/grid/month

  prod2 = prod2 * 3600. * 24. * mm1
  prod2 = 1.0e6 * prod2/afd * area1 * height1

  prod3 = prod3 * 3600. * 24. * mm1
  prod3 = 1.0e6 * prod3/afd * area1 * height1

  prodall = sum(prod)/1.e12  ; we have 1 years

  print(prodall)  ;Tmol/year
  print(sum(prod2)/1.e12)
  print(sum(prod3)/1.e12)


  loss1 = loss1 * 3600. * 24. * mm1
  loss1 = 1.0e6 * loss1/afd * area1 * height1

  loss2 = loss2 * 3600. * 24. * mm1
  loss2 = 1.0e6 * loss2/afd * area1 * height1

  loss3 = loss3 * 3600. * 24. * mm1
  loss3 = 1.0e6 * loss3/afd * area1 * height1

  loss4 = loss4 * 3600. * 24. * mm1
  loss4 = 1.0e6 * loss4/afd * area1 * height1

  loss5 = loss5 * 3600. * 24. * mm1
  loss5 = 1.0e6 * loss5/afd * area1 * height1

  loss6 = loss6 * 3600. * 24. * mm1
  loss6 = 1.0e6 * loss6/afd * area1 * height1

  print(sum(loss1)/1.e12)
  print(sum(loss2)/1.e12)
  print(sum(loss3)/1.e12)
  print(sum(loss4)/1.e12)
  print(sum(loss5)/1.e12)
  print(sum(loss6)/1.e12)

  print("prod"+sum(prod+prod2+prod3)/1.e12)
  print("loss"+sum(loss1+loss2+loss3+loss4+loss5+loss6)/1.e12)

;  loss = k4*ch4b+k5*cob+k6*o3b

;  bc1 = dim_avg_n(prod/loss * 1.e-5 * 0.25,0)
;  bc1 = dim_avg_n(prod/loss * 1.e-5,0)


