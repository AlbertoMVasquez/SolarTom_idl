pro readtom_sph,dir,file,nr,nt,rmin,rmax,map,doble=doble

np=2.*nt
map=fltarr(nr,nt,np)
if keyword_set(doble) then map=dblarr(nr,nt,np)
openr,1,dir+file
readu,1,map
close,1

return
end

pro showshell,map,ir,win,scalefactor,clrtbl,mini,maxi,pos,topv,sett=sett,interp=interp,log=log

; set graph stuff
device, retain     = 2
device, true_color = 24
device, decomposed = 0

if not keyword_set(pos) then pos=0

nr=fix((size(map))(1))
nt=fix((size(map))(2))
np=fix((size(map))(3))

if keyword_set(interp) then $
map2=rotate(rebin(reform(map(ir,*,*)),nt*scalefactor,np*scalefactor),4)

if NOT keyword_set(interp) then begin
tmin= -90.
tmax= +90.
pmin=   0.
pmax= 360.
t=tmin+(tmax-tmin)*findgen(nt)/float(nt-1)
p=pmin+(pmax-pmin)*findgen(np)/float(np-1)
map2d=reform(map(ir,*,*))
nt2=nt*scalefactor
np2=np*scalefactor
t2=tmin+(tmax-tmin)*findgen(nt2)/float(nt2-1)
p2=pmin+(pmax-pmin)*findgen(np2)/float(np2-1)
map2=fltarr(nt2,np2)
for ip2=0,np2-1 do begin
p0=p2(ip2)
fp=abs(p-p0)
ip=fix( (where(fp eq min(fp)))(0) )
for it2=0,nt2-1 do begin
t0=t2(it2)
ft=abs(t-t0)
it=fix( (where(ft eq min(ft)))(0) )
map2(it2,ip2)=map2d(it,ip)
endfor
endfor
map2=rotate(map2,4)
endif

;---threshold bottom and top---------------------
map2(0,0)=mini
map2(0,1)=maxi
map2=map2>mini<maxi
;------------------------------------------------

if keyword_set(log) then begin
   map2=alog10(map2)
   mini=min(map2)
   maxi=max(map2)
endif

if clrtbl lt 100 then loadct,clrtbl
if clrtbl gt 100 then secchi_colors, 'EUVI', clrtbl, R, G, B,/load

if win ne -1 then window,win,xs=np*scalefactor,ys=nt*scalefactor

if keyword_set(sett) eq 0 then tvscl,(map2),pos
if keyword_set(sett) ne 0 then tvscl,(map2),pos;,top=topv

if keyword_set(log) then begin
   mini=10.^mini
   maxi=10.^maxi
endif

return
end

pro writeshells,map,irs,outdir,label

for i=0,n_elements(irs)-1 do begin
ir=fix(irs(i))
if ir le 9 then rstring='0'+strmid(string(ir),7,1)
if ir gt 9 then rstring=    strmid(string(ir),6,2)
openw,1,outdir+label+'_shell_'+rstring+'.dat'
writeu,1,reform(map(ir,*,*))
close,1
endfor

return
end

pro readshell,dir,file,nt,np,scalefactor,win,shell,save=save

shell=fltarr(nt,np)
openr,1,dir+file
readu,1,shell
close,1

device, retain     = 2
device, true_color = 24
device, decomposed = 0
loadct,13   ; or whatever. 

window,win,xs=np*scalefactor,ys=nt*scalefactor
tvscl,rotate(rebin(shell,nt*scalefactor,np*scalefactor),4)

if keyword_set(save) then begin
image24 = TVRD(True=1)
image2d = Color_Quan(image24, 1, r, g, b)
write_GIF, dir+file+'.gif', image2d, r, g, b
endif

return
end

pro makegif,filename
 image24 = TVRD(True=1)
 image2d = Color_Quan(image24, 1, r, g, b)
  write_GIF,filename, image2d, r, g, b
return
end

pro latlon,map,ir,win,scalefactor,ilat0,ilon0,t,sett=sett,interp=interp
; set graph stuff
device, retain     = 2
device, true_color = 24
device, decomposed = 0

