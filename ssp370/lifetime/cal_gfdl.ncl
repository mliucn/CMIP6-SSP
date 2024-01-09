

  f1 = addfile ("../gfdl/data/airmass_AERmon_GFDL-ESM4_ssp370_r1i1p1f1_gr1_201501-210012.nc", "r")
  f2 = addfile ("../gfdl/data/ps_Amon_GFDL-ESM4_ssp370_r1i1p1f1_gr1_201501-210012.nc", "r")
  f3 = addfile ("../gfdl/data/ta_CFmon_GFDL-ESM4_ssp126_r1i1p1f1_gr1_201501-210012.nc","r")

  fa1 = addfile ("../gfdl/data/ch4_AERmon_GFDL-ESM4_ssp370_r1i1p1f1_gr1_201501-210012.nc", "r")
  fb1 = addfile ("../gfdl/data/lossch4_AERmon_GFDL-ESM4_ssp370_r1i1p1f1_gr1_201501-210012.nc", "r")

  aa = addfile ("../gfdl/data/areacella_fx_GFDL-ESM4_historical_r1i1p1f1_gr1.nc","r")

  lat = f1->lat
  lev = f1->lev

  area = aa->areacella

  ta1 = f3->ta(:,:,:,:)
  ps1  = f2->ps(:,:,:)
  air1  = f1->airmass(:,:,:,:)    ; kg/m2                      ; temp: hybrid mid-levels

  pres1 = air1
  ndims = dimsizes(pres1)
  do k=0,ndims(1)-1
   pres1(:,k,:,:) = ps1 * doubletofloat(lev(k))
  end do

  dens = pres1/(287.*ta1)

  bc1 = fa1->ch4(:,:,:,:) ; mol/mol
  loss1 = fb1->lossch4(:,:,:,:) ; mol/m3/s

  dims = dimsizes(loss1)
  nt = dims(0)
  nz = dims(1)
  ny = dims(2)
  nx = dims(3)
  print(dims)

  area1 = conform_dims((/nt,nz,ny,nx/),area,(/2,3/))

  bc1 = bc1/(8.314*ta1/pres1) ; from mol/mol to mol/m3
  bc1 = 1.0e-12 * bc1 * 16. * air1 * area1 / dens
  burden = month_to_annual(bc1,1) ; Tg 

  mm = (/31.,28.,31.,30.,31.,30.,31.,31.,30.,31.,30.,31./)
  mm0 = conform_dims((/nt/12,12,nz,ny,nx/),mm,1)
  mm1 = reshape(mm0,(/nt,nz,ny,nx/))
  print(dimsizes(mm1))

  loss1 = loss1 * 3600. * 24. * mm1  ;mol/m3/month
  loss1 = 1.0e-12 * loss1 * 16. * air1 * area1 / dens

  loss1all = month_to_annual(loss1,0)  ; Tg/yr

  data = dim_sum_n(burden,(/1,2,3/))/dim_sum_n(loss1all,(/1,2,3/))
  asciiwrite("life_gfdl.txt",data)

