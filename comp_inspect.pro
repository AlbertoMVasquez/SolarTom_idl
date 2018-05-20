 pro comp_inspect,r0=r0,data_dir=data_dir,filename=filename
  common data, image_peak, image_width, x, y
  
     fits_open, data_dir+filename, fcb
     fits_read,  fcb, tmp,         header_primary, /header_only, exten_no=0; reads primary header only
     fits_read,  fcb, image_peak,  header_peak,    extname='Intensity'
     fits_read,  fcb, image_width, header_width,   extname='Line Width'
     fits_close, fcb
     header_primary_struct = fitshead2struct(header_primary, dash2underscore=dash2underscore)
     header_peak_struct    = fitshead2struct(header_peak   , dash2underscore=dash2underscore)
     header_width_struct   = fitshead2struct(header_width  , dash2underscore=dash2underscore)

 computegrid,header_peak_struct,ra,pa,x,y,instrument=instrument

; Images for display:
 peak_img  = image_peak
 width_img = image_width
if not keyword_set(r0) then r0=1.05
 dr=0.01
for ir=0,n_elements(r0)-1 do begin
 ring = where(ra ge r0[ir]-dr/2. and ra le r0[ir]+dr/2.)
 peak_img(ring) = max(image_peak)
 width_img(ring)= max(image_width)
 ps1,data_dir+filename+'_peak_latiudinal_profile.'+string(r0[ir])+'.eps',0
 display_latitudinal_profiles,height=r0[ir],/peak
 ps2
 ps1,data_dir+filename+'_width_latiudinal_profile.'+string(r0[ir])+'.eps',0
 display_latitudinal_profiles,height=r0[ir],/width
 ps2 
endfor
 
 window,xs=620*2,ys=620
 loadct,39
 ipeak  = where(image_peak  gt 0.) & minpeak  = min(image_peak (ipeak )) 
 iwidth = where(image_width gt 0.) & minwidth = min(image_width(iwidth)) * 0.5
 tvscl,alog10(peak_img  > minpeak ),0
 tvscl,alog10(width_img > minwidth),1
 record_gif,data_dir,filename+'_images.gif','X'
 return
end

pro display_latitudinal_profiles,height=height,peak=peak,width=width
  common data, image_peak, image_width, x, y  

if not keyword_set(height) then begin
   print,'please specify hright.'
   stop
endif

if keyword_set(peak)  then begin
   img_data = image_peak
   titulo   = 'Peak Intensity '
endif

if keyword_set(width) then begin
   img_data = image_width
   titulo   = 'Line Width '
endif

Nt=180
t0a = 2.*!pi*findgen(Nt)/float(Nt-1)

da = fltarr(Nt)

for it=0,Nt-1 do begin
t0=t0a(it)
da(it) = findval(img_data, x, y, height, t0)
endfor

 mini = min(da)
 maxi = max(da)

 plot,t0a/!dtor,da ,xstyle=1,yr=[mini,maxi],/nodata,$
      xtitle = 'PA [deg]',ytitle='Peak Intensity',$
      title  = titulo+'at '+strmid(string(height),6,3)+' R!DSUN!N'
 loadct,12
 blue  = 100
 red   = 200
 green =  20
 oplot,t0a/!dtor,da,th=3,color=blue
 loadct,0
 
return
end

pro computegrid,hdr,ra,pa,x,y,instrument=instrument

 Rs     = hdr.RSUN        ; Sun radius in arcsec
 px     = hdr.cdelt1      ; Pixel size in arcsec 
 Rs=Rs/px                 ; Sun radius in pixels
 px=1./Rs                 ; Pixel size in Rsun units
 ix0=hdr.crpix1-1         ; Disk center x-pixel, changed to IDL convention (FITS convention starts with index=1, IDL starts with index=0). 
 iy0=hdr.crpix2-1         ; Disk center y-pixel, changed to IDL convention

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

