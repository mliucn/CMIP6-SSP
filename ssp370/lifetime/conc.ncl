
; ukesm
  life0 = asciiread("life_ukesm.txt",86,"float")

  ch4 = asciiread("ch4total370.txt",86,"float") ; emis

  x0 = 1822.5 ; ppb for 2014

  x1 = x0
  x3 = x0

  life = 1./(1/life0+1/150.)
  burden = ch4
  burden0 = ch4

  do i=0,85  
   x2 = ( x1 * 2.75 * (1.-1/life(i)) + ch4(i) )/2.75 ; ppb fixed lifetime
   x4 = ( x3 * 2.75 * (1.-1/life(0)) + ch4(i) )/2.75
   x1 = x2
   x3 = x4
   burden(i) = x2
   burden0(i) = x4
  end do

  burden1 = new((/dimsizes(burden),3/),float)
  burden1(:,0) = burden
  burden1(:,1) = burden0
  burden1(:,2) = (burden-burden0)/burden0 * 100.

  opt = True
  opt@fout = "trend_ukesmnew.txt"
  write_matrix(burden1, "3f10.2", opt)

; gfdl
  delete(life0)
  delete(ch4)
  delete(life)
  delete(burden0)
  delete(burden1)
  delete(burden)

  life0 = asciiread("life_gfdl.txt",86,"float")

  ch4 = asciiread("ch4total370.txt",86,"float") ; emis

  x0 = 1822.5 ; ppb for 2014

  x1 = x0
  x3 = x0

  life = 1./(1/life0+1/150.)
  burden = ch4
  burden0 = ch4

  do i=0,85
   x2 = ( x1 * 2.75 * (1.-1/life(i)) + ch4(i) )/2.75 ; ppb fixed lifetime
   x4 = ( x3 * 2.75 * (1.-1/life(0)) + ch4(i) )/2.75
   x1 = x2
   x3 = x4
   burden(i) = x2
   burden0(i) = x4
  end do

  burden1 = new((/dimsizes(burden),3/),float)
  burden1(:,0) = burden
  burden1(:,1) = burden0
  burden1(:,2) = (burden-burden0)/burden0 * 100.

  opt = True
  opt@fout = "trend_gfdlnew.txt"
  write_matrix(burden1, "3f10.2", opt)

; mri

  life0(0:49) = asciiread("life_mri1.txt",50,"float")
  life0(50:85) = asciiread("life_mri2.txt",36,"float")

  ch4 = asciiread("ch4total370.txt",86,"float") ; emis

  x0 = 1822.5 ; ppb for 2014

  x1 = x0
  x3 = x0

  life = 1./(1/life0+1/150.)
  burden = ch4
  burden0 = ch4

  do i=0,85
   x2 = ( x1 * 2.75 * (1.-1/life(i)) + ch4(i) )/2.75 ; ppb fixed lifetime
   x4 = ( x3 * 2.75 * (1.-1/life(0)) + ch4(i) )/2.75
   x1 = x2
   x3 = x4
   burden(i) = x2
   burden0(i) = x4
  end do

  burden1 = new((/dimsizes(burden),3/),float)
  burden1(:,0) = burden
  burden1(:,1) = burden0
  burden1(:,2) = (burden-burden0)/burden0 * 100.

  opt = True
  opt@fout = "trend_mrinew.txt"
  write_matrix(burden1, "3f10.2", opt)

