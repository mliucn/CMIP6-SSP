

  ch4ukesm = asciiread("../ukesm/ch4_2015-2099_r1i1p1f2.txt",(/85/),"float")
  ukesm1 = dim_avg_n(ch4ukesm(0:4),0)   ; ch4 mass burden
  ukesm2 = dim_avg_n(ch4ukesm(55:59),0)

  ch4gfdl = asciiread("../gfdl/ch4_2015-2100_r1i1p1f1.txt",(/86/),"float")
  gfdl1 = dim_avg_n(ch4gfdl(0:4),0)
  gfdl2 = dim_avg_n(ch4gfdl(55:59),0)
  print(gfdl1)
  print(gfdl2)

  ch4mri = asciiread("../mri/ch4_r1i1p1f1_201501-202412.txt",(/10/),"float")
  mri1 = dim_avg_n(ch4mri(0:4),0)
  ch4mri = asciiread("../mri/ch4_r1i1p1f1_206501-207412.txt",(/10/),"float")
  mri2 = dim_avg_n(ch4mri(5:9),0)

  lossukesm = asciiread("life_ukesm.txt",(/2/),"float")  ; loss per year
  lossgfdl = asciiread("life_gfdl.txt",(/2/),"float")
  lossmri = asciiread("life_mri.txt",(/2/),"float")

  ccukesm = (ukesm2/lossukesm(1) - ukesm1/lossukesm(0))/(ukesm1/lossukesm(0))  ; lifetime changes

  ccgfdl = (gfdl2/lossgfdl(1) - gfdl1/lossgfdl(0))/(gfdl1/lossgfdl(0))

  ccmri = (mri2/lossmri(1) - mri1/lossmri(0))/(mri1/lossmri(0))

  print(ccukesm)
  print(ccgfdl)
  print(ccmri)
