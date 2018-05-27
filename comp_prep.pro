;---------------------------------------------------------------------
;
; Brief description:
;
; Tool to prepare CoMP/UCoMP images for tomography.
;
; History:  V1.0, Alberto M. Vasquez, CLaSP, Spring-2018.
;
; Calling sequence examples:
; comp_prep,data_dir='/data1/tomography/DATA/comp/1074/CR2198/',file_list='list_mean.txt',r0=[1.1,1.3],/meanfits
; comp_prep,data_dir='/data1/tomography/DATA/comp/1074/CR2198/',file_list='list.txt'     ,r0=[1.1,1.3],/dynamics
; comp_prep,data_dir='/data1/tomography/DATA/comp/1079/CR2198/',file_list='list.txt'     ,r0=[1.1,1.3],/dynamics
;
;---------------------------------------------------------------------

; Main routine:
pro comp_prep,data_dir=data_dir,file_list=file_list,r0=r0,dynamics=dynamics,meanfits=meanfits
  common data,image_peak,image_width,header_peak_struct,output_header,image_total_intensity,image_Imean,header_Imean_struct
  common constants,AU,c
  common files,filetype
  
  filetype=''
  if keyword_set(dynamics) then filetype = 'dynamics'
  if keyword_set(meanfits) then filetype = 'meanfits'
  if filetype eq '' then begin
     print,'Specify filetype.'
     return
  endif
  
  load_constants
  if not keyword_set(r0) then r0 = [1.1]
  N=0
  filename=''
  openr,1,data_dir+file_list
  readf,1,N
  output_file_list = strmid(file_list,0,strlen(file_list)-4)+'_total_intensity.txt'
   openw,2,data_dir+output_file_list
  printf,2,N  
  for i = 0,N-1 do begin
     readf,1,filename
     fits_open,  data_dir+filename, fcb
     fits_read,  fcb, tmp, header_primary, /header_only, exten_no=0 ; reads primary header only
     if filetype eq 'dynamics' then begin
        fits_read,  fcb, image_peak,  header_peak,    extname='Intensity'
        fits_read,  fcb, image_width, header_width,   extname='Line Width'
        header_primary_struct = fitshead2struct(header_primary, dash2underscore=dash2underscore)
        header_peak_struct    = fitshead2struct(header_peak   , dash2underscore=dash2underscore)
        header_width_struct   = fitshead2struct(header_width  , dash2underscore=dash2underscore)
     endif
     if filetype eq 'meanfits' then begin
        fits_read,  fcb, image_Imean, header_Imean, extname = 'I'
        header_Imean_struct    = fitshead2struct(header_Imean   , dash2underscore=dash2underscore)
     endif
     fits_close, fcb

     create_output_header
     compute_line_total_intensity_image

     pinf = where(finite(image_total_intensity) ne 1)
     if pinf(0) ne -1 then begin
        print,'There are Infinite and/or NaN values in the output image.'
        stop
     endif
     pneg = where(image_total_intensity lt 0.)
     if pneg(0) ne -1 then begin
        print,'There are negative values in the output image.'
     endif
     
     comp_inspect,r0=r0,data_dir=data_dir,filename=filename

     output_filename = strmid(filename,0,strlen(filename)-4)+'_total_intensity.fts'     
     mwritefits,output_header,image_total_intensity,outfile=data_dir+output_filename
    ;writefits,data_dir+output_filename,image_total_intensity,output_header
     printf,2,output_filename
     print,output_filename
  endfor
  close,/all
  return
end

pro compute_line_total_intensity_image
  common data,image_peak,image_width,header_peak_struct,output_header,image_total_intensity,image_Imean,header_Imean_struct
  common constants,AU,c
  common files,filetype

  ; Here I will code a table of Bsun values in units of
  ; erg cm-2 sec-1 sr-1 A-1
  ; that will select the value upon the value of: header_peak.WAVELENG
                                ; ... Bsun = .... from table....
  Bsun = 1.0                    ; (Just for now, until table is coded)

  if filetype eq 'dynamics' then begin
     image_w = (image_width*1.e3/c) * output_header.WAVELENG * 10. ; line width in units of [A]
     image_p = image_peak*1.e-6*Bsun ; line peak in units of [Bsun]
     image_total_intensity = image_peak * sqrt(!pi) * image_w ; total intensity in units of [Bsun*A]
  endif
  if filetype eq 'meanfits' then begin
     image_total_intensity = image_Imean*1.e-6*Bsun ; In this case this is the intensity at central reference wavelength in units of [Bsun]
  endif

  ; Make -666 all null pixels.
  izero = where(image_total_intensity eq 0.)
  if izero(0) ne -1. then image_total_intensity(izero) = -666.

  image_total_intensity = float(image_total_intensity) ; Make sure image is single precision.
  return
end

; Sub-routines:
pro create_output_header
  common data,image_peak,image_width,header_peak_struct,output_header,image_total_intensity,image_Imean,header_Imean_struct
  common constants,AU,c
  common files,filetype

  ; Initialize header using the one read with the image.
  if filetype eq 'dynamics' then output_header = header_peak_struct
  if filetype eq 'meanfits' then output_header = header_Imean_struct
  
goto,skip
  output_header = create_struct(output_header,$
                                'NAXIS1'  ,(size(image_peak))[1],$
                                'NAXIS2'  ,(size(image_peak))[1],$
                                'WAVELENG',output_header.WAVE_REF)
