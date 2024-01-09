
  plot = new(6,graphic)
  wks = gsn_open_wks("pdf","gsn_fig2")

  x     = ispan(2015,2100,1)

  y = new((/3,86/),float)
  y@_FillValue = -999

  data  = asciiread("../gfdl/oh_2015-2100_r1i1p1f1.txt",(/86/),"float")

  y(0,:)     = data(:) * 1000. ; Gg units

  pa = trend_manken(y(0,:), False, 0)
  pa(1) = pa(1)/avg(y(0,0:4)) * 100.
;  print(pa)

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
;  print(pa)

  y(1,:) = (y(1,:)-y(1,0))/y(1,0) * 100.

;;;
  delete(data)
  data = asciiread("../ukesm/oh_2015-2100_r1i1p1f2.txt",(/86/),"float")

  y(2,0:85) = data(:) * 1000.

  pa = trend_manken(y(2,:), False, 0)
  pa(1) = pa(1)/avg(y(2,0:4)) * 100.
;  print(pa)

  y(2,:) = (y(2,:)-y(2,0))/y(2,0) * 100.

;;;;;;;;;;;;;;;;;;; O3

  y2 = new((/3,86/),float)
  y2@_FillValue = -999

  data  = asciiread("../gfdl/o3_2015-2100_r1i1p1f1.txt",(/86/),"float")

  y2(0,:)     = data(:) * 1000. ; Gg units

  pa = trend_manken(y2(0,:), False, 0)
  pa(1) = pa(1)/avg(y2(0,0:4)) * 100.
;  print(pa)

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
;  print(pa)

  y2(1,:) = (y2(1,:)-y2(1,0))/y2(1,0) * 100.

;;;
  delete(data)
  data = asciiread("../ukesm/o3_2015-2100_r1i1p1f2.txt",(/86/),"float")

  y2(2,0:85) = data(:) * 1000.
  pa = trend_manken(y2(2,:), False, 0)
  pa(1) = pa(1)/avg(y2(2,0:4)) * 100.
;  print(pa)

  y2(2,:) = (y2(2,:)-y2(2,0))/y2(2,0) * 100.


;;;;;;;;;;;;;;;;;;; NO

  y31 = new((/3,86/),float)
  y31@_FillValue = -999

  data  = asciiread("../gfdl/no_2015-2100_r1i1p1f1.txt",(/86/),"float")

  y31(0,:)     = data(:) * 1000. ; Gg units

  pa = trend_manken(y31(0,:), False, 0)
  pa(1) = pa(1)/avg(y31(0,0:4)) * 100.
;  print(pa)

;  y2(0,:) = (y2(0,:)-y2(0,0))/y2(0,0) * 100.

;;;
  delete(data)
  data = new((/86/),float)
  data(0:9)  = asciiread("../mri/no_r1i1p1f1_201501-202412.txt",(/10/),"float")
  data(10:19)  = asciiread("../mri/no_r1i1p1f1_202501-203412.txt",(/10/),"float")
  data(20:29)  = asciiread("../mri/no_r1i1p1f1_203501-204412.txt",(/10/),"float")
  data(30:39)  = asciiread("../mri/no_r1i1p1f1_204501-205412.txt",(/10/),"float")
  data(40:49)  = asciiread("../mri/no_r1i1p1f1_205501-206412.txt",(/10/),"float")
  data(50:59)  = asciiread("../mri/no_r1i1p1f1_206501-207412.txt",(/10/),"float")
  data(60:69)  = asciiread("../mri/no_r1i1p1f1_207501-208412.txt",(/10/),"float")
  data(70:79)  = asciiread("../mri/no_r1i1p1f1_208501-209412.txt",(/10/),"float")
  data(80:85)  = asciiread("../mri/no_r1i1p1f1_209501-210012.txt",(/6/),"float")

  y31(1,:)     = data(:) * 1000.

  pa = trend_manken(y31(1,:), False, 0)
  pa(1) = pa(1)/avg(y31(1,0:4)) * 100.
;  print(pa)

;  y2(1,:) = (y2(1,:)-y2(1,0))/y2(1,0) * 100.