nr=fix((size(map))(1))
nt=fix((size(map))(2))
np=fix((size(map))(3))

if keyword_set(interp) then $
map2=rotate(rebin(reform(map(ir,*,*)),nt*scalefactor,np*scalefactor),4)

if NOT keyword_set(interp) then begin
tmin= -90.
tmax= +90.
pmin=   0.
pmax= 360.
t=tmin+(tmax-tmin)*findgen(nt)/float(nt-1)
p=pmin+(pmax-pmin)*findgen(np)/float(np-1)
map2d=reform(map(ir,*,*))
nt2=nt*scalefactor
np2=np*scalefactor
t2=tmin+(tmax-tmin)*findgen(nt2)/float(nt2-1)
p2=pmin+(pmax-pmin)*findgen(np2)/float(np2-1)
map2=fltarr(nt2,np2)
for ip2=0,np2-1 do begin
p0=p2(ip2)
fp=abs(p-p0)
ip=fix( (where(fp eq min(fp)))(0) )
for it2=0,nt2-1 do begin
t0=t2(it2)
ft=abs(t-t0)
it=fix( (where(ft eq min(ft)))(0) )
map2(it2,ip2)=map2d(it,ip)
endfor
endfor
map2=rotate(map2,4)
endif

goto,skipthis
nlon=(size(map2))(1)
nlat=(size(map2))(2)
lon=fltarr(nlon)
lat=fltarr(nlat)
lon=     360.*findgen(nlon)/float(nlon-1)
lat=-90.+180.*findgen(nlat)/float(nlat-1)
flon=abs(lon-lon0) & ilon=mean(where(flon eq min(flon)))
flat=abs(lat-lat0) & ilat=mean(where(flat eq min(flat)))
skipthis:

ilon=ilon0*scalefactor
ilat=ilat0*scalefactor
print,'ilon and ilat:',[ilon,ilat]/scalefactor

map2(ilon,*)=max(map2)
map2(*,ilat)=max(map2)

goto,skippadding
map2Size = SIZE(map2, /DIMENSIONS)
xp=20
yp=40
;TVLCT, R, G, B
maxcolor=!D.TABLE_SIZE - 1  
TVLCT, 0, 0, 0, maxColor
paddedmap2 = REPLICATE(BYTE(maxColor), map2Size[0] + xp, map2Size[1] + yp)  
paddedmap2 [10,10] = map2
WINDOW, win, XSIZE = map2Size[0] + xp, YSIZE = map2Size[1] + yp
skippadding:

;loadct,13
window,win,xs=np*scalefactor,ys=nt*scalefactor

if keyword_set(sett) eq 0 then begin
;print,keyword_set(sett)
tvscl,alog(map2>1)
endif

if keyword_set(sett) ne 0 then begin
;print,keyword_set(sett),t
tvscl,map2,top=t
endif

print,'FBE at selected voxel:',(rotate(rebin(reform(map(ir,*,*)),nt*scalefactor,np*scalefactor),4))(ilon,ilat)

return
end

;----------------------------------------------------------------------------------
pro rotate_and_scale,map,ir,scalefactor,map_2d_rot_scl,interp=interp

if (size(map))(0) eq 3 then begin
nr=fix((size(map))(1))
nt=fix((size(map))(2))
np=fix((size(map))(3))

if keyword_set(interp) then $
map_2d_rot_scl=rotate(rebin(reform(map(ir,*,*)),nt*scalefactor,np*scalefactor),4)

if NOT keyword_set(interp) then begin
tmin= -90.
tmax= +90.
pmin=   0.
pmax= 360.
t=tmin+(tmax-tmin)*findgen(nt)/float(nt-1)
p=pmin+(pmax-pmin)*findgen(np)/float(np-1)

map2d=reform(map(ir,*,*))

