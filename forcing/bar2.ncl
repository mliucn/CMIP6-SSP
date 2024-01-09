
; add IPCC data

  cities = (/"2015","2100"/)

  ncities = dimsizes(cities)

  type = "pdf"
  wks = gsn_open_wks(type,"change")

;
; Set resources for blank plot. Be sure to set axes limits
; that represent d that will be added later via polygons.
;
  dres                          = True

;  dres@gsnMaximize              = True    ; Maximize plot in frame
  dres@gsnDraw                  = False   ; Don't draw
  dres@gsnFrame                 = False   ; Don't advance frame

  dres@vpWidthF                 = 0.43     ; Make long and
  dres@vpHeightF                = 0.49     ; narrow

;---Set axes limits. Add extra space for X max.
  dres@trYMinF                  = 0.
  dres@trYMaxF                  = 1.4
  dres@trXMinF                  = 0.3
  dres@trXMaxF                  = ncities + 0.7

;---Put city labels on X axis
  dres@tmXBMode                 = "Explicit"
  dres@tmXBValues               = ispan(1,ncities,1)
  dres@tmXBLabels               = cities
  dres@tmXBLabelFontHeightF     = 0.018
  dres@tmXBLabelJust            = "BottomCenter"
  dres@tmXBLabelDeltaF = 0.5    ; push the XB labels down from plot

  dres@gsnScale                 = True    ; Make labels on axes same size

;--Turn off X axis tickmarks
  dres@tmXBMajorLengthF         = 0.01
  dres@tmXBMajorOutwardLengthF  = 0.01
  dres@tmYLMajorLengthF         = 0.01
  dres@tmYLMajorOutwardLengthF  = 0.01

  dres@tmXTOn                   = False   ; Turn off top tickmarks
  dres@tmYROn                   = False

  dres@tiYAxisString = "CH~B~4~N~ Forcing (W m~S~-2~N~)"
  dres@tiYAxisFontHeightF = 0.018

;---Create blank plot without Y grid lines
  dres@gsnLeftString = ""
  dres@gsnLeftStringFontHeightF = 0.025

  plot = new(2, graphic)

  plot(0) = gsn_csm_blank_plot(wks,dres)

;---Arrays to hold the bar values and the bars themselves.
  dum1 = new(1,graphic)
  dum2 = new(1,graphic)
  dum3 = new(1,graphic)

;---Set some resources for the bars.
  bres           = True
  bres@gsEdgesOn = False      ; Outline the polygons (bars)


    bres@gsFillColor          = "steelblue1"
    bres@gsFillOpacityF       = 1.0
    a = 0.15
    b = 0.34
    ybar      = (/a,b,b,a,a/)
    xbar      = (/1.85-0.15,1.85-0.15,1.85+0.15,1.85+0.15,1.85-0.15/)
    dum11 = gsn_add_polygon(wks,plot(0),xbar,ybar,bres)

    bres@gsFillColor          = "blue"
    bres@gsFillOpacityF       = 1.0
    a = 0.089
    b = 0.256
    ybar      = (/a,b,b,a,a/)
    xbar      = (/2.15-0.15,2.15-0.15,2.15+0.15,2.15+0.15,2.15-0.15/)
    dum22 = gsn_add_polygon(wks,plot(0),xbar,ybar,bres)


    bres@gsFillColor          = "indianred1"
    bres@gsFillOpacityF       = 1.0
    a = 0.92
    b = 1.2
    ybar      = (/a,b,b,a,a/)
    xbar      = (/1.85-0.15,1.85-0.15,1.85+0.15,1.85+0.15,1.85-0.15/)
    dum33 = gsn_add_polygon(wks,plot(0),xbar,ybar,bres)

    bres@gsFillColor          = "red2"
    bres@gsFillOpacityF       = 1.0
    a = 0.954
    b = 1.26
    ybar      = (/a,b,b,a,a/)
    xbar      = (/2.15-0.15,2.15-0.15,2.15+0.15,2.15+0.15,2.15-0.15/)
    dum44 = gsn_add_polygon(wks,plot(0),xbar,ybar,bres)

  sres = True
  sres@gsMarkerIndex = 12
  sres@gsMarkerSizeF = 0.02
  sres@gsMarkerThicknessF = 4
  plot2 = gsn_add_polymarker(wks,plot(0),1,0.62,sres)

  sres@gsMarkerIndex = 1
  sres@gsMarkerSizeF = 0.03
  sres@gsMarkerColor = "orange2"
