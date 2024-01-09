

  h2o = asciiread("../mri/h2o.txt",86,"float")

  nox = asciiread("noxtotal126.txt", 86, "float")
  co = asciiread("cototal126.txt", 86, "float")
  ch4 = asciiread("ch4total126.txt", 86, "float")
  voc = asciiread("voctotal126.txt", 86, "float")

  nox = (nox * 14./30.)/14. ; Tg N -> Tmol
  nox = nox + 13./14. ; add natural NOx emissions
  co = (co+180.)/28. ; 180. CO as natural emissions.
  ch4 = ch4/16.
  voc = (voc*161./210.)/12.

  ratio1 = h2o * nox/((co+ch4)^1.5)

  ratio2 = h2o * nox/(co^1.5)

  asciiwrite("ratio116.txt",ratio1)

  nox = asciiread("noxtotal370.txt", 86, "float")
  co = asciiread("cototal370.txt", 86, "float")
  ch4 = asciiread("ch4total370.txt", 86, "float")
  voc = asciiread("voctotal370.txt", 86, "float")

  nox = (nox * 14./30.)/14. ; Tg N -> Tmol
  nox = nox + 13./14.
  co = (co+180.)/28.
  ch4 = ch4/16.
  voc = (voc*161./210.)/12.

  ratio3 = h2o * nox/((co+ch4)^1.5)

  ratio4 = h2o * nox/(co^1.5)

  asciiwrite("ratio370.txt",ratio2)

;  print(ratio1/ratio2)

  x     = ispan(2015,2100,1)
  y = new((/4,86/),float)

  y(0,:) = (ratio1-ratio1(0))/ratio1(0) * 100.
  y(1,:) = (ratio2-ratio2(0))/ratio2(0) * 100.

  y(2,:) = (ratio3-ratio3(0))/ratio3(0) * 100.
  y(3,:) = (ratio4-ratio4(0))/ratio4(0) * 100.

  wks = gsn_open_wks("pdf","ratio")

  res = True
  res@gsnDraw                = False
  res@gsnFrame               = False
  res@gsnMaximize       = False
  res@vpHeightF          = 0.4               ; change aspect ratio of plot
  res@vpWidthF           = 0.6

  res@trXMinF         = 2015    ; set minimum X-axis value
  res@trXMaxF         = 2100    ; set maximum X-axis value

  res@xyMonoLineColor    = False             ; want colored lines
  res@xyLineColors       = (/"Red","Blue","orange","lightblue"/) ; colors chosen
  res@xyLineThicknesses  = (/5.,5.,5.,5./)      ; line thicknesses
  res@xyDashPatterns     = (/0.,0.,0.,0./)

  res@tmXTOn = False
  res@tmYROn = False
  res@tmYLLabelFontHeightF = 0.03
  res@tmXBLabelFontHeightF = 0.03

  res@tiMainString      = "NOx/(CO+CH4) evolution"
  res@tiYAxisString = "%"
  res@tiYAxisFontHeightF = 0.03

  res@tmXMajorGrid                = True          ; implement x grid 
  res@tmXMajorGridThicknessF      = 1.0           ; 2.0 is default
  res@tmXMajorGridLineDashPattern = 2             ; select short dash lines
  
  res@tmYMajorGrid                = True          ; implement y grid
  res@tmYMajorGridThicknessF      = 1.0           ; 2.0 is default
  res@tmYMajorGridLineDashPattern = 2

  plot = gsn_csm_xy(wks,x,y(0:3,:),res)

  draw(plot)
  frame(wks)

