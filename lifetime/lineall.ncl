

  x     = ispan(2015,2100,1)

;;; read lifetimes

  life = new((/6,86/),float)
  data = asciiread("life_ukesm.txt",86,"float")
  life(0,:) = 1./(1./data+1./150.)

  pa = trend_manken(life(0,:), False, 0)
  pa(1) = pa(1)*85.
  print(pa)

  data = asciiread("life_gfdl.txt",86,"float")
  life(1,:) = 1./(1./data+1./150.)

  pa = trend_manken(life(1,:), False, 0)
  pa(1) = pa(1)*85.
  print(pa)

  life(2,0:49) = asciiread("life_mri1.txt",50,"float")
  life(2,50:85:) = asciiread("life_mri2.txt",36,"float")
  life(2,:) = 1./(1./life(2,:)+1./150.)

  pa = trend_manken(life(2,:), False, 0)
  pa(1) = pa(1)*85.
  print(pa)

  data = asciiread("../../ssp370/lifetime/life_ukesm.txt",86,"float")
  life(3,:) = 1./(1./data+1./150.)

  pa = trend_manken(life(3,:), False, 0)
  pa(1) = pa(1)*85.
  print(pa)

  data = asciiread("../../ssp370/lifetime/life_gfdl.txt",86,"float")
  life(4,:) = 1./(1./data+1./150.)

  pa = trend_manken(life(4,:), False, 0)
  pa(1) = pa(1)*85.
  print(pa)

  life(5,0:49) = asciiread("../../ssp370/lifetime/life_mri1.txt",50,"float")
  life(5,50:85:) = asciiread("../../ssp370/lifetime/life_mri2.txt",36,"float")
  life(5,:) = 1./(1./life(5,:)+1./150.)

  pa = trend_manken(life(5,:), False, 0)
  pa(1) = pa(1)*85.
  print(pa)

  value = (/life(0,0),life(0,85),life(1,0),life(1,85),life(2,0),life(2,85), \
            life(3,0),life(3,85),life(4,0),life(4,85),life(5,0),life(5,85)/)
  print(value)
;;;;;;;;;;;;;;;;;;;;;;; CH4 conc.

  y = new((/7,86/),float)  ; 2015 - 2100
;  y2 = new((/2,86/),float)
  d1 = new((/6,86/),float)

  y@_FillValue = -999

  data1 = asciiread("trend_ukesmnew.txt",(/86,3/),"float")
  y(0,0:85) = (data1(:,0)-data1(0,0))/data1(0,0) * 100.

  data2 = asciiread("trend_gfdlnew.txt",(/86,3/),"float")
  y(1,0:85) = (data2(:,0)-data2(0,0))/data2(0,0) * 100.

  data2 = asciiread("trend_mrinew.txt",(/86,3/),"float")
  y(2,0:85) = (data2(:,0)-data2(0,0))/data2(0,0) * 100.


  y(3,0:85) = (data1(:,1)-data1(0,1))/data1(0,1) * 100.

  data2 = asciiread("trend_gfdlnew.txt",(/86,3/),"float")
  y(4,0:85) = (data2(:,1)-data2(0,1))/data2(0,1) * 100.

  data2 = asciiread("trend_mrinew.txt",(/86,3/),"float")
  y(5,0:85) = (data2(:,1)-data2(0,1))/data2(0,1) * 100.

;  print(y(4:5,0:85))

;  y2(0,:) = dim_avg_n(y(0:2,:),0)
;  y2(1,:) = dim_avg_n(y(3:5,:),0)

  d1(0,:) = y(0,:)
  d1(1,:) = y(3,:)

  d1(2,:) = y(1,:)
  d1(3,:) = y(4,:)

  d1(4,:) = y(2,:)
  d1(5,:) = y(5,:)