nt2=nt*scalefactor
np2=np*scalefactor
t2=tmin+(tmax-tmin)*findgen(nt2)/float(nt2-1)
p2=pmin+(pmax-pmin)*findgen(np2)/float(np2-1)
map2=fltarr(nt2,np2)
for ip2=0,np2-1 do begin
p0=p2(ip2)
fp=abs(p-p0)
ip=fix( (where(fp eq min(fp)))(0) )
for it2=0,nt2-1 do begin
t0=t2(it2)
ft=abs(t-t0)
it=fix( (where(ft eq min(ft)))(0) )
map2(it2,ip2)=map2d(it,ip)
endfor
endfor
map_2d_rot_scl=rotate(map2,4)
endif

endif


if (size(map))(0) eq 2 then begin
nt=fix((size(map))(1))
np=fix((size(map))(2))

if keyword_set(interp) then $
map_2d_rot_scl=rotate(rebin(reform(map),nt*scalefactor,np*scalefactor),4)

if NOT keyword_set(interp) then begin
tmin= -90.
tmax= +90.
pmin=   0.
pmax= 360.
t=tmin+(tmax-tmin)*findgen(nt)/float(nt-1)
p=pmin+(pmax-pmin)*findgen(np)/float(np-1)

map2d=map

nt2=nt*scalefactor
np2=np*scalefactor
t2=tmin+(tmax-tmin)*findgen(nt2)/float(nt2-1)
p2=pmin+(pmax-pmin)*findgen(np2)/float(np2-1)
map2=fltarr(nt2,np2)
for ip2=0,np2-1 do begin
p0=p2(ip2)
fp=abs(p-p0)
ip=fix( (where(fp eq min(fp)))(0) )
for it2=0,nt2-1 do begin
t0=t2(it2)
ft=abs(t-t0)
it=fix( (where(ft eq min(ft)))(0) )
map2(it2,ip2)=map2d(it,ip)
endfor
endfor
map_2d_rot_scl=rotate(map2,4)
endif
endif

return
end
;----------------------------------------------------------------------------------

pro mark_selection,map,ir,win,scalefactor,titulo,ilon1A,ilon2A,ilat1A,ilat2A,wave,ccc,mini,maxi,outmap2D,niveles,etiquetas,log=log,interp=interp,colorscl=colorscl

if (size(map))(0) eq 3 then begin
nr=fix((size(map))(1))
nt=fix((size(map))(2))
np=fix((size(map))(3))
tmp=reform(map(ir,*,*))
endif
if (size(map))(0) eq 2 then begin
tmp=rotate(map,-4)
nt=fix((size(tmp))(1))
np=fix((size(tmp))(2))
endif

if keyword_set(interp) then $
map_2d_rot_scl=rotate(rebin(tmp,nt*scalefactor,np*scalefactor),4)

IF NOT KEYWORD_SET(INTERP) THEN BEGIN
TMIN= -90.
TMAX= +90.
PMIN=   0.
PMAX= 360.
T=TMIN+(TMAX-TMIN)*FINDGEN(NT)/FLOAT(NT-1)
P=PMIN+(PMAX-PMIN)*FINDGEN(NP)/FLOAT(NP-1)

map2d=tmp

nt2=nt*scalefactor
np2=np*scalefactor
t2=tmin+(tmax-tmin)*findgen(nt2)/float(nt2-1)
p2=pmin+(pmax-pmin)*findgen(np2)/float(np2-1)
map2=fltarr(nt2,np2)
for ip2=0,np2-1 do begin
p0=p2(ip2)
fp=abs(p-p0)
ip=fix( (where(fp eq min(fp)))(0) )
for it2=0,nt2-1 do begin
t0=t2(it2)
ft=abs(t-t0)
it=fix( (where(ft eq min(ft)))(0) )
map2(it2,ip2)=map2d(it,ip)
endfor
endfor
map_2d_rot_scl=rotate(map2,4)
endif

ilon1A=ilon1A*scalefactor
ilon2A=ilon2A*scalefactor
ilat1A=ilat1A*scalefactor
ilat2A=ilat2A*scalefactor

nsel=n_elements(ilon1A)

outmap2d=map_2d_rot_scl
map2    =map_2d_rot_scl

