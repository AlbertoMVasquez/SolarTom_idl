pro comp,factor=factor,img_num=img_num,r0=r0;,suffix=suffix
  
  common data,img_lascoc2,img_kcor,pa_lascoc2,pa_kcor,ra_lascoc2,ra_kcor,hdr_lascoc2,hdr_kcor,x_lascoc2,y_lascoc2,x_kcor,y_kcor
  if not keyword_set(factor)  then factor  = 1.e3
  if not keyword_set(img_num) then img_num = 0
  
  dir='/data1/tomography_dev/DATA/c2/CR2198/'
  files=['23690612pB.fts','23690730pB.fts','23690852pB.fts','23690978pB.fts']
  mreadfits,dir+files[img_num],hdr_lascoc2,img_lascoc2

  dir='/data1/tomography_dev/DATA/kcor/CR2198/'
  files=['20171203_174720_kcor_l1.fts','20171204_175906_kcor_l1.fts','20171205_175217_kcor_l1.fts','20171206_211550_kcor_l1.fts']
  mreadfits,dir+files[img_num],hdr_kcor,img_kcor

  suffix = strmid(hdr_kcor.DATE_D$OBS,0,10)

  print,'LASCO-C2 OBS TIME: ',hdr_lascoc2.date_obs,hdr_lascoc2.time_obs
  print,'KCOR     OBS TIME: ',hdr_kcor   .date_obs

  rotate_image,hdr_lascoc2,img_lascoc2, instrument = 'lascoc2'
  rotate_image,hdr_kcor   ,img_kcor,    instrument = 'kcor'
  
  computegrid,hdr_lascoc2,ra_lascoc2,pa_lascoc2,x_lascoc2,y_lascoc2,instrument='lascoc2'
  computegrid,hdr_kcor   ,ra_kcor   ,pa_kcor   ,x_kcor   ,y_kcor   ,instrument='kcor'
stop


display_radial_profiles_interp,t0=!pi/2., factor=1000,/alog

stop
  ps1,'/data1/tomography/SolarTom_idl/Pictures/latitudinal_profiles_'+suffix+'.eps',0
  !p.charsize=1
  loadct,0
  display_latitudinal_profiles,factor=factor,r0=r0
  ps2
  stop
; Display both images in same size, multiplying KCOR by factor,
; and sharing same color-scale.
  window,0,xs=2048,ys=1024
  img1=img_lascoc2
  img2=img_kcor*factor

  mini = 1.
  maxi = max([max(img1),max(img2)])

; Make zero r<2.3 for img1 (LASCO_c2)
  Rmin_LASCOC2 = 2.3
  p=where(ra_lascoc2 le Rmin_LASCOC2)
  img1(p)=0.

; Draw white circles of width dr at several radii, in both images
; and make latitudinal profiles.
  dr = 0.005
  Nradii = 4
  Rmin   = 2.3
  Step_r = 0.2
  radii = Rmin + Step_r * findgen(Nradii)
  for ir = 0,Nradii-1 do begin
     radius = radii[ir]
     p=where(ra_lascoc2 ge radius*(1.-dr/2.) and ra_lascoc2 le radius*(1.+dr/2.))
     img1(p) = maxi
     p=where(ra_kcor    ge radius*(1.-dr/2.) and ra_kcor    le radius*(1.+dr/2.))
     img2(p) = maxi
     ps1,'/data1/tomography/SolarTom_idl/Pictures/latitudinal_profiles_'+suffix+'_'+strmid(string(radius),6,3)+'.eps',0
     !p.charsize=1
     loadct,0
     display_latitudinal_profiles,factor=factor,r0=radius
     ps2
  endfor
  loadct,39
stop
; Force both images to have same MINI and MAXI
  img1([0,1]) = [mini,maxi]
  img2([0,1]) = [mini,maxi]
  img1 = img1 > mini < maxi
  img2 = img2 > mini < maxi
  tvscl,alog10(congrid(img1,1024,1024) > mini),0
  tvscl,alog10(        img2            > mini),1

  record_gif,'/data1/tomography/SolarTom_idl/Pictures/','images_'+suffix+'.gif','X'
 stop 
goto,skip_for_diego
; Display ra and pa arrays (for Diego)
  window,1,xs=1024,ys=512
  tvscl,ra_lascoc2,0
  tvscl,pa_lascoc2,1
  window,2,xs=1024,ys=512
  tvscl,congrid(ra_kcor,512,512),0
  tvscl,congrid(pa_kcor,512,512),1
skip_for_diego:
  
; Display radial profiles at PA = pa0 \pm Delta_pa,
; multiplying KCOR data by factor:

  display_radial_profiles,pa0=270,Delta_pa=0.5,factor=factor

  
