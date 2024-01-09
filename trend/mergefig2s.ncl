
  plot = new(3,graphic)
  wks = gsn_open_wks("pdf","gsn_anmolyS")

  x     = ispan(2015,2100,1)

  y = new((/3,86/),float)
  y@_FillValue = -999

  data  = asciiread("../gfdl/oh_2015-2100_r1i1p1f1.txt",(/86/),"float")

  y(0,:)     = data(:) * 1000. ; Gg units

  pa = trend_manken(y(0,:), False, 0)
  pa(1) = pa(1)/avg(y(0,0:4)) * 100.

  y(0,:) = (y(0,:)-y(0,0))/y(0,0) * 100.

;;;
  delete(data)
  data = new((/86/),float)
  data(0:9)  = asciiread("../mri/oh_r1i1p1f1_201501-202412.txt",(/10/),"float")
  data(10:19)  = asciiread("../mri/oh_r1i1p1f1_202501-203412.txt",(/10/),"float")
  data(20:29)  = asciiread("../mri/oh_r1i1p1f1_203501-204412.txt",(/10/),"float")
  data(30:39)  = asciiread("../mri/oh_r1i1p1f1_204501-205412.txt",(/10/),"float")
  data(40:49)  = asciiread("../mri/oh_r1i1p1f1_205501-206412.txt",(/10/),"float")
  data(50:59)  = asciiread("../mri/oh_r1i1p1f1_206501-207412.txt",(/10/),"float")
  data(60:69)  = asciiread("../mri/oh_r1i1p1f1_207501-208412.txt",(/10/),"float")
  data(70:79)  = asciiread("../mri/oh_r1i1p1f1_208501-209412.txt",(/10/),"float")
  data(80:85)  = asciiread("../mri/oh_r1i1p1f1_209501-210012.txt",(/6/),"float")

  y(1,:)     = data(:) * 1000.

  pa = trend_manken(y(1,:), False, 0)
  pa(1) = pa(1)/avg(y(1,0:4)) * 100.

  y(1,:) = (y(1,:)-y(1,0))/y(1,0) * 100.

;;;
  delete(data)
  data = asciiread("../ukesm/oh_2015-2100_r1i1p1f2.txt",(/86/),"float")

  y(2,0:85) = data(:) * 1000.

  pa = trend_manken(y(2,:), False, 0)
  pa(1) = pa(1)/avg(y(2,0:4)) * 100.

  y(2,:) = (y(2,:)-y(2,0))/y(2,0) * 100.

;;;;;;;;;;;;;;;;;;; O3

  y2 = new((/3,86/),float)
  y2@_FillValue = -999

  data  = asciiread("../gfdl/o3_2015-2100_r1i1p1f1.txt",(/86/),"float")

  y2(0,:)     = data(:) * 1000. ; Gg units

  pa = trend_manken(y2(0,:), False, 0)
  pa(1) = pa(1)/avg(y2(0,0:4)) * 100.

  y2(0,:) = (y2(0,:)-y2(0,0))/y2(0,0) * 100.

;;;
  delete(data)
  data = new((/86/),float)
  data(0:9)  = asciiread("../mri/o3_r1i1p1f1_201501-202412.txt",(/10/),"float")
  data(10:19)  = asciiread("../mri/o3_r1i1p1f1_202501-203412.txt",(/10/),"float")
  data(20:29)  = asciiread("../mri/o3_r1i1p1f1_203501-204412.txt",(/10/),"float")
  data(30:39)  = asciiread("../mri/o3_r1i1p1f1_204501-205412.txt",(/10/),"float")
  data(40:49)  = asciiread("../mri/o3_r1i1p1f1_205501-206412.txt",(/10/),"float")
  data(50:59)  = asciiread("../mri/o3_r1i1p1f1_206501-207412.txt",(/10/),"float")
  data(60:69)  = asciiread("../mri/o3_r1i1p1f1_207501-208412.txt",(/10/),"float")
  data(70:79)  = asciiread("../mri/o3_r1i1p1f1_208501-209412.txt",(/10/),"float")
  data(80:85)  = asciiread("../mri/o3_r1i1p1f1_209501-210012.txt",(/6/),"float")

  y2(1,:)     = data(:) * 1000.

  pa = trend_manken(y2(1,:), False, 0)
  pa(1) = pa(1)/avg(y2(1,0:4)) * 100.

  y2(1,:) = (y2(1,:)-y2(1,0))/y2(1,0) * 100.