skip:
  
  geocentric_sun_ephemeris = get_sun(output_header.DATE_OBS)
  DSUN     = geocentric_sun_ephemeris[ 0] * AU ; m
  CRLN_OBS = geocentric_sun_ephemeris[10]      ; deg
  CRLT_OBS = geocentric_sun_ephemeris[11]      ; deg
  output_header  = create_struct(output_header,$
                      'DSUN'      ,DSUN       ,$ ; m
                      'CRLN_OBS'  ,CRLN_OBS   ,$ ; deg
                      'CRLT_OBS'  ,CRLT_OBS   ,$ ; deg                                 
                      'HAEX_OBS'  ,DSUN       ,$ ; m
                      'HAEY_OBS'  ,0.         ,$
                      'HAEZ_OBS'  ,0.          )
  return
end

pro load_constants
  common constants,AU,c
  AU = 149597870700.            ; m
  c  =    299792458.            ; m/sec
return
end

 pro comp_inspect,r0=r0,data_dir=data_dir,filename=filename
   common data,image_peak,image_width,header_peak_struct,output_header,image_total_intensity,image_Imean,header_Imean_struct
   common grid,ra,pa,x, y
   common files,filetype
   
 computegrid

; Images for display:
 if filetype eq 'dynamics' then begin
    peak_img  = image_peak
    width_img = image_width
    total_img = image_total_intensity
 endif
 if filetype eq 'meanfits' then begin
    mean_img = image_Imean
 endif
 
 if not keyword_set(r0) then r0=1.05
 dr=0.01

for ir=0,n_elements(r0)-1 do begin
   ring = where(ra ge r0[ir]-dr/2. and ra le r0[ir]+dr/2.)
if filetype eq 'dynamics' then begin
 peak_img(ring) = max(image_peak)
 width_img(ring)= max(image_width)
 total_img(ring)= max(image_total_intensity)
 ps1,data_dir+filename+'_peak_latiudinal_profile.'+string(r0[ir])+'.eps',0
 display_latitudinal_profiles,height=r0[ir],/peak
 ps2
 ps1,data_dir+filename+'_width_latiudinal_profile.'+string(r0[ir])+'.eps',0
 display_latitudinal_profiles,height=r0[ir],/width
 ps2 
 ps1,data_dir+filename+'_total_intensity_latiudinal_profile.'+string(r0[ir])+'.eps',0
 display_latitudinal_profiles,height=r0[ir],/total
 ps2
endif
if filetype eq 'meanfits' then begin
 mean_img(ring) = max(image_Imean)
 ps1,data_dir+filename+'_meanimage_intensity_latiudinal_profile.'+string(r0[ir])+'.eps',0
 display_latitudinal_profiles,height=r0[ir],/meanimage
 ps2
endif
endfor

loadct,39
if filetype eq 'dynamics' then begin 
 window,xs=620*3,ys=620
 ipeak  = where(image_peak  gt 0.) & minpeak  = min(image_peak (ipeak )) 
 iwidth = where(image_width gt 0.) & minwidth = min(image_width(iwidth)) * 0.5
 itotal = where(image_total_intensity gt 0.) & mintotal  = min(image_total_intensity (ipeak )) 
 tvscl,alog10(peak_img  > minpeak ),0
 tvscl,alog10(width_img > minwidth),1
 tvscl,alog10(total_img > mintotal),2
 record_gif,data_dir,filename+'_images.gif','X'
endif
if filetype eq 'meanfits' then begin
   window,xs=620,ys=620
   iImean  = where(image_Imean  gt 0.) & minImean  = min(image_Imean (iImean))
   tvscl,alog10(mean_img  > minImean ),0
   record_gif,data_dir,filename+'_images.gif','X'
endif
loadct,0

 return
end

pro display_latitudinal_profiles,height=height,peak=peak,width=width,total=total,meanimage=meanimage
   common data,image_peak,image_width,header_peak_struct,output_header,image_total_intensity,image_Imean,header_Imean_struct
   common grid,ra,pa,x, y
   common files,filetype

if not keyword_set(height) then begin
   print,'please specify height.'
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

if keyword_set(total) then begin
   img_data = image_total_intensity
   titulo   = 'Total Intensity '
endif

if keyword_set(meanimage)  then begin
   img_data = image_total_intensity
   titulo   = 'Mean-Image Intensity '
endif

Nt=180
t0a = 2.*!pi*findgen(Nt)/float(Nt-1)

da = fltarr(Nt)

for it=0,Nt-1 do begin
t0=t0a(it)
da(it) = findval(img_data, x, y, height, t0)
endfor

 mini = max([min(da),0.])
 maxi = max(da)

 !p.charsize=1
 plot,t0a/!dtor,da ,xstyle=1,yr=[mini,maxi],/nodata,$
      xtitle = 'PA [deg]',$
      title  = titulo+'at '+strmid(string(height),6,4)+' R!DSUN!N'
 loadct,12
 blue  = 100
 red   = 200
 green =  20
 oplot,t0a/!dtor,da,th=3,color=blue
 loadct,0
 
return
end

pro computegrid
   common data,image_peak,image_width,header_peak_struct,output_header,image_total_intensity,image_Imean,header_Imean_struct
   common grid,ra,pa,x, y

 hdr = output_header
   
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