;;;;;;;;;;;;;;;;;;;; 370
  y2 = new((/7,86/),float)
  d2 = new((/6,86/),float)

  data1 = asciiread("../../ssp370/lifetime/trend_ukesmnew.txt",(/86,3/),"float")
  y2(0,0:85) = (data1(:,0)-data1(0,0))/data1(0,0) * 100.

  data2 = asciiread("../../ssp370/lifetime/trend_gfdlnew.txt",(/86,3/),"float")
  y2(1,0:85) = (data2(:,0)-data2(0,0))/data2(0,0) * 100.

  data2 = asciiread("../../ssp370/lifetime/trend_mrinew.txt",(/86,3/),"float")
  y2(2,0:85) = (data2(:,0)-data2(0,0))/data2(0,0) * 100.


  y2(3,0:85) = (data1(:,1)-data1(0,1))/data1(0,1) * 100.

  data2 = asciiread("../../ssp370/lifetime/trend_gfdlnew.txt",(/86,3/),"float")
  y2(4,0:85) = (data2(:,1)-data2(0,1))/data2(0,1) * 100.

  data2 = asciiread("../../ssp370/lifetime/trend_mrinew.txt",(/86,3/),"float")
  y2(5,0:85) = (data2(:,1)-data2(0,1))/data2(0,1) * 100.

  d2(0,:) = y2(0,:)
  d2(1,:) = y2(3,:)

  d2(2,:) = y2(1,:)
  d2(3,:) = y2(4,:)

  d2(4,:) = y2(2,:)
  d2(5,:) = y2(5,:)


; cmip6 ch4 trend

  cmip = asciiread("/home/server/aero4/liumx/data/cmip6/ssp126/gfdl/ch4_2015-2100_r1i1p1f1.txt", \
    86,"float")
  y(6,0:85) = (cmip(:)-cmip(0))/cmip(0) * 100.

  cmip = asciiread("/home/server/aero4/liumx/data/cmip6/ssp370/gfdl/ch4_2015-2100_r1i1p1f1.txt", \
    86,"float")
  y2(6,0:85) = (cmip(:)-cmip(0))/cmip(0) * 100.

;  print(y(6,0:85))


  wks = gsn_open_wks("pdf","gsn_ch4trend2a")

  plot = new(3,graphic)
  lres = True
  lres@gsnDraw                = False
  lres@gsnFrame               = False
  lres@gsnMaximize       = False

  lres@vpHeightF          = 0.3               ; change aspect ratio of plot
  lres@vpWidthF           = 0.55
  lres@vpXF             = 0.2
  lres@vpYF             = 0.95

  lres@tmXTOn = False
  lres@tmYROn = False
  lres@tmYLLabelFontHeightF = 0.02
  lres@tmXBLabelFontHeightF = 0.02

  lres@tiYAxisString = "CH~B~4~N~ lifetime (yr)"
  lres@tiYAxisFontHeightF = 0.02

  lres@trXMinF         = 2015    ; set minimum X-axis value
  lres@trXMaxF         = 2100

  lres@trYMinF         = 6.0    ; set minimum X-axis value
  lres@trYMaxF         = 11.0
  lres@xyMarkLineModes = "Lines"

  lres@xyLineColors       = (/"Red","grey25","Blue"/) ; colors chosen
  lres@xyLineThicknesses  = (/3.,3.,3./)      ; line thicknesses
  lres@xyDashPatterns     = (/0.,0.,0./)
  plot(0) = gsn_csm_xy(wks,x,life(0:2,:),lres)

  delete(lres@xyMarkLineModes)
  lres@xyMarkLineModes = (/"Markers","Markers","Markers"/)
  lres@xyMarkers         =  (/7,7,7/) 
  lres@xyMarkerColors     = (/"Red","grey25","Blue"/)
  fig = gsn_csm_xy(wks,x,life(3:5,:),lres)
  overlay(plot(0),fig)

  gres = True
  gres@YPosPercent = 90.    ; expressed as %, 0->100, sets position of top border of legend
                            ;  when gres@Position is set to its default setting of "Top" (Default = 95.)
  gres@XPosPercent = 80.      ; expressed as %, 0->100, sets position of left border of legend(Default = 5.)

  gres@ItemSpacePercent = 3

  lineres = True
  lineres@lgLineColors = (/"blue","grey25","red"/) ; line colors
  lineres@lgLineThicknesses = 4.5                        ; line thicknesses
  lineres@LineLengthPercent = 4.                         ; expressed as %, 0->100, length of line

  textres = True
  textres@lgLabelFontHeights  = 0.02
  textres@lgLabels = (/"MRI","GFDL","UKESM"/)  ; legend labels (required)

  simple_legend_ndc(wks,gres,lineres,textres)


  res = True
  res@gsnDraw                = False
  res@gsnFrame               = False
  res@gsnMaximize       = False
  res@vpHeightF          = 0.47  ;0.6               ; change aspect ratio of plot
  res@vpWidthF           = 0.32  ;0.4
  res@vpXF             = 0.2
  res@vpYF             = 0.52

  res@trXMinF         = 2015    ; set minimum X-axis value
  res@trXMaxF         = 2100    ; set maximum X-axis value

  res@xyMonoLineColor    = False             ; want colored lines
  res@xyLineColors       = (/"Red","grey25","Blue"/) ; colors chosen
  res@xyLineThicknesses  = (/3.,3.,3./)      ; line thicknesses
  res@xyDashPatterns     = (/0.,0.,0./)

  res@tmXTOn = False
  res@tmYROn = False
  res@tmYLLabelFontHeightF = 0.02
  res@tmXBLabelFontHeightF = 0.02

  res@tiMainString      = ""
  res@tiMainFontHeightF = 0.025
  res@tiYAxisString = "CH~B~4~N~ changes (%)"
  res@tiYAxisFontHeightF = 0.02