;;;
  delete(data)
  data = asciiread("../ukesm/o3_2015-2100_r1i1p1f2.txt",(/86/),"float")

  y2(2,0:85) = data(:) * 1000.
  pa = trend_manken(y2(2,:), False, 0)
  pa(1) = pa(1)/avg(y2(2,0:4)) * 100.

  y2(2,:) = (y2(2,:)-y2(2,0))/y2(2,0) * 100.


  res = True
  res@vpHeightF          = 0.4               ; change aspect ratio of plot
  res@vpWidthF           = 0.8
  res@gsnDraw                = False
  res@gsnFrame               = False
  res@gsnMaximize       = False

  res@trXMinF         = 2015    ; set minimum X-axis value
  res@trXMaxF         = 2100

  res@xyMonoLineColor    = False             ; want colored lines
  res@xyLineColors       = (/"grey20","Blue","red"/) ; colors chosen
  res@xyLineThicknesses  = (/4.,4.,4./)      ; line thicknesses
  res@xyDashPatterns     = (/0.,0.,0./)

  res@tmXTOn = False
  res@tmYROn = False
  res@tmYLLabelFontHeightF = 0.03
  res@tmXBLabelFontHeightF = 0.03

;  res@tiMainString      = "OH evolution"
  res@tiYAxisString = "OH in SSP126 (%)"
  res@tiYAxisFontHeightF = 0.03

  res@tmXMajorGrid                = False          ; implement x grid
  res@tmXMajorGridThicknessF      = 0.6           ; 2.0 is default
  res@tmXMajorGridLineDashPattern = 2             ; select short dash lines

  res@tmYMajorGrid                = False          ; implement y grid
  res@tmYMajorGridThicknessF      = 0.6           ; 2.0 is default
  res@tmYMajorGridLineDashPattern = 2

;  res@trYMinF  = 0.12
;  res@trYMaxF  = 0.36
  res@gsnLeftString = "B"
  res@gsnLeftStringFontHeightF = 0.04
  res@gsnLeftStringFontHeightF = 0.04
  res@gsnLeftStringParallelPosF = -0.05
  res@gsnLeftStringOrthogonalPosF = 0.05

;  plot(1) = gsn_csm_xy(wks,x,y,res)

  res@gsnLeftString = "A"
  res@tiYAxisString = "O~B~3~N~ in SSP126 (%)"
;  plot(0) = gsn_csm_xy(wks,x,y2,res)


  gres = True
  gres@YPosPercent = 92.    ; expressed as %, 0->100, sets position of top border of legend
                            ;  when gres@Position is set to its default setting of "Top" (Default = 95.)
  gres@XPosPercent = 2.      ; expressed as %, 0->100, sets position of left border of legend(Default = 5.)

  gres@ItemSpacePercent = 14

  lineres = True
  lineres@lgLineColors = (/"grey20","blue","red"/) ; line colors
  lineres@lgLineThicknesses = 6.                        ; line thicknesses
  lineres@LineLengthPercent = 7.                         ; expressed as %, 0->100, length of line

  lineres@lgPerimFill            = "SolidFill"      ; Fill legend box w/white
  lineres@lgPerimFillColor       = "white"

  textres = True
  textres@lgLabelFontHeights  = 0.03
  textres@lgLabels = (/"GFDL-ESM","MRI-ESM","UKESM"/)  ; legend labels (required)

