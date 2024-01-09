
  plot = new(4,graphic)
  wks = gsn_open_wks("pdf","gsn_ssp")

  x     = ispan(2015,2100,1)

  y = new((/3,86/),float)
  y@_FillValue = -999

  data  = asciiread("../gfdl/oh_2015-2100_r1i1p1f1.txt",(/86/),"float")

  y(0,:)     = data(:) * 1000. ; Gg units

  pa = trend_manken(y(0,:), False, 0)
  pa(1) = pa(1)/avg(y(0,0:4)) * 100.

;  y(0,:) = (y(0,:)-y(0,0))/y(0,0) * 100.

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

;  y(1,:) = (y(1,:)-y(1,0))/y(1,0) * 100.

;;;
  delete(data)
  data = asciiread("../ukesm/oh_2015-2100_r1i1p1f2.txt",(/86/),"float")

  y(2,0:85) = data(:) * 1000.

  pa = trend_manken(y(2,:), False, 0)
  pa(1) = pa(1)/avg(y(2,0:4)) * 100.

;  y(2,:) = (y(2,:)-y(2,0))/y(2,0) * 100.

;;;;;;;;;;;;;;;;;;; O3

  y2 = new((/3,86/),float)
  y2@_FillValue = -999

  data  = asciiread("../gfdl/o3_2015-2100_r1i1p1f1.txt",(/86/),"float")

  y2(0,:)     = data(:) ; Gg units

  pa = trend_manken(y2(0,:), False, 0)
  pa(1) = pa(1)/avg(y2(0,0:4)) * 100.

;  y2(0,:) = (y2(0,:)-y2(0,0))/y2(0,0) * 100.

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

  y2(1,:)     = data(:)

  pa = trend_manken(y2(1,:), False, 0)
  pa(1) = pa(1)/avg(y2(1,0:4)) * 100.

;  y2(1,:) = (y2(1,:)-y2(1,0))/y2(1,0) * 100.

;;;
  delete(data)
  data = asciiread("../ukesm/o3_2015-2100_r1i1p1f2.txt",(/86/),"float")

  y2(2,0:85) = data(:) 
  pa = trend_manken(y2(2,:), False, 0)
  pa(1) = pa(1)/avg(y2(2,0:4)) * 100.

;  y2(2,:) = (y2(2,:)-y2(2,0))/y2(2,0) * 100.


  res = True
  res@vpHeightF          = 0.5               ; change aspect ratio of plot
  res@vpWidthF           = 0.6
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
  res@tiYAxisString = "OH in SSP126 (Gg)"
  res@tiYAxisFontHeightF = 0.035

  res@tmXMajorGrid                = False          ; implement x grid
  res@tmXMajorGridThicknessF      = 0.6           ; 2.0 is default
  res@tmXMajorGridLineDashPattern = 2             ; select short dash lines

  res@tmYMajorGrid                = False          ; implement y grid
  res@tmYMajorGridThicknessF      = 0.6           ; 2.0 is default
  res@tmYMajorGridLineDashPattern = 2

;  res@trYMinF  = 0.12
;  res@trYMaxF  = 0.36