return
end

pro computegrid,hdr,ra,pa,x,y,instrument=instrument

if instrument eq 'kcor' then begin
 Rs=hdr.rsun              ; Sun radius in arcsec
 px=hdr.cdelt1            ; Pixel size in arcsec                     
 Rs=Rs/px                 ; Sun radius in pixels
 px=1./Rs                 ; Pixel size in Rsun units
 ix0=hdr.crpix1-1         ; Disk center x-pixel, changed to IDL convention (FITS convention starts with index=1, IDL starts with index=0). 
 iy0=hdr.crpix2-1         ; Disk center y-pixel, changed to IDL convention
endif

if instrument eq 'lascoc2' then begin
 Rs=hdr.rsun_pix          ; Sun radius in pixels
 px=1./Rs                 ; Pixel size in Rsun units
 ix0=hdr.xsun-1           ; Disk center x-pixel, changed to IDL convention
 iy0=hdr.ysun-1           ; Disk center y-pixel, changed to IDL convention
endif

 x  = px*(findgen(hdr.naxis1) - ix0)
 y  = px*(findgen(hdr.naxis1) - iy0)
 u  = 1. + fltarr(hdr.naxis1)
 xa = x#u
 ya = u#y
 ra = sqrt(xa^2 + ya^2)

 ta = fltarr(hdr.naxis1,hdr.naxis1)

 p=where(xa gt 0.)
 ta(p) = Acos( ya(p) / ra(p) )
 p=where(xa lt 0.)
 ta(p) = 2.*!pi-Acos( ya(p) / ra(p) )
 p=where(xa eq 0. AND ya gt 0.)
 if p(0) ne -1 then ta(p)=0.
 p=where(xa eq 0. AND ya lt 0.)
 if p(0) ne -1 then ta(p)=!pi
 ta=2.*!pi-ta
 PA=ta/!dtor

return
end

pro rotate_image,hdr,image,instrument=instrument

EPS        = +1.e-08
hugenegnum = -1.e+10
  
if instrument eq 'kcor' then begin
 ix0=hdr.crpix1-1         ; Disk center x-pixel, changed to IDL convention (FITS convention starts with index=1, IDL starts with index=0). 
 iy0=hdr.crpix2-1         ; Disk center y-pixel, changed to IDL convention
 ANGLE = hdr.inst_rot
endif

if instrument eq 'lascoc2' then begin
 ix0=hdr.xsun-1           ; Disk center x-pixel, changed to IDL convention
 iy0=hdr.ysun-1           ; Disk center y-pixel, changed to IDL convention
 ANGLE = hdr.rollangl
endif
       
if abs(ANGLE) gt EPS then begin
 rimage=rot(image,ANGLE,1,ix0,iy0,/pivot,missing=hugenegnum);rota y magnifica imagen
 image = rimage
endif

return
end

pro display_radial_profiles,pa0=pa0,factor=factor,Delta_pa=Delta_pa
  common data,img_lascoc2,img_kcor,pa_lascoc2,pa_kcor,ra_lascoc2,ra_kcor,hdr_lascoc2,hdr_kcor,x_lascoc2,y_lascoc2,x_kcor,y_kcor
  if not keyword_set(pa0     ) then pa0      = 270.0 ; deg
  if not keyword_set(Delta_pa) then Delta_pa =   0.5 ; deg
  if not keyword_set(factor  ) then factor   =   1.0

  Rmin_lascoc2 = 2.3  ; Rsun
  Rmax_lascoc2 = 6.1  ; Rsun
  Rmin_kcor    = 1.05 ; Rsun
  Rmax_kcor    = 3.0  ; Rsun
  
  i_lascoc2 = where(pa_lascoc2 ge pa0-Delta_pa and pa_lascoc2 le pa0+Delta_pa and $
                    ra_lascoc2 ge Rmin_lascoc2 and ra_lascoc2 le Rmax_lascoc2 )

  f = 1.
  i_kcor     = where(pa_kcor   ge pa0-Delta_pa/f and pa_kcor    le pa0+Delta_pa/f and $
                     ra_kcor   ge Rmin_kcor      and ra_kcor    le Rmax_kcor      )

  loadct,0
  window,3
  !p.charsize=1
  !p.symsize=3
    plot,ra_lascoc2(i_lascoc2),       img_lascoc2(i_lascoc2),psym=4,$
         xtitle='r [R!DSUN!N]',ytitle='pB [x10!U-10!N BSUN]',$
         title='Diamonds: LASCO-C2, Triangles: KCOR x'+string(factor)
   oplot,ra_kcor   (i_kcor   ),factor*img_kcor   (i_kcor   ),psym=5