goto,skipselection
for i=0,nsel-1 do begin
map2(ilon1A(i)-1:ilon2A(i)+1,ilat1A(i)-1:ilat1A(i))=min(map2)
map2(ilon1A(i)-1:ilon2A(i)+1,ilat2A(i):ilat2A(i)+1)=min(map2)
map2(ilon1A(i)-1:ilon1A(i)  ,ilat1A(i)-1:ilat2A(i)+1)=min(map2)
map2(ilon2A(i):ilon2A(i)+1  ,ilat1A(i)-1:ilat2A(i)+1)=min(map2)
endfor
skipselection:

map2(0,0)=mini
map2(0,1)=maxi
map2=map2>mini<maxi
if keyword_set(log) then map2=alog10(map2)

DX=100
DY=100
X0=DX*5./6.
Y0=DY*3./4.
DY=DY+40

DXclscl=100

; set graph stuff
device, retain     =  2
device, true_color = 24
device, decomposed =  0

window,win,xs=np*scalefactor+DX+DXclscl,ys=nt*scalefactor+DY

loadct,27
tvscl,fltarr(np*scalefactor+DX+DXclscl,nt*scalefactor+DY);+1.e10

if wave gt 100 then eit_colors,wave
;SECCHI_COLORS, 'EUVI', wave, R, G, B,/load

if wave lt 100 then loadct,wave;,bottom=botval

tvscl,map2,X0,Y0

nlon=np*scalefactor
nlat=nt*scalefactor

LAT=TMIN+(TMAX-TMIN)*FINDGEN(Nlat)/FLOAT(Nlat-1)
LON=PMIN+(PMAX-PMIN)*FINDGEN(Nlon)/FLOAT(Nlon-1)

loadct,ccc
contour,map2,lon,lat,pos=[X0,Y0,X0+nlon,Y0+nlat],/noerase,/nodata,$
        /device,color=255,xstyle=1,ystyle=1,charsize=2.,$
        xtitle='Carrington Longitude',$
        ytitle='Latitude',$
        title=titulo,$
        yticklen=.02,xticklen=.03,ythick=2,xthick=2,charthick=2

if keyword_set(colorscl) then begin

 x0    =  x0+np*scalefactor+DXclscl*2./3.
 ancho =  25
 alto  =  nt*scalefactor

; nv = n_elements(etiquetas)
 rampa = fltarr(ancho,alto)
 dmin=min(map2)
 dmax=max(map2)
; if dmin lt 0. then dmin=1.
; rampa=rampa>dmin

 for i=0,alto-1 do rampa(*,i)=fltarr(ancho)+dmin+(dmax-dmin)*float(i)/float(alto-1)
; rampa(*,0)=0.
; rampa(*,alto-1)=0.

 if wave lt 100 then loadct,wave
;if wave gt 100 then SECCHI_COLORS, 'EUVI', wave, R, G, B,/load
 if wave gt 100 then eit_colors,wave

;tv,rampa*255./dmax,x0,y0,/device;,top=255.
;tv,rampa*255./dmax,x0,y0,/device;,top=255.
 tvscl,alog10(rampa),x0,y0,/device
 factor=1
 loadct,ccc
 !p.thick=2
 nv=n_elements(etiquetas)+1

;rampa=alog(rampa)
;niveles=alog(niveles)
contour,rampa,findgen(ancho),rampa(0,*),xstyle=5,/noerase,charsize=2.,charthick=2,$;levels=rampa_v,$;,c_labels=fltarr(nv),$
              pos=[x0,y0,x0+ancho,y0+alto],/dev,ystyle=1,levels=niveles;,ytickname=etiquetas;,closed=1;,$
;             yticks=nv-1,ytickv=niveles,ytickname=etiquetas,c_labels=fltarr(nv)

;if wave eq 171 then stop
goto,skip
ColorBar, NColors=12, Bottom=3, Divisions=6, $
   Range=[Min(map), Max(map)], Format='(I4)', $
   Position = [0.1, 0.9, 0.9, 0.95], Color=black