;  res@gsnStringFont = "helvetica-bold"
  res@gsnLeftString = "B"
  res@gsnLeftStringFontHeightF = 0.04
  res@gsnLeftStringFontHeightF = 0.04
  res@gsnLeftStringParallelPosF = -0.05
  res@gsnLeftStringOrthogonalPosF = 0.05

  plot(1) = gsn_csm_xy(wks,x,y,res)

  res@gsnLeftString = "A"
  res@tiYAxisString = "O~B~3~N~ in SSP126 (Tg)"
  plot(0) = gsn_csm_xy(wks,x,y2,res)


  gres = True
  gres@YPosPercent = 26.5    ; expressed as %, 0->100, sets position of top border of legend
                            ;  when gres@Position is set to its default setting of "Top" (Default = 95.)
  gres@XPosPercent = 2.      ; expressed as %, 0->100, sets position of left border of legend(Default = 5.)

  gres@ItemSpacePercent = 10

  lineres = True
  lineres@lgLineColors = (/"grey20","blue","red"/) ; line colors
  lineres@lgLineThicknesses = 6.                        ; line thicknesses
  lineres@LineLengthPercent = 7.                         ; expressed as %, 0->100, length of line

  lineres@lgPerimFill            = "SolidFill"      ; Fill legend box w/white
  lineres@lgPerimFillColor       = "white"

  textres = True
  textres@lgLabelFontHeights  = 0.03
  textres@lgLabels = (/"GFDL-ESM","MRI-ESM","UKESM"/)  ; legend labels (required)

  map = simple_legend(wks,plot(0),gres,lineres,textres)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; then 370


  x     = ispan(2015,2100,1)

  y = new((/3,86/),float)
  y@_FillValue = -999

  data  = asciiread("../../ssp370/gfdl/oh_2015-2100_r1i1p1f1.txt",(/86/),"float")

  y(0,:)     = data(:) * 1000. ; Gg units

  pa = trend_manken(y(0,:), False, 0)
  pa(1) = pa(1)/avg(y(0,0:4)) * 100.

;  y(0,:) = (y(0,:)-y(0,0))/y(0,0) * 100.

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

;  y(1,:) = (y(1,:)-y(1,0))/y(1,0) * 100.

;;;
  delete(data)
  data = asciiread("../../ssp370/ukesm/oh_2015-2100_r1i1p1f2.txt",(/86/),"float")

  y(2,0:85) = data(:) * 1000.

  pa = trend_manken(y(2,:), False, 0)
  pa(1) = pa(1)/avg(y(2,0:4)) * 100.

;  y(2,:) = (y(2,:)-y(2,0))/y(2,0) * 100.

;;;;;;;;;;;;; O3

  y2 = new((/3,86/),float)
  y2@_FillValue = -999

  data  = asciiread("../../ssp370/gfdl/o3_2015-2100_r1i1p1f1.txt",(/86/),"float")

  y2(0,:)     = data(:) ; Gg units

  pa = trend_manken(y2(0,:), False, 0)
  pa(1) = pa(1)/avg(y2(0,0:4)) * 100.

;  y2(0,:) = (y2(0,:)-y2(0,0))/y2(0,0) * 100.

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

  y2(1,:)     = data(:)

  pa = trend_manken(y2(1,:), False, 0)
  pa(1) = pa(1)/avg(y2(1,0:4)) * 100.

;  y2(1,:) = (y2(1,:)-y2(1,0))/y2(1,0) * 100.

;;;
  delete(data)
  data = asciiread("../../ssp370/ukesm/o3_2015-2100_r1i1p1f2.txt",(/86/),"float")

  y2(2,0:85) = data(:) 

  pa = trend_manken(y2(2,:), False, 0)
  pa(1) = pa(1)/avg(y2(2,0:4)) * 100.

;  y2(2,:) = (y2(2,:)-y2(2,0))/y2(2,0) * 100.

;  res@trYMinF  = 0.12
;  res@trYMaxF  = 0.36
  res@gsnLeftString = "D"
  res@gsnLeftStringFontHeightF = 0.04
  res@gsnLeftStringParallelPosF = -0.05
  res@tiYAxisString = "OH in SSP370 (Gg)"
  plot(3) = gsn_csm_xy(wks,x,y,res)

  res@gsnLeftString = "C"
  res@tiYAxisString = "O~B~3~N~ in SSP370 (Tg)"
  plot(2) = gsn_csm_xy(wks,x,y2,res)


  pnlres                = True
  pnlres@gsnFrame       = False
  pnlres@gsnMaximize  = True
  pnlres@gsnPanelRowSpec = True
  pnlres@gsnPanelTop = 0.9
  pnlres@gsnPanelBottom = 0.1  ; Leave room for legend at the bottom.
  pnlres@gsnPanelMainString       = ""
  pnlres@gsnPanelYWhiteSpacePercent = 5
  pnlres@gsnPanelXWhiteSpacePercent = 5
  gsn_panel(wks,plot,(/2,2/),pnlres)