stop
return
end

pro display_radial_profiles_interp,t0=t0,factor=factor,alog=alog
  common data,img_lascoc2,img_kcor,pa_lascoc2,pa_kcor,ra_lascoc2,ra_kcor,hdr_lascoc2,hdr_kcor,x_lascoc2,y_lascoc2,x_kcor,y_kcor
  if not keyword_set(factor  ) then factor   =   1.0
  
  if not keyword_set(t0) then begin
     print,'please specify the angle'
     stop
  endif

  Nt=180
;  t0=!pi/2.
  Rmin_lascoc2 = 2.3  
  Rmax_lascoc2 = 6.1  
  Rmin_kcor    = 1.05 
  Rmax_kcor    = 3.0 
  
  r0_kcor    = (Rmax_kcor - Rmin_kcor)      *findgen(Nt+1)/float(Nt) +Rmin_kcor
  r0_lascoc2 = (Rmax_lascoc2 - Rmin_lascoc2)*findgen(Nt+1)/float(Nt) +Rmin_lascoc2
  da_c2    = fltarr(Nt)
  da_kcor  = fltarr(Nt)
  
  for it=0,Nt-1 do begin
     r0=r0_kcor(it)
     da_kcor(it) = findval(img_kcor   , x_kcor   ,  y_kcor   , r0, t0)
  endfor
  
  for it=0,Nt-1 do begin
     r0=r0_lascoc2(it)
     da_c2  (it) = findval(img_lascoc2, x_lascoc2,  y_lascoc2, r0, t0)
  endfor
   
  radd = (Rmax_lascoc2 - Rmin_kcor)*findgen(Nt+1)/float(Nt) + Rmin_kcor
  datitos = findgen(Nt+1)/float(Nt)
  datitos(4) = max(da_kcor*factor)
  datitos(5) = max(da_c2)

if not keyword_set(alog) then begin
  plot,radd,datitos  ,xstyle=1,/nodata,$
       xtitle = 'rad [Rsun]',ytitle='pB [10!U-10!N B!DSUN!N]',$
       title  = 'LASCO-C2 (solid) and KCOR (dashed) at '+strmid(string(t0/!dtor),6,4)+' radians'
  oplot,r0_kcor,da_kcor*factor,linestyle=3
  oplot,r0_lascoc2,da_c2,linestyle=4
  
endif

if keyword_set(alog) then begin
  plot,radd,alog(datitos)  ,xstyle=1,/nodata,$
       xtitle = 'rad [Rsun]',ytitle='log( pB [10!U-10!N B!DSUN!N] )',$
       title  = 'LASCO-C2 (solid) and KCOR (dashed) at '+strmid(string(t0/!dtor),6,4)+' radians'
  oplot,r0_kcor,alog(da_kcor*factor),linestyle=3
  oplot,r0_lascoc2,alog(da_c2),linestyle=4

endif
  return
end