skip:
endif

ilon1A=ilon1A/scalefactor
ilon2A=ilon2A/scalefactor
ilat1A=ilat1A/scalefactor
ilat2A=ilat2A/scalefactor

return
end

pro extrapol,map,rmin,rmax

nr=fix((size(map))(1))
nt=fix((size(map))(2))
np=fix((size(map))(3))

r=rmin+(rmax-rmin)*findgen(nr)/float(nr-1)
h=r-1.

newr=[1.,1.055,r]
nrr =nr+2
newh=r-1.

newmap=fltarr(nr+2,nt,np)
newmap(2:nrr-1,*,*)=map
te6=fltarr(nt,np)

map8=map/1.e8
y=alog(map8>1.e-10)

i1=1
i2=2
h1=h(i1)
h2=h(i2)

for it=0,nt-1 do begin
for ip=0,np-1 do begin
y1=y(i1,it,ip)
y2=y(i2,it,ip)
map1=map(i1,it,ip)
map2=map(i2,it,ip)
if map1 eq 0. OR map2 eq 0. then goto,next
Te6_v=(-1./6.66e-2)*(h2-h1)/(y2-y1)
y0=y1+h1/(6.66e-2*Te6_v)
yy=y0-newh(1)/(6.66e-2*Te6_v)
Te6(it,ip)=Te6_v
newmap(0,it,ip)=1.e8*exp(y0)
newmap(1,it,ip)=1.e8*exp(yy)
next:
endfor
endfor


stop
return
end

pro avgprofile,map,ilat1,ilat2,ilon1,ilon2,r,avgprof

nr=fix((size(map))(1))
nt=fix((size(map))(2))
np=fix((size(map))(3))

avgprof=fltarr(nr)
for ir=0,nr-1 do begin
map2d=reform(map(ir,*,*))
p=where(map2d gt 0.)
avgprof(ir)=mean(map2d(p))
endfor

dr=(2.85-1.1)/nr
r=1.+dr/2.+dr*findgen(nr)
return
end

pro N,r,A,F,Pder
F = A[0] * exp(-(r-1.)/A[1]) 
;If the procedure is called with four parameters, calculate the 
;partial derivatives. 
  IF N_PARAMS() GE 4 THEN $ 
    pder = [[exp(-(r-1.)/A[1])], [A[0] * exp(-(r-1.)/A[1]) * ((r-1.) / A[1]^2)]] 
return
end

pro fitexp,x,y,yfit,A
n=n_elements(x)
A1=(x(0)-x(n-1))/(alog(y(n-1))-alog(y(0)))
A0=y(0)/exp(-(x(0)-1.)/A1)
A=[A0,A1]
weights = 1.0/Y
yfit = CURVEFIT(X, Y, weights, A, SIGMA, FUNCTION_NAME='N')
return
end

pro record_gif,dir,filename
; set graph stuff
device, retain     = 2
device, true_color = 24
device, decomposed = 0
image24 = TVRD(True=1)
image2d = Color_Quan(image24, 1, r, g, b)
write_GIF, dir+filename, image2d, r, g, b
return
end

pro longslice,map3d,rcutmin,wn,ilong,ny,image,wave,threshold,topv,outmap2D,lat0,epslat,rad0,epsrad,marklat=marklat,markrad=markrad

nr=fix((size(map3d))(1))
nt=fix((size(map3d))(2))

slice=reform(map3d(*,*,ilong))
;slice=rebin(slice,nr*factor,nt*factor)
;nr=nr*factor
;nt=nt*factor

;rcutmin=1.025
rcutmax=1.250

rmin=1.00
rmax=1.26
dr  =(rmax-rmin)/float(nr)
r   =rmin+dr/2.+dr*findgen(nr)

tmin=-90.
tmax=+90.
dt  =(tmax-tmin)/float(nt)
t   =tmin+dt/2.+dt*findgen(nt)

nz=2*ny
image   =fltarr(ny,nz)
outmap2D=fltarr(ny,nz)

