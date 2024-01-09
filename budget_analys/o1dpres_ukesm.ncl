
  f1 = addfile ("../photo1d/UKESM/photo1d_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_201501-204912.nc","r")
  f2 = addfile ("../ukesm/data/pfull_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_201501-204912.nc", "r")
  f3 = addfile ("../ukesm/data/ta_CFmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_201501-204912.nc","r")

  f = addfile ("../ukesm/data/ptp_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_201501-204912.nc","r")

  f4 = addfile ("../photo1d/UKESM/photo1d_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_201501-204912.nc","r")
  f5 = addfile ("../ukesm/data/pfull_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_210001-210012.nc", "r")
  f6 = addfile ("../ukesm/data/ta_CFmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_210001-210012.nc","r")


  plev = (/ 1000,975,925,850,700,600,500,400,300,200,100/)
  plev@units     = "hPa"

  lat = f1->lat

  ta1 = f3->ta(0:11,0:70,:,:)
  pres1  = f2->pfull(0:11,:,:,:)
  bc1  = f1->photo1d(0:11,:,:,:)

  pres1 = pres1/100.
  bc11 = linint1_n(pres1, bc1, False, plev, 0, 1)

  ta2 = f6->ta(0:11,0:70,:,:)
  pres2  = f5->pfull(0:11,:,:,:)
  bc2  = f4->photo1d(0:11,:,:,:)

  pres2 = pres2/100.
  bc22 = linint1_n(pres2, bc2, False, plev, 0, 1)

  bc11a = dim_avg_n(bc11,0)
  bc22a = dim_avg_n(bc22,0)

  longbc1 = dim_avg_n(bc11a,2)
  print(dimsizes(longbc1))

  bc11a@_FillValue = -9999
  bc11a = where(bc11a.ne.0., bc11a,bc11a@_FillValue)

  bc22a = (bc22a - bc11a)/bc11a*100. ; fu - pd
  longbc2 = dim_avg_n(bc22a,2)

  longbc1!0   = "lev"                             ; name the coordinates since
  longbc1!1   = "lat"                             ; zmmsf does not copy them.
  longbc1&lev = plev
  longbc1&lat = lat

  longbc2!0   = "lev"                             ; name the coordinates since
  longbc2!1   = "lat"                             ; zmmsf does not copy them.
  longbc2&lev = plev
  longbc2&lat = lat

  wks  = gsn_open_wks ("pdf", "preslat_o1d_ukesm" )

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

  res@cnLevelSelectionMode = "ManualLevels"     ; manually set the contour levels
  res@cnMinLevelValF  = -20                    ; set the minimum contour level
  res@cnMaxLevelValF  = 20                     ; set the maximum contour level
  res@cnLevelSpacingF = 1

  res@tmXTOn = False
  res@tmYROn = False

  res@trYLog     = False

;  res@gsnStringFont = "helvetica-bold"
  res@gsnLeftString = "a"
  res@gsnStringFontHeightF =  0.04

  plot = new(2, graphic)

  plot(0) = gsn_csm_pres_hgt(wks,longbc1,res)

  res@cnFillPalette        = "BlueDarkRed18"
  res@lbTitleString              = "Differences (%)"
  res@gsnLeftString = "b"
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
