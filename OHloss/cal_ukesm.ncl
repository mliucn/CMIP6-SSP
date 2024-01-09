

  f1 = addfile ("../ukesm/data/airmass_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_201501-204912.nc", "r")
  f2 = addfile ("../ukesm/data/pfull_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_201501-204912.nc", "r")
  f3 = addfile ("../ukesm/data/ta_CFmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_201501-204912.nc","r")

  fa1 = addfile ("../ukesm/data/co_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_201501-204912.nc", "r")
  fb1 = addfile ("../ukesm/data/lossco_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_201501-204912.nc", "r")

  f4 = addfile ("../ukesm/data/airmass_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_205001-209912.nc", "r")
  f5 = addfile ("../ukesm/data/pfull_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_205001-209912.nc", "r")
  f6 = addfile ("../ukesm/data/ta_CFmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_205001-209912.nc","r")

  fa2 = addfile ("../ukesm/data/co_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_205001-209912.nc", "r")
  fb2 = addfile ("../ukesm/data/lossco_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_205001-209912.nc", "r")

  f7 = addfile ("../ukesm/data/airmass_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_210001-210012.nc", "r")
  f8 = addfile ("../ukesm/data/pfull_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_210001-210012.nc", "r")
  f9 = addfile ("../ukesm/data/ta_CFmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_210001-210012.nc","r")

  fa3 = addfile ("../ukesm/data/co_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_210001-210012.nc", "r")
  fb3 = addfile ("../ukesm/data/lossco_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_210001-210012.nc", "r")


  aa = addfile ("../ukesm/data/areacella_fx_UKESM1-0-LL_piControl_r1i1p1f2_gn.nc","r")

  lat = f1->lat
  lev = f1->lev

  area = aa->areacella

  ta0 = array_append_record(f3->ta(:,:,:,:),f6->ta(:,:,:,:),0)
  pres0  =  array_append_record(f2->pfull(:,:,:,:),f5->pfull(:,:,:,:),0)
  air0  = array_append_record(f1->airmass(:,:,:,:),f4->airmass(:,:,:,:),0)    ; kg/m2                      ; temp: hybrid mid-levels

  ta1 = array_append_record(ta0, f9->ta(:,:,:,:),0)
  pres1 = array_append_record(pres0, f8->pfull(:,:,:,:),0)
  air1 = array_append_record(air0, f7->airmass(:,:,:,:),0)

  delete(ta0)
  delete(pres0)
  delete(air0)
  dens = pres1/(287.*ta1)

  bc0 = array_append_record(fa1->co(:,:,:,:),fa2->co(:,:,:,:),0) ; mol/mol
  loss0 = array_append_record(fb1->lossco(:,:,:,:),fb2->lossco(:,:,:,:),0) ; mol/m3/s

  bc1 = array_append_record(bc0, fa3->co(:,:,:,:),0)
  loss1 = array_append_record(loss0, fb3->lossco(:,:,:,:),0)

  delete(bc0)
  delete(loss0)

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
  loss1 = 1.0e-12 * loss1 * 28. * air1 * area1 / dens

  loss1all = month_to_annual(loss1,0)  ; Tg/yr
  data1 = dim_sum_n(burden,(/1,2,3/))/dim_sum_n(loss1all,(/1,2,3/))

  nt = dimsizes(data1)
  data2 = new((/nt,2/),float)

  do it=0,nt-1
   data2(it,:) = (/data1(it),sum(loss1all(it,:,:,:))/)
  end do

  asciiwrite("co_ukesm.txt",data2)