;  map = simple_legend(wks,plot(0),gres,lineres,textres)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; then 370


  x     = ispan(2015,2100,1)

  y = new((/3,86/),float)
  y@_FillValue = -999

  data  = asciiread("../../ssp370/gfdl/oh_2015-2100_r1i1p1f1.txt",(/86/),"float")

  y(0,:)     = data(:) * 1000. ; Gg units

  pa = trend_manken(y(0,:), False, 0)
  pa(1) = pa(1)/avg(y(0,0:4)) * 100.
  print(pa)

  y(0,:) = (y(0,:)-y(0,0))/y(0,0) * 100.

;;;
  delete(data)
  data = new((/86/),float)
  data(0:9)  = asciiread("../../ssp370/mri/oh_r1i1p1f1_201501-202412.txt",(/10/),"float")
  data(10:19)  = asciiread("../../ssp370/mri/oh_r1i1p1f1_202501-203412.txt",(/10/),"float")
  data(20:29)  = asciiread("../../ssp370/mri/oh_r1i1p1f1_203501-204412.txt",(/10/),"float")
  data(30:39)  = asciiread("../../ssp370/mri/oh_r1i1p1f1_204501-205412.txt",(/10/),"float")
  data(40:49)  = asciiread("../../ssp370/mri/oh_r1i1p1f1_205501-206412.txt",(/10/),"float")
  data(50:59)  = asciiread("../../ssp370/mri/oh_r1i1p1f1_206501-207412.txt",(/10/),"float")
  data(60:69)  = asciiread("../../ssp370/mri/oh_r1i1p1f1_207501-208412.txt",(/10/),"float")
  data(70:79)  = asciiread("../../ssp370/mri/oh_r1i1p1f1_208501-209412.txt",(/10/),"float")
  data(80:85)  = asciiread("../../ssp370/mri/oh_r1i1p1f1_209501-210012.txt",(/6/),"float")

  y(1,:)     = data(:) * 1000.

  pa = trend_manken(y(1,:), False, 0)
  pa(1) = pa(1)/avg(y(1,0:4)) * 100.
  print(pa)

  y(1,:) = (y(1,:)-y(1,0))/y(1,0) * 100.

;;;
  delete(data)
  data = asciiread("../../ssp370/ukesm/oh_2015-2100_r1i1p1f2.txt",(/86/),"float")

  y(2,0:85) = data(:) * 1000.

  pa = trend_manken(y(2,:), False, 0)
  pa(1) = pa(1)/avg(y(2,0:4)) * 100.
  print(pa)

  y(2,:) = (y(2,:)-y(2,0))/y(2,0) * 100.

;;;;;;;;;;;;; O3

  y2 = new((/3,86/),float)
  y2@_FillValue = -999

  data  = asciiread("../../ssp370/gfdl/o3_2015-2100_r1i1p1f1.txt",(/86/),"float")

  y2(0,:)     = data(:) * 1000. ; Gg units

  pa = trend_manken(y2(0,:), False, 0)
  pa(1) = pa(1)/avg(y2(0,0:4)) * 100.
  print(pa)

  y2(0,:) = (y2(0,:)-y2(0,0))/y2(0,0) * 100.

;;;
  delete(data)
  data = new((/86/),float)
  data(0:9)  = asciiread("../../ssp370/mri/o3_r1i1p1f1_201501-202412.txt",(/10/),"float")
  data(10:19)  = asciiread("../../ssp370/mri/o3_r1i1p1f1_202501-203412.txt",(/10/),"float")
  data(20:29)  = asciiread("../../ssp370/mri/o3_r1i1p1f1_203501-204412.txt",(/10/),"float")
  data(30:39)  = asciiread("../../ssp370/mri/o3_r1i1p1f1_204501-205412.txt",(/10/),"float")
  data(40:49)  = asciiread("../../ssp370/mri/o3_r1i1p1f1_205501-206412.txt",(/10/),"float")
  data(50:59)  = asciiread("../../ssp370/mri/o3_r1i1p1f1_206501-207412.txt",(/10/),"float")
  data(60:69)  = asciiread("../../ssp370/mri/o3_r1i1p1f1_207501-208412.txt",(/10/),"float")
  data(70:79)  = asciiread("../../ssp370/mri/o3_r1i1p1f1_208501-209412.txt",(/10/),"float")
  data(80:85)  = asciiread("../../ssp370/mri/o3_r1i1p1f1_209501-210012.txt",(/6/),"float")

  y2(1,:)     = data(:) * 1000.

  pa = trend_manken(y2(1,:), False, 0)
  pa(1) = pa(1)/avg(y2(1,0:4)) * 100.
  print(pa)

  y2(1,:) = (y2(1,:)-y2(1,0))/y2(1,0) * 100.

