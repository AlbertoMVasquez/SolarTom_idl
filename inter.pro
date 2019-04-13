pro inter,A1=A1,A2=A2,Nlat1=Nlat1,Nlon1=Nlon1,Nlat2=Nlat2,Nlon2=Nlon2,Lat1=Lat1,Lon1=Lon1,Lat2=Lat2,Lon2=Lon2
;;
; 
; INPUTS:  A1: original 2D array given on Grid1.
;          Nlat1,Nlon1: Number of Lats and Lons of Grid1.
;          Nlat2,Nlon2: Number of Lats and Lons of Grid2.
;
; OUTPUTS: A2, bi-linear interpolation of A1 onto Grid2.
;          Lat1,Lon1,Lat2,Lon2.
;
; RESTRICTIONS: INPUT and OUTPUT grids are:
;               a) UNIFORM,
;               b) CELL-CENTERED,
;               and covering the range of Latitudes [-90,+ 90] deg,
;                        and the range of Longitudes[  0, 360] deg.
;               In A1: first index must be LAT, and second index must be LON.
;
; Author: Alberto M. Vasquez (albert@iafe.uba.ar) - April-11-2019.
;
;;
  
; Grid1:
  dlat1 = 180./Nlat1
  dlon1 = 360./Nlon1
   lat1 = -90. + dlat1/2. + dlat1*findgen(Nlat1)
   lon1 =   0. + dlon1/2. + dlon1*findgen(Nlon1)

; Grid2:
   dlat2 = 180./Nlat2
   dlon2 = 360./Nlon2
    lat2 = -90. + dlat2/2. + dlat2*findgen(Nlat2)
    lon2 =   0. + dlon2/2. + dlon2*findgen(Nlon2)

 ; Range spanned by Grid1:
    DX1 = (max(lat1)-min(lat1))
    DY1 = (max(lon1)-min(lon1))

; Arrays of "Virtual Suscripts" of BOTH GRIDS:

 iX1 = ( (lat1 - min(lat1)) / DX1 ) * (Nlat1-1) ; (This has to go from 0 to Nlat1-1)
 iY1 = ( (lon1 - min(lon1)) / DY1 ) * (Nlon1-1) ; (This has to go from 0 to Nlon1-1)

 iX2 = ( (lat2 - min(lat1)) / DX1 ) * (Nlat1-1) ; Virtual subscripts of Grid2-X on Grid1-X
 iY2 = ( (lon2 - min(lon1)) / DY1 ) * (Nlon1-1) ; Virtual subscripts of Grid2-Y on Grid1-Y

 IX = iX2
 JY = iY2

; Bilinear interpolarion of A1 onto Grid2:
 A2  = bilinear(A1,IX,JY)

  return
end
