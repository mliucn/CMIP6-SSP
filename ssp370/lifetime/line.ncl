

  x     = ispan(2015,2100,1)

  y = new((/7,86/),float)  ; 2015 - 2100
  y@_FillValue = -999

  data1 = asciiread("trend_ukesmnew.txt",(/85,3/),"float")

; a percentage change relative to 2015

  y(0,0:84) = (data1(:,0)-data1(0,0))/data1(0,0) * 100.
  y(0,85) = y@_FillValue

  data2 = asciiread("trend_gfdlnew.txt",(/86,3/),"float")
  y(1,0:85) = (data2(:,0)-data2(0,0))/data2(0,0) * 100.

  data2 = asciiread("trend_mrinew.txt",(/86,3/),"float")
  y(2,0:85) = (data2(:,0)-data2(0,0))/data2(0,0) * 100.


  y(3,0:84) = (data1(:,1)-data1(0,1))/data1(0,1) * 100.
  y(3,85) = y@_FillValue

  data2 = asciiread("trend_gfdlnew.txt",(/86,3/),"float")
  y(4,0:85) = (data2(:,1)-data2(0,1))/data2(0,1) * 100.

  data2 = asciiread("trend_mrinew.txt",(/86,3/),"float")
  y(5,0:85) = (data2(:,1)-data2(0,1))/data2(0,1) * 100.

;  print(y(4:5,0:85))

; cmip6 ch4 trend

  cmip = asciiread("/home/server/aero4/liumx/data/cmip6/ssp370/gfdl/ch4_2015-2100_r1i1p1f1.txt", \
    86,"float")
  y(6,0:85) = (cmip(:)-cmip(0))/cmip(0) * 100.

  print(y(6,0:85))


  wks = gsn_open_wks("pdf","gsn_ch4new")

  res = True
  res@gsnDraw                = False
  res@gsnFrame               = False
  res@gsnMaximize       = True
  res@vpHeightF          = 0.6               ; change aspect ratio of plot
  res@vpWidthF           = 0.4

  res@trXMinF         = 2015    ; set minimum X-axis value
  res@trXMaxF         = 2100    ; set maximum X-axis value

  res@xyMonoLineColor    = False             ; want colored lines
  res@xyLineColors       = (/"Red","Blue","Black"/) ; colors chosen
  res@xyLineThicknesses  = (/3.,3.,3./)      ; line thicknesses
  res@xyDashPatterns     = (/0.,0.,0./)

  res@tmXTOn = False
  res@tmYROn = False
  res@tmYLLabelFontHeightF = 0.03
  res@tmXBLabelFontHeightF = 0.03

  res@tiMainString      = "CH~B~4~N~ evolution"
  res@tiYAxisString = "%"
  res@tiYAxisFontHeightF = 0.03

  plot = gsn_csm_xy(wks,x,y(0:2,:),res)

  delete(res@xyDashPatterns)
  delete(res@xyLineColors)
  delete(res@xyLineThicknesses)
  res@xyDashPatterns     = (/1.,1.,1.,0/)
  res@xyLineColors       = (/"Red","Blue","Black","Orange"/) ; colors chosen
  res@xyLineThicknesses  = (/3.,3.,3.,3./)
  plot2 = gsn_csm_xy(wks,x,y(3:6,:),res)

  overlay(plot,plot2)

  draw(plot)
  frame(wks)