;;;
  delete(data)
  data = asciiread("../../ssp370/ukesm/o3_2015-2100_r1i1p1f2.txt",(/86/),"float")

  y2(2,0:85) = data(:) * 1000.

  pa = trend_manken(y2(2,:), False, 0)
  pa(1) = pa(1)/avg(y2(2,0:4)) * 100.
  print(pa)

  y2(2,:) = (y2(2,:)-y2(2,0))/y2(2,0) * 100.

;  res@trYMinF  = 0.12
;  res@trYMaxF  = 0.36

;  res@gsnStringFont = "helvetica-bold"
  res@gsnLeftString = "B"
  res@gsnLeftStringFontHeightF = 0.04
  res@gsnLeftStringParallelPosF = -0.05
  res@tiYAxisString = "OH in SSP370 (%)"
  res@tiXAxisString = "Year"
  res@tiXAxisFontHeightF = 0.03
  plot(1) = gsn_csm_xy(wks,x,y,res)

  res@gsnLeftString = "A"
  res@tiYAxisString = "O~B~3~N~ in SSP370 (%)"
  delete(res@tiXAxisString)
  plot(0) = gsn_csm_xy(wks,x,y2,res)

  map = simple_legend(wks,plot(0),gres,lineres,textres)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; emis ratios

  h2o = asciiread("../mri/h2o.txt",86,"float")

  nox = asciiread("../lifetime/noxtotal126.txt", 86, "float")
  co = asciiread("../lifetime/cototal126.txt", 86, "float")
  ch4 = asciiread("../lifetime/ch4total126.txt", 86, "float")
  voc = asciiread("../lifetime/voctotal126.txt", 86, "float")

  nox = (nox * 14./30.)/14. ; Tg N -> Tmol
  nox = nox + 13./14. ; add natural NOx emissions
;  co = (co+180.)/28. ; 180. CO as natural emissions.
  co = co/28.
  ch4 = ch4/16.
  voc = (voc*161./210.)/12.

  ratio1 = h2o * nox/((co+ch4)^1.5)
  ratio2 = h2o * nox/(co^1.5)

  nox = asciiread("../lifetime/noxtotal370.txt", 86, "float")
  co = asciiread("../lifetime/cototal370.txt", 86, "float")
  ch4 = asciiread("../lifetime/ch4total370.txt", 86, "float")
  voc = asciiread("../lifetime/voctotal370.txt", 86, "float")

  nox = (nox * 14./30.)/14. ; Tg N -> Tmol
  nox = nox + 13./14.
  co = (co+180.)/28.
  ch4 = ch4/16.
  voc = (voc*161./210.)/12.

  ratio3 = h2o * nox/((co+ch4)^1.5)
  ratio4 = h2o * nox/(co^1.5)