;;;
  delete(data)
  data = asciiread("../ukesm/no_2015-2100_r1i1p1f2.txt",(/86/),"float")

  y31(2,0:85) = data(:) * 1000.

  pa = trend_manken(y31(2,:), False, 0)
  pa(1) = pa(1)/avg(y31(2,0:4)) * 100.
;  print(pa)

;  y2(2,:) = (y2(2,:)-y2(2,0))/y2(2,0) * 100.

;;;;;;;;;;;;;;;;;;; NO2

  y32 = new((/3,86/),float)
  y32@_FillValue = -999

  data  = asciiread("../gfdl/no2_2015-2100_r1i1p1f1.txt",(/86/),"float")

  y32(0,:)     = data(:) * 1000. ; Gg units

  pa = trend_manken(y32(0,:), False, 0)
  pa(1) = pa(1)/avg(y32(0,0:4)) * 100.
;  print(pa)

;  y2(0,:) = (y2(0,:)-y2(0,0))/y2(0,0) * 100.

;;;
  delete(data)
  data = new((/86/),float)
  data(0:9)  = asciiread("../mri/no2_r1i1p1f1_201501-202412.txt",(/10/),"float")
  data(10:19)  = asciiread("../mri/no2_r1i1p1f1_202501-203412.txt",(/10/),"float")
  data(20:29)  = asciiread("../mri/no2_r1i1p1f1_203501-204412.txt",(/10/),"float")
  data(30:39)  = asciiread("../mri/no2_r1i1p1f1_204501-205412.txt",(/10/),"float")
  data(40:49)  = asciiread("../mri/no2_r1i1p1f1_205501-206412.txt",(/10/),"float")
  data(50:59)  = asciiread("../mri/no2_r1i1p1f1_206501-207412.txt",(/10/),"float")
  data(60:69)  = asciiread("../mri/no2_r1i1p1f1_207501-208412.txt",(/10/),"float")
  data(70:79)  = asciiread("../mri/no2_r1i1p1f1_208501-209412.txt",(/10/),"float")
  data(80:85)  = asciiread("../mri/no2_r1i1p1f1_209501-210012.txt",(/6/),"float")

  y32(1,:)     = data(:) * 1000.

  pa = trend_manken(y32(1,:), False, 0)
  pa(1) = pa(1)/avg(y32(1,0:4)) * 100.
;  print(pa)

;  y2(1,:) = (y2(1,:)-y2(1,0))/y2(1,0) * 100.

;;;
  delete(data)
  data = asciiread("../ukesm/no2_2015-2100_r1i1p1f2.txt",(/86/),"float")

  y32(2,0:85) = data(:) * 1000.

  pa = trend_manken(y32(2,:), False, 0)
  pa(1) = pa(1)/avg(y32(2,0:4)) * 100.
;  print(pa)

;  y2(2,:) = (y2(2,:)-y2(2,0))/y2(2,0) * 100.

  y3 = y31/30.+y32/46.

  pa = trend_manken(y3(0,:), False, 0)
  pa(1) = pa(1)/avg(y3(0,0:4)) * 100.
  print(pa)
  pa = trend_manken(y3(1,:), False, 0)
  pa(1) = pa(1)/avg(y3(1,0:4)) * 100.
  print(pa)
  pa = trend_manken(y3(2,:), False, 0)
  pa(1) = pa(1)/avg(y3(2,0:4)) * 100.
  print(pa)

  y3(0,:) = (y3(0,:)-y3(0,0))/y3(0,0) * 100.
  y3(1,:) = (y3(1,:)-y3(1,0))/y3(1,0) * 100.
  y3(2,:) = (y3(2,:)-y3(2,0))/y3(2,0) * 100.


;;;;;;;;;;;;;;;;;;; CO

  y4 = new((/3,86/),float)
  y4@_FillValue = -999

  data  = asciiread("../gfdl/co_2015-2100_r1i1p1f1.txt",(/86/),"float")

  y4(0,:)     = data(:) * 1000. ; Gg units

  pa = trend_manken(y4(0,:), False, 0)
  pa(1) = pa(1)/avg(y4(0,0)) * 100.
  print(pa)

  y4(0,:) = (y4(0,:)-y4(0,0))/y4(0,0) * 100.