;  plot3 = gsn_add_polymarker(wks,plot(0),1,0.54,sres)
;  plot4 = gsn_add_polymarker(wks,plot(0),1.85,0.19,sres)
;  plot5 = gsn_add_polymarker(wks,plot(0),1.85,1.00,sres)

  sres@gsMarkerIndex = 4
  sres@gsMarkerSizeF = 0.01
  sres@gsMarkerThicknessF = 2
  sres@gsMarkerColor = "black"
  plot31 = gsn_add_polymarker(wks,plot(0),1,0.54,sres)
  plot41 = gsn_add_polymarker(wks,plot(0),1.85,0.19,sres)
  plot51 = gsn_add_polymarker(wks,plot(0),1.85,1.00,sres)

  res                          = True

  res@gsnDraw                  = False   ; Don't draw
  res@gsnFrame                 = False   ; Don't advance frame

  res@vpWidthF                 = 0.23     ; Make long and
  res@vpHeightF                = 0.49     ; narrow

;---Set axes limits. Add extra space for X max.
  res@trYMinF                  = -0.1
  res@trYMaxF                  = 0.2
  res@trXMinF                  = 0.5
  res@trXMaxF                  = 1.5

;---Put city labels on X axis
  res@tmXBMode                 = "Explicit"
  res@tmXBValues               = 1
  res@tmXBLabels               = "2100"
  res@tmXBLabelFontHeightF     = 0.018
  res@tmXBLabelJust            = "BottomCenter"
  res@tmXBLabelDeltaF = 0.5    ; push the XB labels down from plot

  res@gsnScale                 = True    ; Make labels on axes same size

;--Turn off X axis tickmarks
  res@tmXBMajorLengthF         = 0.01
  res@tmXBMajorOutwardLengthF  = 0.01
  res@tmYLMajorLengthF         = 0.01
  res@tmYLMajorOutwardLengthF  = 0.01

  res@tmXTOn                   = False   ; Turn off top tickmarks
  res@tmYROn                   = False

  res@tiYAxisString = "CH~B~4~N~ Forcing due to OH (W m~S~-2~N~)"
  res@tiYAxisFontHeightF = 0.025

;---Create blank plot without Y grid lines
  res@gsnLeftString = ""
  res@gsnLeftStringFontHeightF = 0.025
  plot(1) = gsn_csm_blank_plot(wks,res)


  bres@gsFillColor          = "red2"
  bres@gsFillOpacityF       = 1.0
  a = 0.034
  b = 0.163
  ybar      = (/a,b,b,a,a/)
  xbar      = (/1.-0.1,1.-0.1,1.+0.1,1.+0.1,1.-0.1/)
  gum11 = gsn_add_polygon(wks,plot(1),xbar,ybar,bres)

  bres@gsFillColor          = "blue"
  bres@gsFillOpacityF       = 1.0
  a = -0.013
  b = -0.084
  ybar      = (/a,b,b,a,a/)
  xbar      = (/1.-0.1,1.-0.1,1.+0.1,1.+0.1,1.-0.1/)
  gum22 = gsn_add_polygon(wks,plot(1),xbar,ybar,bres)

  resp = True
  resp@gsnFrame          = False
  resp@gsnPanelXWhiteSpacePercent = 5
  gsn_panel(wks,plot,(/1,2/),resp)