;  print(ratio1/ratio2)

  x     = ispan(2015,2100,1)
  delete(y)
  y = new((/4,86/),float)

  y(0,:) = (ratio1-ratio1(0))/ratio1(0) * 100.
  y(1,:) = (ratio2-ratio2(0))/ratio2(0) * 100.

  y(2,:) = (ratio3-ratio3(0))/ratio3(0) * 100.
  y(3,:) = (ratio4-ratio4(0))/ratio4(0) * 100.

  delete(res)
  res = True
  res@gsnDraw                = False
  res@gsnFrame               = False
  res@gsnMaximize       = False
  res@vpHeightF          = 0.4               ; change aspect ratio of plot
  res@vpWidthF           = 0.8

  res@trXMinF         = 2015    ; set minimum X-axis value
  res@trXMaxF         = 2100    ; set maximum X-axis value

  res@xyMonoLineColor    = False             ; want colored lines
  res@xyLineColors       = (/"orange2","orangered","mediumblue","cyan"/) ; colors chosen
  res@xyLineThicknesses  = (/6.,6.,6.,6./)      ; line thicknesses
  res@xyDashPatterns     = (/0.,0.,0.,0./)

  res@tmXTOn = False
  res@tmYROn = False
  res@tmYLLabelFontHeightF = 0.03
  res@tmXBLabelFontHeightF = 0.03

;  res@tiMainString      = "NOx/(CO+CH4) evolution"
  res@tiYAxisString = "Emissions (%)"
  res@tiYAxisFontHeightF = 0.03
  res@tiXAxisString = "Year"
  res@tiXAxisFontHeightF = 0.03

  res@tmXMajorGrid                = False          ; implement x grid
  res@tmXMajorGridThicknessF      = 0.6           ; 2.0 is default
  res@tmXMajorGridLineDashPattern = 2             ; select short dash lines

  res@tmYMajorGrid                = False          ; implement y grid
  res@tmYMajorGridThicknessF      = 0.6           ; 2.0 is default
  res@tmYMajorGridLineDashPattern = 2

  res@gsnLeftString = ""
  res@gsnLeftStringFontHeightF = 0.04
  res@gsnLeftStringParallelPosF = -0.05
  res@gsnLeftStringOrthogonalPosF = 0.05
  plot(2) = gsn_csm_xy(wks,x,y(2:3,:),res)

  gres = True
  gres@YPosPercent = 25.    ; expressed as %, 0->100, sets position of top border of legend
                            ;  when gres@Position is set to its default setting of "Top" (Default = 95.)
  gres@XPosPercent = 3.      ; expressed as %, 0->100, sets position of left border of legend(Default = 5.)
  gres@ItemSpacePercent = 12

  delete(lineres)
  lineres = True
  lineres@lgLineColors = (/"orangered","orange2"/) ; line colors
  lineres@lgLineThicknesses = 6                        ; line thicknesses
  lineres@LineLengthPercent = 7.                         ; expressed as %, 0->100, length of line

  delete(textres)
  textres = True
  textres@lgLabelFontHeights  = 0.03
  textres@lgLabels = (/"[H~B~2~N~O]NOx/CO~S~1.5~N~","[H~B~2~N~O]NOx/(CO+CH~B~4~N~)~S~1.5~N~"/)  ; legend labels (required)

  map1 = simple_legend(wks,plot(2),gres,lineres,textres)

  gres@YPosPercent = 20.
  gres@XPosPercent = 5.
  lineres@lgLineColors = (/"cyan","mediumblue"/)
  textres@lgLabels = (/"[H~B~2~N~O]NOx/CO~S~1.5~N~","[H~B~2~N~O]NOx/(CO+CH~B~4~N~)~S~1.5~N~"/)
;  map1 = simple_legend(wks,plot(4),gres,lineres,textres)

  pnlres                = True
  pnlres@gsnFrame       = False
  pnlres@gsnMaximize  = True
  pnlres@gsnPanelRowSpec = True
  pnlres@gsnPanelTop = 0.9
  pnlres@gsnPanelBottom = 0.1  ; Leave room for legend at the bottom.
  pnlres@gsnPanelMainString       = ""
  pnlres@gsnPanelYWhiteSpacePercent = 3
  pnlres@gsnPanelXWhiteSpacePercent = 5
  gsn_panel(wks,plot,(/1,1,1/),pnlres)