;;;
  delete(data)
  data = new((/86/),float)
  data(0:9)  = asciiread("../mri/co_r1i1p1f1_201501-202412.txt",(/10/),"float")
  data(10:19)  = asciiread("../mri/co_r1i1p1f1_202501-203412.txt",(/10/),"float")
  data(20:29)  = asciiread("../mri/co_r1i1p1f1_203501-204412.txt",(/10/),"float")
  data(30:39)  = asciiread("../mri/co_r1i1p1f1_204501-205412.txt",(/10/),"float")
  data(40:49)  = asciiread("../mri/co_r1i1p1f1_205501-206412.txt",(/10/),"float")
  data(50:59)  = asciiread("../mri/co_r1i1p1f1_206501-207412.txt",(/10/),"float")
  data(60:69)  = asciiread("../mri/co_r1i1p1f1_207501-208412.txt",(/10/),"float")
  data(70:79)  = asciiread("../mri/co_r1i1p1f1_208501-209412.txt",(/10/),"float")
  data(80:85)  = asciiread("../mri/co_r1i1p1f1_209501-210012.txt",(/6/),"float")

  y4(1,:)     = data(:) * 1000.

  pa = trend_manken(y4(1,:), False, 0)
  pa(1) = pa(1)/avg(y4(1,0)) * 100.
  print(pa)

  y4(1,:) = (y4(1,:)-y4(1,0))/y4(1,0) * 100.

;;;
  delete(data)
  data = asciiread("../ukesm/co_2015-2100_r1i1p1f2.txt",(/86/),"float")

  y4(2,0:85) = data(:) * 1000.

  pa = trend_manken(y4(2,:), False, 0)
  pa(1) = pa(1)/avg(y4(2,0)) * 100.
  print(pa)

  y4(2,:) = (y4(2,:)-y4(2,0))/y4(2,0) * 100.


  res = True
  res@vpHeightF          = 0.5               ; change aspect ratio of plot
  res@vpWidthF           = 0.5
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
  res@tiYAxisString = "OH changes (%)"
  res@tiYAxisFontHeightF = 0.04

  res@tmXMajorGrid                = False          ; implement x grid
  res@tmXMajorGridThicknessF      = 0.6           ; 2.0 is default
  res@tmXMajorGridLineDashPattern = 2             ; select short dash lines

  res@tmYMajorGrid                = False          ; implement y grid
  res@tmYMajorGridThicknessF      = 0.6           ; 2.0 is default
  res@tmYMajorGridLineDashPattern = 2

;  res@trYMinF  = 0.12
;  res@trYMaxF  = 0.36

;  res@gsnStringFont = "helvetica-bold"
  res@gsnLeftString = "d"
  res@gsnLeftStringFontHeightF = 0.04
  res@gsnLeftStringFontHeightF = 0.04
  res@gsnLeftStringParallelPosF = -0.05
  res@gsnLeftStringOrthogonalPosF = 0.05

  plot(3) = gsn_csm_xy(wks,x,y,res)

  res@gsnLeftString = "c"
  res@tiYAxisString = "O~B~3~N~ changes (%)"
  plot(2) = gsn_csm_xy(wks,x,y2,res)

  res@gsnLeftString = "a"
  res@tiYAxisString = "NO~B~x~N~ changes (%)"
  plot(0) = gsn_csm_xy(wks,x,y3,res)

  res@gsnLeftString = "b"
  res@tiYAxisString = "CO changes (%)"
  plot(1) = gsn_csm_xy(wks,x,y4,res)


  gres = True
  gres@YPosPercent = 95.    ; expressed as %, 0->100, sets position of top border of legend
                            ;  when gres@Position is set to its default setting of "Top" (Default = 95.)
  gres@XPosPercent = 44.      ; expressed as %, 0->100, sets position of left border of legend(Default = 5.)

  gres@ItemSpacePercent = 10

  lineres = True
  lineres@lgLineColors = (/"grey20","blue","red"/) ; line colors
  lineres@lgLineThicknesses = 5.                        ; line thicknesses
  lineres@LineLengthPercent = 10.                         ; expressed as %, 0->100, length of line

  lineres@lgPerimFill            = "SolidFill"      ; Fill legend box w/white
  lineres@lgPerimFillColor       = "white"

  textres = True
  textres@lgLabelFontHeights  = 0.03
  textres@lgLabels = (/"GFDL-ESM","MRI-ESM","UKESM"/)  ; legend labels (required)

  map = simple_legend(wks,plot(0),gres,lineres,textres)

