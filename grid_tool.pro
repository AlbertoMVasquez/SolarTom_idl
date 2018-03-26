; Tool to create spherical interpolation grid tables
; for TECPLOT's SWMF tools.
; A.M.Vásquez, CLASP, Fall-2017.

pro grid_tool,WISPR=WISPR,DEMT=DEMT,UNIFCUSTOM=UNIFCUSTOM,output_dir=output_dir

if NOT keyword_set (output_dir) then output_dir = '/data1/tomography_dev/SolarTom_idl/DATA/'
  
; Set grid density key parameters:
if keyword_set(WISPR) then begin
  file = 'sphere_wedge_WISPR.dat'
  Nr   = 100
  dlon = 2.  ; deg
  dlat = 2.  ; deg
endif
if keyword_set(DEMT) then begin
  file = 'sphere_wedge_DEMT.dat'
  Rmin = 1.00 ; Rsun
  Rmax = 1.26 ; Rsun
  drad = 0.01;Rsun
  dlon = 2.  ; deg
  dlat = 2.  ; deg
endif
if keyword_set(UNIFCUSTOM) then begin
  file = 'sphere_wedge_custom_test.dat'
  Rmin =  2.0 ; Rsun
  Rmax = 12.0 ; Rsun
  drad = 0.05  ;Rsun
  dlon = 1.   ; deg
  dlat = 1.   ; deg
endif

if keyword_set(WISPR) then begin
; Array of Nr radial voxels' width
 rmin = 2.00 ; Rsun
drmin = 0.25 ; Rsun
drmax = 4.00 ; Rsun
    r = fltarr(Nr)
   dr = fltarr(Nr)
    m = (drmax-drmin)/(Nr-1)
for i = 0,Nr-1 do dr[i] = drmin + m * i
; Array of Nr radial voxels' center.
r[0] = rmin+dr[0]/2.
for i = 1,Nr-1 do r[i] = r[i-1] + dr[i-1]/2. + dr[i]/2.
endif

if keyword_set(DEMT) OR keyword_set(UNIFCUSTOM) then begin
; Array of Nr radial voxels' width
Nr   = (Rmax-Rmin)/drad
r    = Rmin + drad/2. + drad * findgen(Nr)
dr   = fltarr(Nr)
for i=0,Nr-1 do dr[i]=drad
endif

; Array of Nlon longitude voxels' center
Nlon = fix(360./dlon)
Lon  = dlon/2. + dlon * findgen(Nlon)

; Array of Nlat latitude  voxels' center
Nlat = fix(180./dlat) 
Lat  = -90. + dlat/2. + dlat * findgen(Nlat)

; Array of Spherical coordinates Theta and Phi
Phi    =      Lon  * !dtor ; rad
Theta  = (90.-Lat) * !dtor ; rad
Nphi   = Nlon
Ntheta = Nlat

; Create Table for TECPLOT's SWMF tools:
openw,1,output_dir+file
printf,1,'      X [Rsun]        Y [Rsun]        Z [Rsun]'
for ip=0,Nphi  -1 do begin
for it=0,Ntheta-1 do begin
for ir=0,Nr    -1 do begin         
  x = r[ir]*sin(theta[it])*cos(phi[ip]) 
  y = r[ir]*sin(theta[it])*sin(phi[ip])
  z = r[ir]*cos(theta[it]) 
  printf,1,format="(3(f16.8))",x,y,z
endfor
endfor
endfor
close,1

;-----------plot stuff-----------------------------
Nvoxels = float(Nlat)*float(Nlon)*float(Nr)
loadct,0
window,xs=2000,ys=1600
!p.multi=[0,1,2]
!p.charsize=4
plot,indgen(Nr)+1,r,xtitle='Index',ytitle='r [Rsun]'
plot,r,dr,xtitle='r [Rsun]',ytitle='dr [Rsun]'
!p.multi=0

print,'Nvoxels = ',Nvoxels

 openw,1,output_dir+'radial_grid_'+file
 printf,1,'Number of grid points:',fix(Nr)
 printf,1,'-----------------------------------'
 printf,1,'     Index       r           dr'
 printf,1,'-----------------------------------'
 for i=0,Nr-1 do printf,1,i,r(i),dr(i)
 printf,1,'-----------------------------------'
 close,1

 stop
END

