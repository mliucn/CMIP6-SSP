

  data = asciiread("ch4anthro_ssp126.txt", 10, "float")

  emis = new(86,float)

  diff = (data(1)-data(0))/5.0  ; 2015-2020
  do i=0,5
   emis(i) = data(0) + diff * i
  end do

;  print(emis(0:5))

  diff = (data(2)-data(1))/10.0  ; 2020-2030
  do i=0,10
   emis(i+5) = data(1) + diff * i
  end do

  diff = (data(3)-data(2))/10.0  ; 2030-2040
  do i=0,10
   emis(i+15) = data(2) + diff * i
  end do

  diff = (data(4)-data(3))/10.0  ; 2040-2050
  do i=0,10
   emis(i+25) = data(3) + diff * i
  end do

  diff = (data(5)-data(4))/10.0  ; 2050-2060
  do i=0,10
   emis(i+35) = data(4) + diff * i
  end do

  diff = (data(6)-data(5))/10.0  ; 2060-2070
  do i=0,10
   emis(i+45) = data(5) + diff * i
  end do

  diff = (data(7)-data(6))/10.0  ; 2070-2080
  do i=0,10
   emis(i+55) = data(6) + diff * i
  end do

  diff = (data(8)-data(7))/10.0  ; 2080-2090
  do i=0,10
   emis(i+65) = data(7) + diff * i
  end do

  diff = (data(9)-data(8))/10.0  ; 2090-2100
  do i=0,10
   emis(i+75) = data(8) + diff * i
  end do

  emis = emis + 222.
  asciiwrite("ch4total126.txt", emis)

;;;;;;;;;;;;;;;;;;;;;;;;;;


  data = asciiread("ch4anthro_ssp370.txt", 10, "float")

  emis = new(86,float)

  diff = (data(1)-data(0))/5.0  ; 2015-2020
  do i=0,5
   emis(i) = data(0) + diff * i
  end do

;  print(emis(0:5))

  diff = (data(2)-data(1))/10.0  ; 2020-2030
  do i=0,10
   emis(i+5) = data(1) + diff * i
  end do

  diff = (data(3)-data(2))/10.0  ; 2030-2040
  do i=0,10
   emis(i+15) = data(2) + diff * i
  end do

  diff = (data(4)-data(3))/10.0  ; 2040-2050
  do i=0,10
   emis(i+25) = data(3) + diff * i
  end do

  diff = (data(5)-data(4))/10.0  ; 2050-2060
  do i=0,10
   emis(i+35) = data(4) + diff * i
  end do

  diff = (data(6)-data(5))/10.0  ; 2060-2070
  do i=0,10
   emis(i+45) = data(5) + diff * i
  end do

  diff = (data(7)-data(6))/10.0  ; 2070-2080
  do i=0,10
   emis(i+55) = data(6) + diff * i
  end do

  diff = (data(8)-data(7))/10.0  ; 2080-2090
  do i=0,10
   emis(i+65) = data(7) + diff * i
  end do

  diff = (data(9)-data(8))/10.0  ; 2090-2100
  do i=0,10
   emis(i+75) = data(8) + diff * i
  end do

  emis = emis + 222.
  asciiwrite("ch4total370.txt", emis)
