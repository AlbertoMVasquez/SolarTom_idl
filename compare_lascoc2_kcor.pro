pro comp,factor=factor,img_num=img_num,r0=r0,t0=t0,extra_suffix=extra_suffix,cor1=cor1
  
  common data,img_lascoc2,img_kcor,img_cor1,pa_lascoc2,pa_kcor,pa_cor1,ra_lascoc2,ra_kcor,ra_cor1,hdr_lascoc2,hdr_kcor,dr_cor1,x_lascoc2,y_lascoc2,x_kcor,y_kcor,x_cor1,y_cor1

  common mean_data,img_mean,hdr_mean
  common fovs,Rmin_KCOR,Rmin_COR1,Rmin_LASCOC2
  
  if not keyword_set(factor)       then factor       = 1.0
  if not keyword_set(img_num)      then img_num      = 0
  if not keyword_set(extra_suffix) then extra_suffix = ''
  if not keyword_set(t0)           then t0 = 90.
  
  dir='/data1/tomography/DATA/c2/CR2198/'
  files=['23690612pB.fts','23690730pB.fts','23690852pB.fts','23690978pB.fts']
  mreadfits,dir+files[img_num],hdr_lascoc2,img_lascoc2

  dir='/data1/tomography/DATA/kcor/CR2198/'
  files=['20171203_174720_kcor_l1.fts','20171204_175906_kcor_l1.fts','20171205_175217_kcor_l1.fts','20171206_211550_kcor_l1.fts']; '20171207_000002_kcor_l1.fts'
  mreadfits,dir+files[img_num],hdr_kcor,img_kcor
  img_kcor = img_kcor*1.e+4  ; Change KCOR units to [1e-10 Bsun]
  img_kcor =img_kcor*factor  ; apply factor to KCOR
  
if keyword_set(cor1) then begin
  dir = '/data1/tomography/DATA/cor1/'
  files=['20171203_175500_1P4c1A.fts','20171204_180000_1P4c1A.fts','20171205_175500_1P4c1A.fts','20171206_211500_1P4c1A.fts']
  mreadfits,dir+files[img_num],hdr_cor1,img_cor1
  average_images,dir=dir,list='list.txt'
  img_cor1 = img_mean
  hdr_cor1 = hdr_mean
  img_cor1 = img_cor1*1.e10*0.79 ; Change COR1 units from [MSB] to [1e-10 Bsun]
                                 ; where Bsun is the disk center
                                 ; brightness.
endif
  
  suffix = strmid(hdr_kcor.DATE_D$OBS,0,10)
  
  print,'LASCO-C2 OBS TIME: ',hdr_lascoc2.time_obs
  print,'KCOR     OBS TIME: ',hdr_kcor   .date_obs
  if keyword_set(cor1) then $
  print,'COR1     OBS TIME: ',hdr_cor1   .date_obs

  rotate_image,hdr_lascoc2,img_lascoc2, instrument = 'lascoc2'
  rotate_image,hdr_kcor   ,img_kcor,    instrument = 'kcor'
  if keyword_set(cor1) then $
  rotate_image,hdr_cor1   ,img_cor1,    instrument = 'cor1'
  
  computegrid,hdr_lascoc2,ra_lascoc2,pa_lascoc2,x_lascoc2,y_lascoc2,instrument='lascoc2'
  computegrid,hdr_kcor   ,ra_kcor   ,pa_kcor   ,x_kcor   ,y_kcor   ,instrument='kcor'
  if keyword_set(cor1) then $  
  computegrid,hdr_cor1   ,ra_cor1   ,pa_cor1   ,x_cor1   ,y_cor1   ,instrument='cor1'

  display_radial_profiles,t0=t0*!dtor,/alog10,suffix='log10_'+hdr_kcor   .date_obs+'_'
  
; Display all images in same size sharing same color-scale.
  
  img1=img_lascoc2
  img2=img_kcor
  if keyword_set(cor1) then $  
  img3=img_cor1
  
  mini = 1.
    maxi = max([max(img1),max(img2)])
  if keyword_set(cor1) then $
  maxi = max([max(img1),max(img2),max(img3)])