;;--------------------------------------
   delete(data)
   data  = asciiread("./co_ukesm.txt",(/172/),"float")

   colife1 =  new(86,float)
   coloss1 = new(86,float)

   do i=0,85
    colife1(i) = data(i*2)
    coloss1(i) = data(i*2+1)/28.  ; Tmol
   end do

;   print(coloss1)

   data  = asciiread("./co_gfdl.txt",(/172/),"float")

   colife2 =  new(86,float)
   coloss2 = new(86,float)

   do i=0,85
    colife2(i) = data(i*2)
    coloss2(i) = data(i*2+1)/28.  ; Tmol
   end do

   data(0:99)  = asciiread("./life_mri1.txt",(/100/),"float")
   data(100:171) = asciiread("./life_mri2.txt",(/72/),"float")

   colife3 =  new(86,float)
   coloss3 = new(86,float)

   do i=0,85
    colife3(i) = data(i*2)
    coloss3(i) = data(i*2+1)/28.  ; Tmol
   end do

   coloss = (coloss1+coloss2+coloss3)/3.0

   x     = ispan(2015,2100,1)
   y = new((/3,86/),float)
   y(0,:) = coloss1
   y(1,:) = coloss2
   y(2,:) = coloss3

;;;;;;; CH4 loss
   burden = asciiread("../ukesm/ch4_2015-2100_r1i1p1f2.txt",(/86/),"float")
   life = asciiread("../lifetime/life_ukesm.txt",(/86/),"float")

   loss1 = (burden/life)/16. ; Tmol

   burden = asciiread("../gfdl/ch4_2015-2100_r1i1p1f1.txt",(/86/),"float")
   life = asciiread("../lifetime/life_gfdl.txt",(/86/),"float")

   loss2 = (burden/life)/16.

  burden(0:9)  = asciiread("../mri/ch4_r1i1p1f1_201501-202412.txt",(/10/),"float")
  burden(10:19)  = asciiread("../mri/ch4_r1i1p1f1_202501-203412.txt",(/10/),"float")
  burden(20:29)  = asciiread("../mri/ch4_r1i1p1f1_203501-204412.txt",(/10/),"float")
  burden(30:39)  = asciiread("../mri/ch4_r1i1p1f1_204501-205412.txt",(/10/),"float")
  burden(40:49)  = asciiread("../mri/ch4_r1i1p1f1_205501-206412.txt",(/10/),"float")
  burden(50:59)  = asciiread("../mri/ch4_r1i1p1f1_206501-207412.txt",(/10/),"float")
  burden(60:69)  = asciiread("../mri/ch4_r1i1p1f1_207501-208412.txt",(/10/),"float")
  burden(70:79)  = asciiread("../mri/ch4_r1i1p1f1_208501-209412.txt",(/10/),"float")
  burden(80:85)  = asciiread("../mri/ch4_r1i1p1f1_209501-210012.txt",(/6/),"float")

  life(0:49) = asciiread("../lifetime/life_mri1.txt",(/50/),"float")
  life(50:85) = asciiread("../lifetime/life_mri2.txt",(/36/),"float")

  loss3 = (burden/life)/16.

  loss = (loss1+loss2+loss3)/3.0

   y2 = new((/3,86/),float)
   y2(0,:) = loss1
   y2(1,:) = loss2
   y2(2,:) = loss3

;;; oh change

  total = (loss+coloss)/0.55
  diff = ((loss+coloss)-(loss(0)+coloss(0)))/total(0)

  oh = (1./(1+diff)-1)*100.
  print(oh)

;;;; h2o concentration

  h2o = new((/2,86/),float)
  h2o(1,:) = asciiread("../mri/h2otropic.txt",(/86/),"float")
  h2o(0,:) = asciiread("../mri/h2ogloba.txt",(/86/),"float")

  h2o = h2o * 1000. ; g/kg

  delete(pa)
  pa = trend_manken(h2o(0,:), False, 0)
  print(pa)
  pa = trend_manken(h2o(1,:), False, 0)
  print(pa)

  rc1 = regline_stats(x*1.0,h2o(0,:))
  rc2 = regline_stats(x*1.0,h2o(1,:))

  rc = h2o
  rc(0,:) = rc1@Yest
  rc(1,:) = rc2@Yest


  dres = True
  dres@gsnDraw                = False
  dres@gsnFrame               = False