ymax=rmax
ymin=0.
dy=(ymax-ymin)/float(ny)
y=ymin+dy*findgen(ny)

zmax=+rmax
zmin=-rmax
dz=(zmax-zmin)/float(nz)
z=zmin+dz*findgen(nz)

for iy=0,ny-1 do begin
y0=y(iy)
for iz=0,nz-1 do begin
z0=z(iz)
r0=sqrt(y0^2+z0^2)
if abs(r0-1.) le epsrad then begin
    image(iy,iz)=max(slice)
;outmap2D(iy,iz)=max(slice)
endif
if r0 lt rcutmin or r0 gt rcutmax then goto,next
t0=(180./!pi)*atan(z0/y0)
flag=0
if keyword_set(marklat) ne 0 then begin
if abs(t0-lat0) le epslat then begin
 image(iy,iz)=min(slice)
 flag=1
endif
endif
if keyword_set(markrad) ne 0 then begin
if abs(r0-rad0) le epsrad then begin
image(iy,iz)=min(slice)
flag=1
endif
endif
fr=abs(r-r0)
ir=fix((where(fr eq min(fr)))(0))
ft=abs(t-t0)
it=fix((where(ft eq min(ft)))(0))
outmap2D(iy,iz)=slice(ir,it)
if flag eq 1 then goto,next
image(iy,iz)=slice(ir,it)
next:
endfor
endfor

if wave gt 100 then $
SECCHI_COLORS, 'EUVI', wave, R, G, B,/load

if wave lt 100 then loadct,wave

window,wn,xs=ny,ys=nz
;tvscl,alog10(image>threshold),top=topv
tvscl,image>threshold,top=topv
return
end

pro crop,map2d,wn,band,threshold,topv,y1_Rs,y2_Rs,z1_Rs,z2_Rs,niy,niz,cropmap,rr,tt,mp=mp,loga=loga,colorbar=colorbar

 ny=(size(map2d))(1)
 nz=2*ny
 rmax=1.26

 ymax=rmax
 ymin=0.
 dy=(ymax-ymin)/float(ny)
 y=ymin+dy*findgen(ny)

 zmax=+rmax
 zmin=-rmax
 dz=(zmax-zmin)/float(nz)
 z=zmin+dz*findgen(nz)

 fy1=abs(y-y1_Rs)
 iy1=(where(fy1 eq min(fy1)))
 fy2=abs(y-y2_Rs)
 iy2=(where(fy2 eq min(fy2)))
 fz1=abs(z-z1_Rs)
 iz1=(where(fz1 eq min(fz1)))
 fz2=abs(z-z2_Rs)
 iz2=(where(fz2 eq min(fz2)))

 cropmap=reform(map2d(iy1:iy2,iz1:iz2))
 cropmap=congrid(cropmap,niy,niz)

 y=y1_Rs+(y2_Rs-y1_Rs)*findgen(niy)/float(niy-1)
 z=z1_Rs+(z2_Rs-z1_Rs)*findgen(niz)/float(niz-1)
 for iy=0,niy-1 do $
 for iz=0,niz-1 do $
 if abs(sqrt(y(iy)^2+z(iz)^2)-1.) le 0.002 then cropmap(iy,iz)=max(cropmap)


 if keyword_set(mp) then markpoints,cropmap,y1_Rs,y2_Rs,z1_Rs,z2_Rs,rr,tt,yla,zla

 Dy=0
 if keyword_set(colorbar) then Dy=70

 window,wn,xs=niy+Dy,ys=niz
 loadct,27
 tvscl,fltarr(niy+Dy,niz)

 if band gt 100 then $
 SECCHI_COLORS, 'EUVI', band, R, G, B,/load

 if band lt 100 then loadct,band

 displayimage=cropmap
 displayimage(199,*)=0
 displayimage(  0,*)=0
 displayimage(0:199,  0)=0
 displayimage(0:199,259)=0