; Make zero r < 2.3 Rsun for img1 (LASCO_c2)
  Rmin_LASCOC2 = 2.3
  p=where(ra_lascoc2 le Rmin_LASCOC2)
  img1(p)=0.

; Make zero r < 1.05 Rsun for img2 (KCOR)
  Rmin_KCOR = 1.05
  p=where(ra_KCOR le Rmin_KCOR)
  img2(p)=0.

; Make zero r < 1.45 Rsun for img3 (COR1)
if keyword_set(cor1) then begin
  Rmin_COR1 = 1.45
  p=where(ra_COR1 le Rmin_COR1)
  img3(p)=0.
endif
  
; Draw white circles of width dr at several radii, in all images

  dr = 0.005
  Nradii = 21
  Rmin   = 1.5
  Step_r = 0.1
  radii = Rmin + Step_r * findgen(Nradii)
  for ir = 0,Nradii-1 do begin
     radius = radii[ir]
     p=where(ra_lascoc2 ge radius*(1.-dr/2.) and ra_lascoc2 le radius*(1.+dr/2.))
     img1(p) = maxi
     p=where(ra_kcor    ge radius*(1.-dr/2.) and ra_kcor    le radius*(1.+dr/2.))
     img2(p) = maxi
     if keyword_set(cor1) then begin
     p=where(ra_cor1    ge radius*(1.-dr/2.) and ra_cor1    le radius*(1.+dr/2.))
     img3(p) = maxi
     ps1,'~/Pictures/latitudinal_profiles_'+suffix+'_'+strmid(string(radius),6,3)+extra_suffix+'.eps',0
     !p.charsize=1
     loadct,0
     if     keyword_set(cor1) then display_latitudinal_profiles,r0=radius,/cor1
     if not keyword_set(cor1) then display_latitudinal_profiles,r0=radius
     ps2
     endif
  endfor
  loadct,39

; Force both images to have same MINI and MAXI
  img1([0,1]) = [mini,maxi]
  img2([0,1]) = [mini,maxi]
  img1 = img1 > mini < maxi
  img2 = img2 > mini < maxi
  numimg=2
if keyword_set(cor1) then begin
  numimg=numimg+1
  img3([0,1]) = [mini,maxi]
  img3 = img3 > mini < maxi
endif

  size=1024
  window,0,xs=size*numimg,ys=size
  tvscl,alog10(congrid(img1,size,size) > mini),0
  tvscl,alog10(congrid(img2,size,size) > mini),1
  if keyword_set(cor1) then $
  tvscl,alog10(congrid(img3,size,size) > mini),2

  record_gif,'~/Pictures/','images_'+suffix+'.gif','X'
  stop 

goto,skip_for_diego
; Display ra and pa arrays (for Diego)
  window,1,xs=1024,ys=512
  tvscl,ra_lascoc2,0
  tvscl,pa_lascoc2,1
  window,2,xs=1024,ys=512
  tvscl,congrid(ra_kcor,512,512),0
  tvscl,congrid(pa_kcor,512,512),1
  window,3,xs=1024,ys=512
  tvscl,congrid(ra_cor1,512,512),0
  tvscl,congrid(pa_cor1,512,512),1
skip_for_diego:
  

return
end

pro computegrid,hdr,ra,pa,x,y,instrument=instrument

if instrument eq 'kcor' or instrument eq 'cor1' then begin
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
 ANGLE = -hdr.inst_rot
endif

if instrument eq 'cor1' then begin
 ix0=hdr.crpix1-1         ; Disk center x-pixel, changed to IDL convention
 iy0=hdr.crpix2-1         ; Disk center y-pixel, changed to IDL convention
 ANGLE = -hdr.crota
endif

if instrument eq 'lascoc2' then begin
 ix0=hdr.xsun-1           ; Disk center x-pixel, changed to IDL convention
 iy0=hdr.ysun-1           ; Disk center y-pixel, changed to IDL convention
 ANGLE = -hdr.rollangl
endif
       
