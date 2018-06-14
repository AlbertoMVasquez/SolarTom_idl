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

; comp_prep,data_dir='/data1/tomography_dev/DATA/comp/research_data/2017/20171118.comp.1079.daily_dynamics.3/',file_list='list.txt',r0=[1.1,1.3],/dynamics

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

pro process_data,windowlapse=windowlapse,inithour=inithour
  common time_parameters,overal_window_lapse,overal_init_hour
  overal_window_lapse = windowlapse
  overal_init_hour    = inithour
  
  year ='2017'
  month='12'
  dates=['03','04','05','06','07','08','09','10','11','12','13','14','15','16']
  Ndates=n_elements(dates)
  for i=0,Ndates-1 do begin
     
     data_dir_1079 = '/data1/tomography/DATA/comp/1079/CR2198/Full_Data/'+year+month+dates[i]+'.comp.1079.daily_dynamics/'
     CD,data_dir_1079
     datafiles = FILE_SEARCH('*.gz')
     openw,1,data_dir_1079+'list.txt'
     printf,1,n_elements(datafiles)
     for j=0,n_elements(datafiles)-1 do printf,1,datafiles[j]
     close,1
     CD,'/data1/tomography/SolarTom_idl/'
     compute_avg_dynamics,data_dir=data_dir_1079,file_list='list.txt',/dynamics

     data_dir_1074 = '/data1/tomography/DATA/comp/1074/CR2198/Full_Data/'+year+month+dates[i]+'.comp.1074.daily_dynamics/'
     CD,data_dir_1074
     datafiles = FILE_SEARCH('*.gz')
     openw,1,data_dir_1074+'list.txt'
     printf,1,n_elements(datafiles)
     for j=0,n_elements(datafiles)-1 do printf,1,datafiles[j]
     close,1
     CD,'/data1/tomography/SolarTom_idl/'
     compute_avg_dynamics,data_dir=data_dir_1074,file_list='list.txt',/dynamics

  endfor
  return
end

; compute_avg_dynamics,data_dir='/data1/tomography/DATA/comp/1074/CR2198/Full_Data/20171203.comp.1074.daily_dynamics/',file_list='list.txt',window_lapse=2.,init_hour=16.,/dynamics
; compute_avg_dynamics,data_dir='/data1/tomography/DATA/comp/1079/CR2198/Full_Data/20171203.comp.1079.daily_dynamics/',file_list='list.txt',window_lapse=2.,init_hour=16.,/dynamics
pro compute_avg_dynamics,data_dir=data_dir,file_list=file_list,window_lapse=window_lapse,dynamics=dynamics,meanfits=meanfits,init_hour=init_hour
  common data,image_peak,image_width,header_peak_struct,output_header,image_total_intensity,image_Imean,header_Imean_struct
  common constants,AU,c
  common files,filetype
  common time_parameters,overal_window_lapse,overal_init_hour
  
  filetype=''
  if keyword_set(dynamics) then filetype = 'dynamics'
  if keyword_set(meanfits) then filetype = 'meanfits'
  if filetype eq '' then begin
     print,'Specify filetype.'
     return
  endif

  if     keyword_set(overal_window_lapse) then window_lapse = overal_window_lapse
  if     keyword_set(overal_init_hour   ) then init_hour    = overal_init_hour   
  if not keyword_set(window_lapse       ) then window_lapse = 1.
  
  load_constants

  N=0
  openr,1,data_dir+file_list
  readf,1,N
  day_of_year_array = fltarr(N)
  hour_of_day_array = fltarr(N)

  filename=''
  for i = 0,N-1 do begin
     readf,1,filename
     fits_open,  data_dir+filename, fcb
     fits_read,  fcb, tmp, header_primary, /header_only, exten_no=0 ; reads primary header only
     if i eq 0 then begin
        fits_read,  fcb, image_peak,  header_peak,    extname='Intensity'
        ImageSize = (size(image_peak))[1]
     endif
     fits_close, fcb
     header_primary_struct = fitshead2struct(header_primary, dash2underscore=dash2underscore)
     header_peak_struct    = fitshead2struct(header_peak   , dash2underscore=dash2underscore)
     date_vector = date_conv(header_primary_struct.date_obs,'V')
     date_number = date_conv(header_primary_struct.date_obs,'R')
     date_julian = date_conv(header_primary_struct.date_obs,'J')
     day_of_year_array[i] = date_vector[1]
     hour_of_day_array[i] = date_vector[2] + date_vector[3]/60. + date_vector[3]/3600.
  endfor
  close,1