; if keyword_set(loga) then $
; tvscl,alog10(displayimage>threshold),top=topv

 if not keyword_set(loga) then $
 tvscl,      (displayimage>threshold),top=topv

 if n_elements(rr) eq 6 then LABELS=['N1','C1','S1','N2','C2','S2']  
 if n_elements(rr) eq 9 then LABELS=['N1','C1','S1','N2','C2','S2','N3','C3','S3']  
 if n_elements(rr) eq 3 then LABELS=['N','C','S']  

 if keyword_set(colorbar) then YLA=YLA*float(niy)/float(niy+Dy)
 xyouts,YLA,ZLA-.05,LABELS,/NORMAL,charsize=2,charthick=2

if keyword_set(colorbar) then begin
 Dz    =  20
 ancho =  20
 alto  =  niz-Dz
 rampa = fltarr(ancho,alto)
 dmin=min(cropmap)
 dmax=max(cropmap)
 for i=0,alto-1 do rampa(*,i)=fltarr(ancho)+dmin+(dmax-dmin)*float(i)/float(alto-1)

 z0 = Dz/2.
 y0 = niY+Dy*2./3.
 tvscl,rampa,y0,z0,/device

 loadct,40
 contour,rampa,findgen(ancho),rampa(0,*),xstyle=5,/noerase,charsize=2.,charthick=2,ythick=2,xthick=2,$
              pos=[y0-1,z0,y0+ancho-1,z0+alto-1],/dev,ystyle=1,levels=niveles,closed=1,yticklen=.2,c_thick=2

endif 

return
end

pro markpoints,cropmap,y1_Rs,y2_Rs,z1_Rs,z2_Rs,rr,tt,yla,zla

ny=fix((size(cropmap))(1))
nz=fix((size(cropmap))(2))

y=y1_Rs+(y2_Rs-y1_Rs)*findgen(ny)/float(ny-1)
z=z1_Rs+(z2_Rs-z1_Rs)*findgen(nz)/float(nz-1)

ra=fltarr(ny,nz)
ta=fltarr(ny,nz)
for iy=0,ny-1 do begin
for iz=0,nz-1 do begin
ra(iy,iz)=sqrt(y(iy)^2+z(iz)^2)
ta(iy,iz)=atan(z(iy)/y(iy))*180./!pi
endfor
endfor

colat=90.+tt
yy= rr*sin(colat*!pi/180.)
zz=-rr*cos(colat*!pi/180.)

npoints=n_elements(rr)

yla=fltarr(npoints)
zla=fltarr(npoints)

dp=3
for i=0,npoints-1 do begin
 fy=abs(y-yy(i))
 iy=where(fy eq min(fy))
 fz=abs(z-zz(i))
 iz=where(fz eq min(fz))
 cropmap(iy-dp:iy+dp,iz-dp:iz+dp)=max(cropmap)
 yla(i)=float(iy-5)/float(ny)
 zla(i)=float(iz-15)/float(nz)
 yla(i)=float(iy-7)/float(ny)
 zla(i)=float(iz-15)/float(nz)
endfor

return
end

pro averagefbe,fbe1,fbe2,nr,nt,rmin,rmax,outfile
dir='/data1/tomography/bindata/'
readtom_sph,dir,fbe1,nr,nt,rmin,rmax,x1
readtom_sph,dir,fbe2,nr,nt,rmin,rmax,x2

pboth=where(x1 gt 0. AND x2 gt 0.)
p1   =where(x1 gt 0. AND x2 le 0.)
p2   =where(x1 le 0. AND x2 gt 0.)
pnone=where(x1 le 0. AND x2 le 0.)

avgfbe=fltarr(nr,nt,2*nt)

goto,skipcomplex
if pboth(0) ne -1 then avgfbe(pboth)=0.5*((x1+x2)(pboth))
if    p1(0) ne -1 then avgfbe(p1   )=x2(p1)
if    p2(0) ne -1 then avgfbe(p2   )=x1(p2)
if pnone(0) ne -1 then avgfbe(pnone)=0.5*((x1+x2)(pnone))
skipcomplex:

avgfbe=0.5*(x1+x2)

openw,1,dir+outfile
writeu,1,avgfbe
close,1

return
end

