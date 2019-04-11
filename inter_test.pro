pro inter_test

  Nlat1 =  500
  Nlon1 = 1000
  Nlat2 =  300
  Nlon2 =  400

  A1 = fltarr(Nlat1,Nlon1)
  for i=0,Nlat1-1 do $
  for j=0,Nlon1-1 do $
  A1(i,j) = exp(-0.5*(i-Nlat1/2.)*(j-Nlon1/2.)/Nlat2/Nlon2)
  
  inter,A1=A1,A2=A2,Nlat1=Nlat1,Nlon1=Nlon1,Nlat2=Nlat2,Nlon2=Nlon2,Lat1=Lat1,Lon1=Lon1,Lat2=Lat2,Lon2=Lon2

  loadct,39
  window,1,xs=Nlat1,ys=Nlon1
  tvscl,A1
  window,2,xs=Nlat2,ys=Nlon2
  tvscl,A2
  
  stop
  
  return
end