;  res@vpHeightF          = 0.6               ; change aspect ratio of plot
;  res@vpWidthF           = 0.5

  dres@vpHeightF          = 0.5               ; change aspect ratio of plot
  dres@vpWidthF           = 0.5

  dres@trXMinF         = 2015    ; set minimum X-axis value
  dres@trXMaxF         = 2100

  dres@xyMonoLineColor    = False             ; want colored lines
  dres@xyLineColors       = (/"Red","Blue","Black"/) ; colors chosen
  dres@xyLineThicknesses  = (/4.,4.,4./)      ; line thicknesses
  dres@xyDashPatterns     = (/0.,0.,0./)

  dres@tmXTOn = False
  dres@tmYROn = False
  dres@tmYLLabelFontHeightF = 0.03
  dres@tmXBLabelFontHeightF = 0.03

  dres@tiMainString      = ""
  dres@tiYAxisFontHeightF = 0.04
;  dres@tiYAxisString = "OH sink with CO and CH~B~4~N~ (Tmol)"
  dres@tiYAxisString = "OH sink (Tmol yr~S~-1~N~)"

;  res@trYMinF  = 0.12
;  res@trYMaxF  = 0.36
;  draw(plot1)
;  frame(wks)

;  draw(plot2)
;  frame(wks)

  delete(dres@xyLineColors)
  delete(dres@xyLineThicknesses)
  delete(dres@xyDashPatterns)

  dres@xyLineThicknessF  = (/0.00001/)
  dres@gsnAboveYRefLineColor = "LightPink"
  dres@gsnYRefLine           = 0.0

  dres@trYMinF  = 0.
  dres@trYMaxF  = 120.
  loss = loss + coloss

  res2 = dres
  res2@trYMinF  = -10.
  res2@trYMaxF  = 60.
  delete(res2@gsnAboveYRefLineColor)

;  dres@gsnStringFont = "helvetica-bold"
  dres@gsnLeftString = "e"
  dres@gsnLeftStringFontHeightF = 0.04
  dres@gsnLeftStringParallelPosF = -0.05
  dres@gsnLeftStringOrthogonalPosF = 0.05

  plot(4) = gsn_csm_xy(wks,x,loss,dres)


  dres@gsnAboveYRefLineColor = "LightBlue"
  plot4 = gsn_csm_xy(wks,x,coloss,dres)

  overlay(plot(4),plot4)

;  draw(plot3)
;  frame(wks)

  delete(dres@gsnYRefLine)
  delete(dres@gsnAboveYRefLineColor)

  dres@trYMinF  = 2.8
  dres@trYMaxF  = 6.2

  dres@xyLineColors       = (/"royalblue4","blue"/) ; colors chosen
  dres@xyLineThicknesses  = (/3.,3./)      ; line thicknesses
  dres@xyDashPatterns     = (/0.,0./)
  dres@tiYAxisString = "Water vapor (g kg~S~-1~N~)"
  dres@gsnLeftString = "f"
  plot(5) = gsn_csm_xy(wks,x,h2o,dres)

  dres@xyLineThicknesses  = (/2.,2./)
  dres@xyDashPatterns     = (/2.,2./)
  plot5 = gsn_csm_xy(wks,x,rc,dres)
  overlay(plot(5),plot5)


  pnlres                = True
  pnlres@gsnFrame       = False
  pnlres@gsnMaximize  = True
  pnlres@gsnPanelRowSpec = True
  pnlres@gsnPanelTop = 0.9
  pnlres@gsnPanelBottom = 0.1  ; Leave room for legend at the bottom.
  pnlres@gsnPanelMainString       = ""
  pnlres@gsnPanelYWhiteSpacePercent = 5
  pnlres@gsnPanelXWhiteSpacePercent = 3
  gsn_panel(wks,plot(0:5),(/3,3/),pnlres)

