

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

  pa = trend_manken(h2o(0,:), False, 0)
  print(pa)
  pa = trend_manken(h2o(1,:), False, 0)
  print(pa)

  rc1 = regline_stats(x*1.0,h2o(0,:))
  rc2 = regline_stats(x*1.0,h2o(1,:))

  rc = h2o
  rc(0,:) = rc1@Yest
  rc(1,:) = rc2@Yest

  wks = gsn_open_wks("pdf","loss")

  res = True
  res@gsnDraw                = False
  res@gsnFrame               = False

;  res@vpHeightF          = 0.6               ; change aspect ratio of plot
;  res@vpWidthF           = 0.5

  res@vpHeightF          = 0.5               ; change aspect ratio of plot
  res@vpWidthF           = 0.6

  res@trXMinF         = 2015    ; set minimum X-axis value
  res@trXMaxF         = 2100

  res@xyMonoLineColor    = False             ; want colored lines
  res@xyLineColors       = (/"Red","Blue","Black"/) ; colors chosen
  res@xyLineThicknesses  = (/4.,4.,4./)      ; line thicknesses
  res@xyDashPatterns     = (/0.,0.,0./)

  res@tmXTOn = False
  res@tmYROn = False
  res@tmYLLabelFontHeightF = 0.03
  res@tmXBLabelFontHeightF = 0.03

;  res@tmYLLabelFontHeightF = 0.023
;  res@tmXBLabelFontHeightF = 0.023

  res@tiMainString      = ""
  res@tiYAxisString = "OH sink due to CO and CH~B~4~N~ (Tmol)"

;  res@trYMinF  = 0.12
;  res@trYMaxF  = 0.36
  plot1 = gsn_csm_xy(wks,x,y,res)
;  draw(plot1)
;  frame(wks)

  plot2 = gsn_csm_xy(wks,x,y2,res)
;  draw(plot2)
;  frame(wks)

  delete(res@xyLineColors)
  delete(res@xyLineThicknesses)
  delete(res@xyDashPatterns)

  res@xyLineThicknessF  = (/0.00001/)
  res@gsnAboveYRefLineColor = "LightPink"
  res@gsnYRefLine           = 0.0
 
  res@trYMinF  = 0.
  res@trYMaxF  = 120.
  loss = loss + coloss

  res2 = res
  res2@trYMinF  = -10.
  res2@trYMaxF  = 60.
  delete(res2@gsnAboveYRefLineColor)

  plot3 = new(2,graphic)
;  plot3 = gsn_csm_xy2(wks,x,loss,oh,res,res2)
  plot3(0) = gsn_csm_xy(wks,x,loss,res)


  res@gsnAboveYRefLineColor = "LightBlue"
  plot4 = gsn_csm_xy(wks,x,coloss,res)

  overlay(plot3(0),plot4)

;  draw(plot3)
;  frame(wks)

  delete(res@gsnYRefLine)
  delete(res@gsnAboveYRefLineColor)

  res@trYMinF  = 2.8
  res@trYMaxF  = 6.2

  res@xyLineColors       = (/"lightblue","Blue"/) ; colors chosen
  res@xyLineThicknesses  = (/7.,7./)      ; line thicknesses
  res@xyDashPatterns     = (/0.,0./)
  res@tiYAxisString = "Water vapor (g kg~S~-1~N~)"
  plot3(1) = gsn_csm_xy(wks,x,h2o,res)

  res@xyLineThicknesses  = (/4.,4./)
  res@xyDashPatterns     = (/11.,11./)
  plot5 = gsn_csm_xy(wks,x,rc,res)
  overlay(plot3(1),plot5)

  pnlres                = True
  pnlres@gsnFrame       = False
  pnlres@gsnMaximize  = True
;  pnlres@gsnPanelBottom = 0.18  ; Leave room for legend at the bottom.
  pnlres@gsnPanelMainString       = ""
  pnlres@gsnPanelYWhiteSpacePercent = 3
  pnlres@gsnPanelXWhiteSpacePercent = 5
  gsn_panel(wks,plot3,(/1,2/),pnlres)
