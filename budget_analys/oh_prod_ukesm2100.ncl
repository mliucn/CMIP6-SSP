
; we calculate 2015 and 2100 OH primary production change

  f0 = addfile ("../ukesm/data/airmass_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_210001-210012.nc", "r")

  f1 = addfile ("../ukesm/data/pfull_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_210001-210012.nc", "r")
  f2 = addfile ("../ukesm/data/ta_CFmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_210001-210012.nc","r")

  f3 = addfile ("../ukesm/data/ch4_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_210001-210012.nc", "r")
  f4 = addfile ("../ukesm/data/o3_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_210001-210012.nc", "r")
  f5 = addfile ("../ukesm/data/co_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_210001-210012.nc", "r")

  f6 = addfile ("../ukesm/data/ho2_AERmonZ_UKESM1-0-LL_ssp126_r1i1p1f2_gnz_205001-210012.nc", "r")
  f7 = addfile ("../ukesm/data/no_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_210001-210012.nc","r")
  f8 = addfile ("../ukesm/data/no2_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_210001-210012.nc","r")

  f9 = addfile ("../ukesm/data/oh_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_201501-204912.nc","r")
  f10 = addfile ("../ukesm/data/hcho_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_210001-210012.nc","r")

  fp1 = addfile ("../photo1d/UKESM/photo1d_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_210001-210012.nc","r")

  f = addfile ("../ukesm/data/ptp_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_201501-204912.nc","r")

  ff = addfile ("../mri/datah2o/h2o_AERmonZ_MRI-ESM2-0_ssp126_r1i1p1f1_gnz_201501-210012.nc", "r")

  aa = addfile ("../ukesm/data/areacella_fx_UKESM1-0-LL_piControl_r1i1p1f2_gn.nc","r")

  plev = (/ 990,975,925,850,700,600,500,400,300,200,100/)
  plev@units     = "hPa"

  ptp = f->ptp(0:11,:,:)/100.
  longpt = dim_avg_n(ptp,1)

  lat1 = f3->lat

  pres1  = f1->pfull(0:11,0:70,:,:) ; 240-299
  ta1    = f2->ta(0:11,0:70,:,:)
  air1 = f0->airmass(0:11,0:70,:,:)  ; kg/m2

  dims = dimsizes(ta1)
  nt = dims(0)
  nz = dims(1)
  ny = dims(2)
  nx = dims(3)

  area = aa->areacella  ; m2
  area1 = conform_dims((/nt,nz,ny,nx/),area,(/2,3/))
  ptp1 = conform_dims((/nt,nz,ny,nx/),ptp,(/0,2,3/))

  ch4  = f3->ch4(0:11,0:70,:,:)
  o3a = f4->o3(0:11,0:70,:,:)   ; mol/mol
  o3 = where(pres1/100 .ge. ptp1, o3a, 0.0)  ; only use troposphere o3

  co = f5->co(0:11,0:70,:,:) ; mol/mol

  ho2 = f6->ho2(600:611,:,:) ; time,plev,lat
  pres2 = f6->plev

  noa = f7->no(0:11,0:70,:,:)
  no = where(pres1/100 .ge. ptp1, noa, 0.0)  

  no2a = f8->no2(0:11,0:70,:,:)
  no2 = where(pres1/100 .ge. ptp1, no2a, 0.0)

  oha = f9->oh(0:11,0:70,:,:)
  oh = where(pres1/100 .ge. ptp1, oha, 0.0)

  hcho = f10->hcho(0:11,0:70,:,:)

  photo = fp1->photo1d(0:11,0:70,:,:)

;-----------
  lat = ff->lat
  bc = ff->h2o(1020:1031,:,:) ; 2100  time, lev, lat
  pres = ff->plev

  bc2 = linint1(lat,bc,False,lat1,0)  ; kg/kg
  h2o = linint1_n(pres/100., bc2, False, pres1(0,:,72,0)/100., 0, 1)
  h2o = h2o * 1000.
  
;-----------

  afd = 6.02 * 1.e23
  vole = 8.314*ta1/pres1 ; m3/mol
  dens = pres1/(287.*ta1)  ; kg/m3

  denslon = dim_avg_n(dens,3)

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
  ho2p = linint1_n(pres2/100., ho2, False, pres1(0,:,72,0)/100., 0, 1)
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

  j1 = photo

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

  loss1 = k4 * ohb * ch4b
  loss2 = k5 * ohb * cob
  loss3 = k6 * ohb * o3b
  loss4 = k7 * ohb * ho2b
  loss5 = k8 * ohb * hchob
  loss6 = k9 * ohb * no2b

  mm = (/31.,28.,31.,30.,31.,30.,31.,31.,30.,31.,30.,31./)
  mm0 = conform_dims((/nt/12,12,nz,ny,nx/),mm,1)
  mm1 = reshape(mm0,(/nt,nz,ny,nx/))
  print(dimsizes(mm1)) 
  prod = prod * 3600. * 24. * mm1  ; molecu/cm3/month
  prod = 1.0e6 * prod/afd * air1 * area1 / dens  ; mol/grid/month

  prod2 = prod2 * 3600. * 24. * mm1
  prod2 = 1.0e6 * prod2/afd * air1 * area1 / dens

  prod3 = prod3 * 3600. * 24. * mm1
  prod3 = 1.0e6 * prod3/afd * air1 * area1 / dens

  prodall = sum(prod)/1.e12  ; we have 1 years

  print(prodall)  ;Tmol/year
  print(sum(prod2)/1.e12)
  print(sum(prod3)/1.e12)

  loss1 = loss1 * 3600. * 24. * mm1
  loss1 = 1.0e6 * loss1/afd * air1 * area1 / dens

  loss2 = loss2 * 3600. * 24. * mm1
  loss2 = 1.0e6 * loss2/afd * air1 * area1 / dens

  loss3 = loss3 * 3600. * 24. * mm1
  loss3 = 1.0e6 * loss3/afd * air1 * area1 / dens

  loss4 = loss4 * 3600. * 24. * mm1
  loss4 = 1.0e6 * loss4/afd * air1 * area1 / dens

  loss5 = loss5 * 3600. * 24. * mm1
  loss5 = 1.0e6 * loss5/afd * air1 * area1 / dens

  loss6 = loss6 * 3600. * 24. * mm1
  loss6 = 1.0e6 * loss6/afd * air1 * area1 / dens

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


