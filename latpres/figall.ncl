
  plot = new(3, graphic)

  f = addfile ("../ukesm/data/ptp_AERmon_UKESM1-0-LL_ssp126_r1i1p1f2_gn_201501-204912.nc","r")
  lata = f->lat
  ptp = dim_avg_n(f->ptp(0:11,:,:),0)/100.
  longpt = dim_avg_n(ptp,1)

  f1 = addfile("./data/oh126_ukesm.nc","r")

  lat = f1->lat
  pres = f1->pres

  bc = month_to_annual(f1->OH(0:1019,:,:),1)
  pa = trend_manken(bc,False,0)

  sig = pa(0,:,:)
  td = 100.*84.*pa(1,:,:)/dim_avg_n(f1->OH(0:11,:,:),0)

  f2 = addfile("../simpmodel/nc_ratio_ukesm.nc","r")

  noa = dim_avg_n( f2->noa, 2)  ; pres, lat
  nob = dim_avg_n( f2->nob, 2)

  no2a = dim_avg_n( f2->no2a, 2)  ; pres, lat
  no2b = dim_avg_n( f2->no2b, 2)

  coa = dim_avg_n( f2->coa, 2)  ; pres, lat
  cob = dim_avg_n( f2->cob, 2)

  ch4a = dim_avg_n( f2->ch4a, 2)  ; pres, lat
  ch4b = dim_avg_n( f2->ch4b, 2)

  b1 = (noa + no2a)/((coa ))
  b2 = (nob + no2b)/((cob ))

  ratio = (b2-b1)/b1

  td!0   = "lev"                             ; name the coordinates since
  td!1   = "lat"                             ; zmmsf does not copy them.
  td&lev = pres
  td&lat = lat

  ratio!0   = "lev"                             ; name the coordinates since
  ratio!1   = "lat"                             ; zmmsf does not copy them.
  ratio&lev = pres
  ratio&lat = lat

  wks  = gsn_open_wks ("pdf", "contour_all" )

  res = True
  res@gsnDraw              = False                ; do not draw the plot
  res@gsnFrame             = False                ; do not advance the frame
  res@gsnMaximize   = False

  res@cnLineLabelsOn       = False                 ; turn on line labels
  res@cnLinesOn             = False
  res@cnFillOn             = True                 ; turn on color fill
  res@cnFillPalette        = "BlueDarkRed18"             ; choose colormap
  res@cnInfoLabelOn   = False

  res@cnLevelSelectionMode = "ManualLevels"     ; manually set the contour levels
  res@cnMinLevelValF  = -40.                    ; set the minimum contour level
  res@cnMaxLevelValF  = 40.                     ; set the maximum contour level
  res@cnLevelSpacingF = 5.

  res@tmYRLabelsOn = False
  res@tmYRMode          = "Automatic"
  res@lbLabelBarOn    = False
  res@lbBoxEndCapStyle = "TriangleBothEnds"

  res@lbLabelFontHeightF = 0.03

  res@lbTitleFontHeightF         = .03                 ; make title smaller
  res@lbTitleString              = "OH changes (%)"            ; title string
  res@lbTitlePosition            = "Bottom"            ; title position
  res@lbTitleDirection           = "Across"            ; title direction

  res@trYMinF  = 100
  res@trYMaxF  = 1000

  res@tmXTOn = False
  res@tmYROn = False

  res@trYLog     = False

  res@tmXBLabelFontHeightF = 0.02
  res@tmYLLabelFontHeightF = 0.02

  res@gsnLeftString = ""
  res@gsnStringFontHeightF =  0.04

  plot(0) = gsn_csm_pres_hgt(wks,td,res)

  res1                   = True
  res1@gsnDraw              = False                ; do not draw the plot
  res1@gsnFrame             = False
  res1@gsnMaximize       = True   ; Maximize size of each plot
  res1@xyLineThicknessF  = 5.     ; Thicken the lines

  res1@xyLineColor       = "purple"
  res1@xyMarkerColor     = "purple"
  map = gsn_csm_xy (wks,lat,longpt,res1)
  overlay(plot(0),map)

  res2 = True
  res2@gsnDraw              = False                ; do not draw the plot
  res2@gsnFrame             = False                ; do not advance the frame
  res2@gsnMaximize   = False
  res2@cnFillOn = False
  res2@cnInfoLabelOn   = False
  res2@cnLineLabelsOn       = False                 ; turn on line labels
  res2@cnLinesOn             = False
  res2@cnLevelSelectionMode = "ManualLevels"
  res2@cnMinLevelValF  = -1.0                    ; set the minimum contour level
  res2@cnMaxLevelValF  = 1.0                     ; set the maximum contour level
  res2@cnLevelSpacingF = 0.01

  res2@tmXTOn = False
  res2@tmYROn = False
  res2@tmYRLabelsOn = False
  res2@tmYRMode          = "Automatic"
  res2@lbLabelBarOn    = True
  res2@lbOrientation        = "Vertical"

  iplot = gsn_csm_pres_hgt(wks,ratio,res2)

  opt                      = True
  opt@gsnShadeHigh         = 17           ; cross hatch pattern
  opt@gsnShadeFillType     = "pattern"
  opt@gsnShadeFillScaleF   = 1.5
  iplot = gsn_contour_shade(iplot, 0., 0., opt)

  overlay(plot(0),iplot)