if abs(ANGLE) gt EPS then begin
 rimage=rot(image,ANGLE,1,ix0,iy0,/pivot,missing=hugenegnum)
 image = rimage
endif

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

pro display_latitudinal_profiles,r0=r0,cor1=cor1
  common data,img_lascoc2,img_kcor,img_cor1,pa_lascoc2,pa_kcor,pa_cor1,ra_lascoc2,ra_kcor,ra_cor1,hdr_lascoc2,hdr_kcor,dr_cor1,x_lascoc2,y_lascoc2,x_kcor,y_kcor,x_cor1,y_cor1
  common fovs,Rmin_KCOR,Rmin_COR1,Rmin_LASCOC2
  common cor1,da_cor1
  common kcor,da_kcor
  
if not keyword_set(r0) then begin
   print,'please specify r0.'
   stop
endif

Nt=180
t0a = 2.*!pi*findgen(Nt)/float(Nt-1)

da_c2    = fltarr(Nt)
da_kcor  = fltarr(Nt)
da_cor1  = fltarr(Nt)

for it=0,Nt-1 do begin
t0=t0a(it)
da_c2  (it) = findval(img_lascoc2, x_lascoc2,  y_lascoc2, r0, t0)
da_kcor(it) = findval(img_kcor   , x_kcor   ,  y_kcor   , r0, t0)
if keyword_set(cor1) then $
da_cor1(it) = findval(img_cor1   , x_cor1   ,  y_cor1   , r0, t0)
endfor

goto,skip_polar_subtraction  ; Ask ALBERT how and why we could use this.
if keyword_set(cor1) then $
cor1_polar_subtraction,r0=r0,t0a=t0a
kcor_polar_subtraction,r0=r0,t0a=t0a
skip_polar_subtraction:

maxi = max([da_c2,da_kcor,da_cor1])
maxi = max([      da_kcor,da_cor1])
if r0 gt 2.0 then maxi = max(da_cor1)

titulo = ''
if r0 le Rmin_LASCOC2 then titulo='KCOR (red) and COR1 (green) at '
if r0 ge Rmin_LASCOC2 then titulo='LASCO-2 (blue) and COR1 (green) at '

 plot,t0a/!dtor,da_c2  ,xstyle=1,yr=[0,maxi],/nodata,$
      xtitle = 'PA [deg]',ytitle='pB [10!U-10!N B!DSUN!N]',$
      title  = titulo+strmid(string(r0),6,3)+' R!DSUN!N'
 loadct,12
 blue  = 100
 red   = 200
 green =  20
 if r0 ge Rmin_LASCOC2                     then oplot,t0a/!dtor,da_c2  ,th=3,color=blue
 if r0 gt Rmin_KCOR and r0 le Rmin_LASCOC2 then oplot,t0a/!dtor,da_kcor,th=3,color=red
 if keyword_set(cor1) then $
 if r0 gt Rmin_COR1                        then oplot,t0a/!dtor,da_cor1,th=3,color=green
 loadct,0
 
return
end

pro average_images,dir=dir,list=list
  common mean_data,img_mean,hdr_mean
  N=0
  filename=''
  openr,1,dir+list
  readf,1,N
  indmedian = median(indgen(N))
  for i=0,N-1 do begin
     readf,1,filename
     mreadfits,dir+filename,hdr,img
     if i eq 0         then img_mean = img
     if i gt 0         then img_mean = img_mean + img
     if i eq indmedian then hdr_mean = hdr
  endfor
  img_mean = img_mean / float(N)
  close,1
  return
end

pro cor1_polar_subtraction,r0=r0,t0a=t0a
  common cor1,da_cor1
  pa  = t0a/!dtor
  CHc = 165.
  CHw =  20.
  p   = where(pa ge CHc-CHw/2. and pa le CHc+CHw/2.)
  CH_mean = mean(da_cor1(p))
  da_cor1 = da_cor1 - CH_mean > 0.
  print,'r = '+string(r0)+'   COR1 CHmean = '+string(CH_mean)
  return
end