;  res@trYMinF         = -60    ; set minimum X-axis value
;  res@trYMaxF         = 10

  plot(1) = gsn_csm_xy(wks,x,y(0:2,:),res)

  res@vpHeightF          = 0.47  ;0.6               ; change aspect ratio of plot
  res@vpWidthF           = 0.32  ;0.4
  res@vpXF             = 0.65
  res@vpYF             = 0.52
  res@tiYAxisString = ""
  plot(2) = gsn_csm_xy(wks,x,y2(0:2,:),res)

  delete(res@xyDashPatterns)
  delete(res@xyLineColors)
  delete(res@xyLineThicknesses)
  res@xyDashPatterns     = (/1.,1.,1.,1./)
  res@xyLineColors       = (/"Red","grey25","Blue","orange"/) ; colors chosen
  res@xyLineThicknesses  = (/3.,3.,3.,3./)
  plot2 = gsn_csm_xy(wks,x,y(3:6,:),res)
  plot3 = gsn_csm_xy(wks,x,y2(3:6,:),res)

  overlay(plot(1),plot2)
  overlay(plot(2),plot3)

  delete(res@xyLineColors)
  res@gsnXYFillColors = "LightPink"
  res@xyLineColor = -1
  res@gsnXYFillOpacities = 0.7
  mid1 = gsn_csm_xy(wks,x,d1(0:1,:), res)
  nid1 = gsn_csm_xy(wks,x,d2(0:1,:), res)

  res@gsnXYFillColors = "LightBlue"
  res@gsnXYFillOpacities = 0.3
  mid2 = gsn_csm_xy(wks,x,d1(4:5,:), res)
  nid2 = gsn_csm_xy(wks,x,d2(4:5,:), res)

  res@gsnXYFillColors = "grey30"
  res@gsnXYFillOpacities = 0.3
  mid3 = gsn_csm_xy(wks,x,d1(2:3,:), res)
  nid3 = gsn_csm_xy(wks,x,d2(2:3,:), res)

  overlay(plot(1),mid1)
  overlay(plot(1),mid2)
  overlay(plot(1),mid3)

  overlay(plot(2),nid1)
  overlay(plot(2),nid2)
  overlay(plot(2),nid3)

  psres = True                                                               
  maximize_output(wks,psres)

  pnlres                = True
  pnlres@gsnFrame       = False
  pnlres@gsnMaximize  = True
  pnlres@gsnPanelRowSpec = True 
  pnlres@gsnPanelTop = 0.9
  pnlres@gsnPanelBottom = 0.1  ; Leave room for legend at the bottom.
  pnlres@gsnPanelMainString       = ""
  pnlres@gsnPanelYWhiteSpacePercent = 15
  pnlres@gsnPanelXWhiteSpacePercent = 1
;  gsn_panel(wks,plot,(/1,2/),pnlres)