;  draw(plot)
;  frame(wks)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; GFDL

  f = addfile ("../gfdl/data/ptp_AERmon_GFDL-ESM4_ssp126_r1i1p1f1_gr1_201501-210012.nc","r")
  lata2 = f->lat
  ptp2 = dim_avg_n(f->ptp(0:11,:,:),0)/100.
  longpt2 = dim_avg_n(ptp,1)

  f1 = addfile("./data/oh126_gfdl.nc","r")

  lat2 = f1->lat
  pres2 = f1->pres

  bc2 = month_to_annual(f1->OH(0:1019,:,:),1)
  pa2 = trend_manken(bc2,False,0)

  sig2 = pa2(0,:,:)
  td2 = 100.*84.*pa2(1,:,:)/dim_avg_n(f1->OH(0:11,:,:),0)

  f2 = addfile("../simpmodel/nc_ratio_gfdl.nc","r")

  oha2 = dim_avg_n( f2->oha, 2)  ; pres, lat
  ohb2 = dim_avg_n( f2->ohb, 2)

  noa2 = dim_avg_n( f2->noa, 2)  ; pres, lat
  nob2 = dim_avg_n( f2->nob, 2)

  no2a2 = dim_avg_n( f2->no2a, 2)  ; pres, lat
  no2b2 = dim_avg_n( f2->no2b, 2)

  coa2 = dim_avg_n( f2->coa, 2)  ; pres, lat
  cob2 = dim_avg_n( f2->cob, 2)

  ch4a2 = dim_avg_n( f2->ch4a, 2)  ; pres, lat
  ch4b2 = dim_avg_n( f2->ch4b, 2)

  bc1f = (noa2 + no2a2)/((coa2))
  bc2f = (nob2 + no2b2)/((cob2))

  ratiof = (bc2f-bc1f)/bc1f
  print(dimsizes(ratiof))

  td2!0   = "lev"                             ; name the coordinates since
  td2!1   = "lat"                             ; zmmsf does not copy them.
  td2&lev = pres2
  td2&lat = lat2

  ratiof!0   = "lev"                             ; name the coordinates since
  ratiof!1   = "lat"                             ; zmmsf does not copy them.
  ratiof&lev = pres2
  ratiof&lat = lat2


  plot(1) = gsn_csm_pres_hgt(wks,td2,res)

  map2 = gsn_csm_xy (wks,lat,longpt2,res1)
  overlay(plot(1),map2)

  iplot2 = gsn_csm_pres_hgt(wks,ratiof,res2)

  iplot2 = gsn_contour_shade(iplot2, 0., 0., opt)

  overlay(plot(1),iplot2)

;  draw(plot2)
;  frame(wks)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; MRI

  f = addfile ("../mri/data/ptp_AERmon_MRI-ESM2-0_ssp126_r1i1p1f1_gn_201501-210012.nc","r")
  lata3 = f->lat
  ptp3 = dim_avg_n(f->ptp(0:11,:,:),0)/100.
  longpt3 = dim_avg_n(ptp3,1)

  f1 = addfile("./data/oh126_mri.nc","r")

  lat3 = f1->lat
  pres3 = f1->pres

  longpt3r = linint1(lata3,longpt3,False,lat3,0)

  bc3 = month_to_annual(f1->OH(0:1019,:,:),1)
  pa3 = trend_manken(bc3,False,0)

  sig3 = pa3(0,:,:)
  td3 = 100.*84.*pa3(1,:,:)/dim_avg_n(f1->OH(0:11,:,:),0)

  f2 = addfile("../simpmodel/nc_ratio_mri.nc","r")

  oha3 = dim_avg_n( f2->oha, 2)  ; pres, lat
  ohb3 = dim_avg_n( f2->ohb, 2)

  noa3 = dim_avg_n( f2->noa, 2)  ; pres, lat
  nob3 = dim_avg_n( f2->nob, 2)

  no2a3 = dim_avg_n( f2->no2a, 2)  ; pres, lat
  no2b3 = dim_avg_n( f2->no2b, 2)

  coa3 = dim_avg_n( f2->coa, 2)  ; pres, lat
  cob3 = dim_avg_n( f2->cob, 2)

  ch4a3 = dim_avg_n( f2->ch4a, 2)  ; pres, lat
  ch4b3 = dim_avg_n( f2->ch4b, 2)

  bc1r = (noa3 + no2a3)/((coa3))
  bc2r = (nob3 + no2b3)/((cob3))

  ratior = (bc2r-bc1r)/bc1r

  td3!0   = "lev"                             ; name the coordinates since
  td3!1   = "lat"                             ; zmmsf does not copy them.
  td3&lev = pres3
  td3&lat = lat3

  ratior!0   = "lev"                             ; name the coordinates since
  ratior!1   = "lat"                             ; zmmsf does not copy them.
  ratior&lev = pres3
  ratior&lat = lat3


  plot(2) = gsn_csm_pres_hgt(wks,td3,res)

  map3 = gsn_csm_xy (wks,lat3,longpt3r,res1)
  overlay(plot(2),map3)

  iplot3 = gsn_csm_pres_hgt(wks,ratior,res2)

  iplot3 = gsn_contour_shade(iplot3, 0., 0., opt)

  overlay(plot(2),iplot3)

;  draw(plot(1))
;  frame(wks)

  resP  = True
  resP@gsnMaximize   = False
  resP@gsnPanelLabelBar  = True
  resP@gsnPanelTop      =  0.92
  resP@gsnPanelBottom   =  0.08
  resP@gsnPanelYWhiteSpacePercent = 2.0
  resP@pmLabelBarWidthF  = 0.6
  resP@lbLabelFontHeightF   = 0.017
  resP@gsnPanelXWhiteSpacePercent = 4.0

  gsn_panel (wks, plot, (/1,3/), resP)