pro kcor_polar_subtraction,r0=r0,t0a=t0a
  common kcor,da_kcor
  pa  = t0a/!dtor
  CHc = 165.
  CHw =  20.
  p   = where(pa ge CHc-CHw/2. and pa le CHc+CHw/2.)
  CH_mean = mean(da_kcor(p))
  da_kcor = da_kcor - CH_mean > 0.
  print,'r = '+string(r0)+'   KCOR CHmean = '+string(CH_mean)
  return
end

pro display_radial_profiles,t0=t0,alog10=alog10,suffix=suffix,alog_alb=alog_alb
  common data,img_lascoc2,img_kcor,img_cor1,pa_lascoc2,pa_kcor,pa_cor1,ra_lascoc2,ra_kcor,ra_cor1,hdr_lascoc2,hdr_kcor,dr_cor1,x_lascoc2,y_lascoc2,x_kcor,y_kcor,x_cor1,y_cor1

  if not keyword_set(t0) then begin
     print,'please specify the angle'
     stop
  endif

  Nr=180

  Rmin_lascoc2 = 2.3  
  Rmax_lascoc2 = 6.1  
  Rmin_kcor    = 1.05 
  Rmax_kcor    = 3.0 
  
  r0_kcor    = (Rmax_kcor - Rmin_kcor)      *findgen(Nr+1)/float(Nr) +Rmin_kcor
  r0_lascoc2 = (Rmax_lascoc2 - Rmin_lascoc2)*findgen(Nr+1)/float(Nr) +Rmin_lascoc2
  da_c2    = fltarr(Nr)
  da_kcor  = fltarr(Nr)
  
  for ir=0,Nr-1 do begin
     r0=r0_kcor(ir)
     da_kcor(ir) = findval(img_kcor   , x_kcor   ,  y_kcor   , r0, t0)
  endfor
  
  for ir=0,Nr-1 do begin
     r0=r0_lascoc2(ir)
     da_c2  (ir) = findval(img_lascoc2, x_lascoc2,  y_lascoc2, r0, t0)
  endfor
   
  radd = (Rmax_lascoc2 - Rmin_kcor)*findgen(Nr+1)/float(Nr) + Rmin_kcor

  datitos = findgen(Nr+1)/float(Nr)
  datitos(3) = max(da_kcor)
  datitos(2) = max(da_c2)
  datitos(0) = min(da_kcor(where(da_kcor gt 0.)))
  datitos(1) = min(da_c2 )

 if keyword_set(alog10) then begin
   ps1,'~/Pictures/radial_profiles_'+suffix+''+strmid(string(t0/!dtor),6,3)+'.eps',0
    !p.charsize=1
    loadct,12
    blue  = 100
    red   = 200
    green =  20
    plot,radd,alog10(datitos)  ,xstyle=1,/nodata,xr=[1,6],yr=[-2,4],$
         xtitle = 'rad [Rsun]',ytitle='Log!D10!N( pB [10!U-10!N B!DSUN!N] )',$
         title  = 'LASCO-C2 (blue) and KCOR (red) at PA = '+strmid(string(t0/!dtor),6,4)+' deg'
    oplot,r0_kcor,alog10(da_kcor),th=3,color=red
    oplot,r0_lascoc2,alog10(da_c2),th=3,color=blue
    ps2
 endif

 if keyword_set(alog_alb) then begin
 stop
   ps1,'~/Pictures/radial_profiles_'+suffix+''+strmid(string(t0/!dtor),6,3)+'.eps',0
    !p.charsize=1
    loadct,12
    blue  = 100
    red   = 200
    green =  20
    plot,radd,(datitos)  ,xstyle=1,/nodata,xr=[1,6],yr=[-2,4],/ylog,$
         xtitle = 'rad [Rsun]',ytitle='Log!D10!N( pB [10!U-10!N B!DSUN!N] )',$
         title  = 'LASCO-C2 (blue) and KCOR (red) at PA = '+strmid(string(t0/!dtor),6,4)+' deg'
    oplot,r0_kcor,(da_kcor(where(da_kcor gt 0.))),th=3,color=red
    oplot,r0_lascoc2,(da_c2),th=3,color=blue
    ps2
 endif

loadct,0
  return
end