;; Determine indexes of the images to average, and their median index.
  ;; Default is to start with the first image of the day:
  if not keyword_set(init_hour) then init_hour = hour_of_day_array[0]
  ;; Determine index of first image:
  f  = abs(hour_of_day_array - init_hour)
  i0 = (where(f eq min(f)))(0)
  ;; Reset init_hour to the actual init_hour that is going to be used:
  init_hour = hour_of_day_array[i0]
  ;; Create suffix for various output files based on both init_hour and window_lapse:
  suffix='t0'+strmid(string(init_hour),6,4)+'-Dt'+strmid(string(window_lapse),6,4)
  ;; Detect days of the new-day and add 24 hr to their hour_of_day values:
  indnewday = where(day_of_year_array eq day_of_year_array[0]+1)
  if indnewday[0] ne -1 then hour_of_day_array(indnewday) = hour_of_day_array(indnewday) + 24.
  ;; Determine indexes of images to use:
  p = where(hour_of_day_array ge hour_of_day_array[i0] and hour_of_day_array le hour_of_day_array[i0] + window_lapse)
  ;; Number of images, final and median indices:
  Nimages = n_elements(p)
  ifinal  = i0 + Nimages-1
  imedian = i0 + Nimages/2

  ;; Create array to stack all images:
  total_intensity_image_selected_array = fltarr(Nimages,ImageSize,ImageSize)
  
   openr,1,data_dir+file_list
   readf,1,N
   output_file_list = strmid(file_list,0,strlen(file_list)-4)+'_avg_files_'+suffix+'.txt'
   openw,2,data_dir+output_file_list
   printf,2,'Number of images used: ',Nimages
   if i0 gt 0 then for i=0,i0-1 do readf,1,filename ; First i0 images are skipped.
  for i = i0,ifinal do begin
     readf,1,filename
     fits_open,  data_dir+filename, fcb
     fits_read,  fcb, tmp, header_primary, /header_only, exten_no=0 ; reads primary header only
        fits_read,  fcb, image_peak,  header_peak,    extname='Intensity'
        fits_read,  fcb, image_width, header_width,   extname='Line Width'
        header_primary_struct = fitshead2struct(header_primary, dash2underscore=dash2underscore)
        header_peak_struct    = fitshead2struct(header_peak   , dash2underscore=dash2underscore)
        header_width_struct   = fitshead2struct(header_width  , dash2underscore=dash2underscore)
     fits_close, fcb

     printf,2,filename+'  Date_obs: '+header_primary_struct.date_obs
     
     ;; Create the output header for ith image
     create_output_header
     ;; Compute total_intensity_image for ith image
     compute_line_total_intensity_image
     
     ;; Make Average output header and filename from the header and filename
     ;; of the median image. Record also median_image.
     if i eq imedian then begin
        med_image_total_intensity = image_total_intensity
        med_output_header   = output_header
        avg_output_header   = output_header
        avg_output_filename = strmid(filename,0,strlen(filename)-7)+'_avg_total_intensity_'+suffix+'.fts'
        med_output_filename = strmid(filename,0,strlen(filename)-7)+'_med_total_intensity_'+suffix+'.fts'
        mwritefits,med_output_header,med_image_total_intensity,outfile=data_dir+med_output_filename
     endif
     
     ;; Load ith-element of total_intensity_image_selected_array:
     total_intensity_image_selected_array(i-i0,*,*) = image_total_intensity

  endfor
  close,/all

  array = total_intensity_image_selected_array
  average_images,array=array,Nimages=Nimages,ImageSize=ImageSize,average_image=average_image

  avg_image_total_intensity = average_image
  mwritefits,avg_output_header,avg_image_total_intensity,outfile=data_dir+avg_output_filename
  
  print,'Averaged file: ',avg_output_filename
  print,'Median   file: ',med_output_filename

  compare_avg_med,data_dir=data_dir,avg_filename=avg_output_filename,med_filename=med_output_filename,ImageSize=ImageSize,r0=1.06
  record_gif,data_dir,avg_output_filename+'.gif','X'
  return
end

pro average_images,array=array,Nimages=Nimages,ImageSize=ImageSize,average_image=average_image
  average_image = fltarr(ImageSize,ImageSize) - 666.
  for ix=0,ImageSize-1 do begin
     for iy=0,ImageSize-1 do begin
        pixel_data_vector = reform(array(*,ix,iy))
        ipos = where(pixel_data_vector gt 0.)
        if ipos(0) eq -1 then goto,next_pixel
        if n_elements(ipos) lt Nimages/2. then goto,next_pixel
        average_image(ix,iy) = mean(pixel_data_vector(ipos))
        next_pixel:
     endfor
  endfor
  return
end

; compare_avg_med,data_dir='/data1/tomography/DATA/comp/1074/CR2198/Full_Data/20171203.comp.1074.daily_dynamics/',avg_filename=avg_filename,med_filename=med_filename
; compare_avg_med,data_dir='/data1/tomography/DATA/comp/1079/CR2198/Full_Data/20171203.comp.1079.daily_dynamics/',avg_filename=avg_filename,med_filename=med_filename

pro compare_avg_med,data_dir=data_dir,avg_filename=avg_filename,med_filename=med_filename,ImageSize=ImageSize,r0=r0
  if not keyword_set(r0) then r0=1.06
  mreadfits,data_dir+avg_filename,avghdr,avgimg
  mreadfits,data_dir+med_filename,medhdr,medimg
  avgind = where(avgimg gt 0.)
  avgmin = min(avgimg(avgind))
  avgmax = max(avgimg(avgind))
  medind = where(medimg gt 0.)
  medmin = min(medimg(medind))
  medmax = max(medimg(medind))
  mini   = min([avgmin,medmin])
  maxi   = max([avgmax,medmax])
  avgimg[0:1,0] = [mini,maxi]
  medimg[0:1,0] = [mini,maxi]
  avgimg = avgimg > mini <maxi
  medimg = medimg > mini <maxi
  compute_image_grid,header=avghdr,ra=ra,pa=pa,x=x,y=y,instrument='comp'
  window,xs=2*ImageSize,ys=ImageSize
  loadct,39
  dr=.005
  p=where(ra ge r0-dr/2. and ra le r0+dr/2.)
  avgimg(p) = mini
  tvscl,alog10(medimg>mini),0
  tvscl,alog10(avgimg>mini),1
  close,/all

  return
end
