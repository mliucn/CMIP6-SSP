
  f1 = addfile ("../ukesm/data/no_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_201501-204912.nc", "r")
  f2 = addfile ("../ukesm/data/pfull_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_201501-204912.nc", "r")
  f3 = addfile ("../ukesm/data/ta_CFmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_201501-204912.nc","r")

  f = addfile ("../ukesm/data/ptp_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_201501-204912.nc","r")

  f4 = addfile ("../ukesm/data/no_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_210001-210012.nc", "r")
  f5 = addfile ("../ukesm/data/pfull_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_210001-210012.nc", "r")
  f6 = addfile ("../ukesm/data/ta_CFmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_210001-210012.nc","r")


  plev = (/ 1000,975,925,850,700,600,500,400,300,200,100,50,10/)
  plev@units     = "hPa"

  lat = f1->lat

  ta1 = f3->ta(0:11,:,:,:)
  pres1  = f2->pfull(0:11,:,:,:)
  bc1  = f1->no(0:11,:,:,:)
  bc1 = bc1 * 1.e12 ; ppt

  pres1 = pres1/100.
  bc11 = dim_avg_n(linint1_n(pres1, bc1, False, plev, 0, 1),0)

  ta2 = f6->ta(0:11,:,:,:)
  pres2  = f5->pfull(0:11,:,:,:)
  bc2  = f4->no(0:11,:,:,:)
  bc2 = bc2 * 1.e12 ; ppt

  pres2 = pres2/100.
  bc22 = dim_avg_n(linint1_n(pres2, bc2, False, plev, 0, 1),0)

  longbc1 = dim_avg_n(bc11,2)
  print(dimsizes(longbc1))

  longbc2 = dim_avg_n((bc22 - bc11)/bc11*100.,2)

  longbc1!0   = "lev"                             ; name the coordinates since
  longbc1!1   = "lat"                             ; zmmsf does not copy them.
  longbc1&lev = plev
  longbc1&lat = lat

  longbc2!0   = "lev"                             ; name the coordinates since
  longbc2!1   = "lat"                             ; zmmsf does not copy them.
  longbc2&lev = plev
  longbc2&lat = lat

  wks  = gsn_open_wks ("pdf", "preslat_ho2_ukesm" )

  res = True
  res@gsnDraw              = False                ; do not draw the plot
  res@gsnFrame             = False                ; do not advance the frame
  res@gsnMaximize   = False

  res@cnLineLabelsOn       = False                 ; turn on line labels
  res@cnLinesOn             = False
  res@cnFillOn             = True                 ; turn on color fill
  res@cnFillPalette        = "WhiteYellowOrangeRed"             ; choose colormap

  res@tmYRLabelsOn = False
  res@tmYRMode          = "Automatic"
  res@lbLabelBarOn    = True
  res@lbBoxEndCapStyle = "TriangleBothEnds"

  res@lbLabelFontHeightF = 0.024

  res@lbTitleFontHeightF         = .03                 ; make title smaller
  res@lbTitleString              = "ppb"            ; title string
  res@lbTitlePosition            = "Bottom"            ; title position
  res@lbTitleDirection           = "Across"            ; title direction

  res@tmXBLabelFontHeightF = 0.02
  res@tmYLLabelFontHeightF = 0.02

  res@tmXTOn = False
  res@tmYROn = False

  res@trYLog     = True

;  res@gsnStringFont = "helvetica-bold"
  res@gsnLeftString = "A"
  res@gsnStringFontHeightF =  0.04

  plot = new(2, graphic)

  plot(0) = gsn_csm_pres_hgt(wks,longbc1,res)

  res@cnFillPalette        = "BlueDarkRed18"
  res@lbTitleString              = "Differences (%)"
  res@gsnLeftString = "B"
  plot(1) = gsn_csm_pres_hgt(wks,longbc2,res)


  resP  = True
  resP@gsnPanelLabelBar  = False
  resP@gsnPanelTop      =  0.92
  resP@gsnPanelBottom   =  0.08
  resP@gsnPanelYWhiteSpacePercent = 2.0
  resP@pmLabelBarWidthF  = 0.6
  resP@lbLabelFontHeightF   = 0.017
  resP@gsnPanelXWhiteSpacePercent = 4.0

  gsn_panel (wks, plot, (/1,2/), resP)