pro display_equatorial_polar_profiles,factor=factor
  common data,img_lascoc2,img_kcor,pa_lascoc2,pa_kcor,ra_lascoc2,ra_kcor,hdr_lascoc2,hdr_kcor,x_lascoc2,y_lascoc2,x_kcor,y_kcor

 ;window,2,xs=2400,ys=1650
  !p.multi=[0,2,2]
  !p.charsize=1

  mini = 1.e-1
  maxi = 1.e+3
  
   plot,ra_lascoc2(0:hdr_lascoc2.naxis1/2-1,hdr_lascoc2.ysun-1),img_lascoc2(0:hdr_lascoc2.naxis1/2-1,hdr_lascoc2.ysun-1)>.1,/ylog,xstyle=1,$
         title='East Equatorial profiles',$
        xtitle='r [R!DSUN!N]',ytitle='pB [x 10!U-10!N B!DSUN!N]',yr=[mini,maxi],ystyle=1
  oplot,ra_kcor(0:hdr_kcor.naxis1/2-1,hdr_kcor.crpix2 -1),img_kcor(0:hdr_kcor.naxis1/2-1,hdr_kcor.crpix2 -1)*factor,psym=3

     plot,ra_lascoc2(hdr_lascoc2.naxis1/2:hdr_lascoc2.naxis1-1,hdr_lascoc2.ysun-1),img_lascoc2(hdr_lascoc2.naxis1/2:hdr_lascoc2.naxis1-1,hdr_lascoc2.ysun-1)>.1,/ylog,xstyle=1,$
          title='West Equatorial profiles',$
         xtitle='r [R!DSUN!N]',ytitle='pB [x 10!U-10!N B!DSUN!N]',yr=[mini,maxi],ystyle=1
  oplot,ra_kcor(hdr_kcor.naxis1/2:hdr_kcor.naxis1-1,hdr_kcor.crpix2-1),img_kcor(hdr_kcor.naxis1/2:hdr_kcor.naxis1-1,hdr_kcor.crpix2-1)*factor,psym=3

   plot,ra_lascoc2(hdr_lascoc2.xsun-1,hdr_lascoc2.naxis2/2:hdr_lascoc2.naxis2-1),img_lascoc2(hdr_lascoc2.xsun-1,hdr_lascoc2.naxis2/2:hdr_lascoc2.naxis2-1)>.1,/ylog,xstyle=1,$
         title='North Polar profiles',$
        xtitle='r [R!DSUN!N]',ytitle='pB [x 10!U-10!N B!DSUN!N]',yr=[mini,maxi],ystyle=1
  oplot,ra_kcor(hdr_kcor.crpix1-1,hdr_kcor.naxis2/2:hdr_kcor.naxis2-1),img_kcor(hdr_kcor.crpix1-1,hdr_kcor.naxis2/2:hdr_kcor.naxis2-1)*factor ,psym=3

     plot,ra_lascoc2(hdr_lascoc2.xsun-1,0:hdr_lascoc2.naxis2/2-1),img_lascoc2(hdr_lascoc2.xsun-1,0:hdr_lascoc2.naxis2/2-1)>.1,/ylog,xstyle=1,$
         title='South Polar profiles',$
        xtitle='r [R!DSUN!N]',ytitle='pB [x 10!U-10!N B!DSUN!N]',yr=[mini,maxi],ystyle=1
  oplot,ra_kcor(hdr_kcor.crpix1 -1,0:hdr_kcor.naxis2/2-1),img_kcor(hdr_kcor.crpix1 -1,0:hdr_kcor.naxis2/2-1)*factor,psym=3

  !p.multi=0

  return
end

function findval, ima ,ya ,za , r0, t0
y0=-r0*sin(t0)
z0= r0*cos(t0)
iyA=max(where(ya le y0))
izA=max(where(za le z0))
Df=0.
if iyA eq -1 or izA eq -1 then goto,fin
iyB=iyA+1
izB=izA+1
if iyA eq n_elements(ya)-1 then iyB=iyA
if izA eq n_elements(za)-1 then izB=izA
D1=ima(iyA,izA) 
D2=ima(iyB,izA) 
D4=ima(iyA,izB) 
D5=ima(iyB,izB)
if iyA lt iyB AND izA lt izB then begin
 D3=D1+(D2-D1)*(y0-yA(iyA))/(yA(iyB)-yA(iyA))
 D6=D4+(D5-D4)*(y0-yA(iyA))/(yA(iyB)-yA(iyA))
 Df=D3+(D6-D3)*(z0-zA(izA))/(zA(izB)-zA(izA))
endif
if iyA lt iyB AND izA eq izB then Df=D1+(D2-D1)*(y0-yA(iyA))/(yA(iyB)-yA(iyA))
if iyA eq iyB AND izA lt izB then Df=D1+(D4-D1)*(z0-zA(izA))/(zA(izB)-zA(izA))
if iyA eq iyB AND izA eq izB then Df=D1
;stop
fin:
return,Df
end

pro display_latitudinal_profiles,r0=r0,factor=factor
common data,img_lascoc2,img_kcor,pa_lascoc2,pa_kcor,ra_lascoc2,ra_kcor,hdr_lascoc2,hdr_kcor,x_lascoc2,y_lascoc2,x_kcor,y_kcor

if not keyword_set(r0) then begin
   print,'please specify r0.'
   stop
endif

Nt=180
t0a = 2.*!pi*findgen(Nt)/float(Nt-1)

da_c2    = fltarr(Nt)
da_kcor  = fltarr(Nt)
stop
for it=0,Nt-1 do begin
t0=t0a(it)
da_c2  (it) = findval(img_lascoc2, x_lascoc2,  y_lascoc2, r0, t0)
da_kcor(it) = findval(img_kcor   , x_kcor   ,  y_kcor   , r0, t0)
endfor

 plot,t0a/!dtor,da_c2  ,xstyle=1,$
      xtitle = 'PA [deg]',ytitle='pB [10!U-10!N B!DSUN!N]',$
      title  = 'LASCO-C2 (solid) and KCOR (dashed) at '+strmid(string(r0),6,3)+' R!DSUN!N'
oplot,t0a/!dtor,da_kcor*factor,linestyle=3
stop
return
end
