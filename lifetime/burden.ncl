
; ukesm
  life0 = asciiread("life_ukesm.txt",85,"float")

  ch4 = asciiread("ch4total126.txt",85,"float") ; emis

  life = 1./(1/life0+1/150.)

  burden1 = ch4 * life(0)/2.75 ; ppb fixed lifetime

  burden0 = ch4 * life/2.75 ; ppb

  burden = new((/dimsizes(burden0),3/),float)
  burden(:,0) = burden0
  burden(:,1) = burden1
  burden(:,2) = (burden0-burden1)/burden1 * 100.

  opt = True
  opt@fout = "trend_ukesm.txt"
  write_matrix(burden, "3f10.2", opt)

; gfdl
  delete(life0)
  delete(ch4)
  delete(life)
  delete(burden0)
  delete(burden1)
  delete(burden)
  life0 = asciiread("life_gfdl.txt",86,"float")

  ch4 = asciiread("ch4total126.txt",86,"float") ; emis

  life = 1./(1/life0+1/150.)

  burden1 = ch4 * life(0)/2.75 ; ppb fixed lifetime

  burden0 = ch4 * life/2.75 ; ppb

  burden = new((/dimsizes(burden0),3/),float)
  burden(:,0) = burden0
  burden(:,1) = burden1
  burden(:,2) = (burden0-burden1)/burden1 * 100.

  opt = True
  opt@fout = "trend_gfdl.txt"
  write_matrix(burden, "3f10.2", opt)

; mri
  life0(0:49) = asciiread("life_mri1.txt",50,"float")
  life0(50:85) = asciiread("life_mri2.txt",36,"float")

  ch4 = asciiread("ch4total126.txt",86,"float") ; emis

  life = 1./(1/life0+1/150.)

  burden1 = ch4 * life(0)/2.75 ; ppb fixed lifetime

  burden0 = ch4 * life/2.75 ; ppb

  burden = new((/dimsizes(burden0),3/),float)
  burden(:,0) = burden0
  burden(:,1) = burden1
  burden(:,2) = (burden0-burden1)/burden1 * 100.

  opt = True
  opt@fout = "trend_mri.txt"
  write_matrix(burden, "3f10.2", opt)

