;---------------------------------------------------------------------
;
; Brief description:
;
; kcor_prep.pro allows to prepare KCOR images for tomography and produces GIF
; images of them, as well as plots of the latitudinal dependence of
; the intensity at user-provided heliocentric heights.
;
; Note that it uses other routines contained in this same file.
; Compile '.r kcor_prep' to make all routines user-available.
;
; Data must be stored in directory 'data_dir', where the file list
; 'file_list' contains the number of data files in the first line
; and their names (one per row). The 1D array 'r0' lists heliocentric
; distances at which the latitudinal dependence of the intensity will
; be plotted.
;
; As a result, in the same directory where the data is located, the
; new data (*_prep.fts) list file (*_prep.txt), as well as gif images
; and eps plots, are generated.
;
; The '*_prep.fts' images and the '*_prep.txt' list file are the ones
; that can in principle be used for tomography.
;
; The routine 'compute_avg_kcor.pro' at the end of this file allows to
; make averages of many shots. it is intendeded to be used when HAO
; will not provide an average. Ask Alberto Vasquez
; (albert@iafe.uba.ar) to get an explanation of its use.
;
; HISTORY:  V1.0, Alberto M. Vasquez, CLaSP, Spring-2018.
;           V1.1, Alberto M. Vasquez, IAFE,  August-2020.
;                 Simplified time-tag selection for header.
;                 Note it assings the initial time of the
;                 averaged images.
;
; Calling sequence examples (Use the first call for experimentation and understanding):
;
; kcor_prep,data_dir='/data1/tomography/DATA/kcor/CR2198/10MinAvg/',       file_list='list_test_one.txt',r0=[1.09,1.5,2.0]
; kcor_prep,data_dir='/data1/tomography/DATA/kcor/CR2198/Original_Images/',file_list='list_test_one.txt',r0=[1.09,1.5,2.0]
;
; kcor_prep,data_dir='/media/Data1/data1/tomography/DATA/kcor/CR2198/10MinAvg/',file_list='list_new.txt',r0=[1.09,1.5,2.0]
; kcor_prep,data_dir='/media/Data1/data1/tomography/DATA/kcor/CR2208/10MinAvg/',file_list='list_new.txt',r0=[1.09,1.5,2.0]
;
; kcor_prep,data_dir='/data1/tomography/DATA/kcor/CR2198/Original_Images/',file_list='list.txt',r0=[1.05,1.5,2.0]
; kcor_prep,data_dir='/data1/tomography/DATA/kcor/CR2198/Nooffset_Images/',file_list='list.txt',r0=[1.09,1.5,2.0]
; kcor_prep,data_dir='/data1/tomography/DATA/kcor/CR2198/AvgNoOffset_Images/',file_list='list.txt',r0=[1.09,1.5,2.0]
; kcor_prep,data_dir='/data1/tomography/DATA/kcor/CR2198/2017/12/03/',file_list='list.txt'
;
;---------------------------------------------------------------------

; Main routine:
pro kcor_prep,data_dir=data_dir,file_list=file_list,r0=r0
  if not keyword_set(r0) then r0 = [1.5]
  N=0
  filename=''
  openr,1,data_dir+file_list
  readf,1,N
  new_file_list = strmid(file_list,0,strlen(file_list)-4)+'_prep.txt'
   openw,2,data_dir+new_file_list
  printf,2,N  
  for i = 0,N-1 do begin
     readf,1,filename
     mreadfits,data_dir+filename,hdr,img
     new_filename = strmid(filename,0,strlen(filename)-4)+'_prep.fts'
     expand_header_kcor,hdr=hdr
    ;Make -666 all null pixels.
    ;izero = where(img eq 0.)
    ;if izero(0) ne -1. then img(izero) = -666.
     mwritefits,hdr,img,outfile=data_dir+new_filename
     printf,2,new_filename
     kcor_inspect,hdr=hdr,img=img,r0=r0,data_dir=data_dir,filename=filename
     print,'Exp Time:',hdr.exptime
     print,'Units:',hdr.bunit
     print,'Note that KCOR images must be provided to tom codes in units of [Bsun]' 
  endfor
  close,/all
  return
end

; Sub-routines:
pro expand_header_kcor,hdr=hdr

  AU = 149597870700. ; m
 ;geocentric_sun_ephemeris = get_sun(hdr.TIME_OBS+' '+hdr.DATE_OBS) ; ASK ALBERT!
  geocentric_sun_ephemeris = get_sun(hdr.date_obs) 
  DSUN = geocentric_sun_ephemeris[0] * AU ; m
  hdr  = create_struct(hdr        ,      $
                      'DSUN'      ,DSUN ,$ ; m
                      'HAEX_OBS'  ,DSUN ,$ ; m
                      'HAEY_OBS'  ,0.   ,$
                      'HAEZ_OBS'  ,0.   )

  hdr.BSCALE = 1.
  print, 'NOTE: BSCALE has been set to 1, because the IMAGE is now a FLOAT ARRAY.'
  
  return
end

pro kcor_inspect,hdr=hdr,img=img,r0=r0,data_dir=data_dir,filename=filename
  compute_image_grid,hdr=hdr,ra=ra,pa=pa,x=x,y=y,instrument='kcor'
; Image for display:
 img2  = img
 dr=0.01
for ir=0,n_elements(r0)-1 do begin
 ring = where(ra ge r0[ir]-dr/2. and ra le r0[ir]+dr/2.)
 img2(ring) = max(img)
 ps1,data_dir+filename+'_latiudinal_profile.'+string(r0[ir])+'.eps',0
 display_latitudinal_profiles,height=r0[ir],hdr=hdr,img=img,ra=ra,pa=pa,x=x,y=y
 ps2
endfor
 window,0,xs=hdr.naxis1,ys=hdr.naxis1
 loadct,39
 i  = where(img gt 0.) & mini  = min(img(i)) 
 tvscl,alog10(img2  > mini ),0
 record_gif,data_dir,filename+'_image.gif','X'
 return
end

pro display_latitudinal_profiles,height=height,hdr=hdr,img=img,ra=ra,pa=pa,x=x,y=y

if not keyword_set(height) then begin
   print,'please specify hright.'
   stop 
endif

img_data = img

Nt=180
t0a = 2.*!pi*findgen(Nt)/float(Nt-1)

da = fltarr(Nt)

for it=0,Nt-1 do begin
t0=t0a(it)
da(it) = findval(img_data, x, y, height, t0)
endfor

 mini = max([min(da),-1.])
 maxi = max(da)

 !p.charsize=1
 plot,t0a/!dtor,da ,xstyle=1,yr=[mini,maxi],/nodata,$
      xtitle = 'PA [deg]',$
      title  = 'KCOR pB ['+string(hdr.bunit)+'] at '+strmid(string(height),6,4)+' R!DSUN!N'
 loadct,12
 blue  = 100
 red   = 200
 green =  20
 oplot,t0a/!dtor,da,th=3,color=blue
 loadct,0
 
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
fin:
return,Df
end


pro process_and_average_kcor_data,windowlapse=windowlapse,inithour=inithour
  common time_parameters,overal_window_lapse,overal_init_hour
  overal_window_lapse = windowlapse
  overal_init_hour    = inithour
  
  year ='2017/'
  month='12/'
  dates=['03','04','05','06','07','08','09','10','11','12','13','14','15','16']+'/'
  Ndates=n_elements(dates)
  for i=0,0 do begin
     data_dir = '/data1/tomography/DATA/kcor/CR2198/'+year+month+dates[i]
     kcor_prep,data_dir=data_dir,file_list='list.txt'
     compute_avg_kcor,data_dir=data_dir,file_list='list_prep.txt'
  endfor
  return
end

; 
pro compute_avg_kcor,data_dir=data_dir,file_list=file_list,window_lapse=window_lapse,init_hour=init_hour

  common time_parameters,overal_window_lapse,overal_init_hour

  if     keyword_set(overal_window_lapse) then window_lapse = overal_window_lapse
  if     keyword_set(overal_init_hour   ) then init_hour    = overal_init_hour   
  if not keyword_set(window_lapse       ) then window_lapse = 1.

  N=0
  openr,1,data_dir+file_list
  readf,1,N
  day_of_year_array = fltarr(N)
  hour_of_day_array = fltarr(N)

  filename=''
  for i = 0,N-1 do begin
     readf,1,filename
     mreadfits,data_dir+filename,header,image;, /noscale
     if i eq 0 then ImageSize = header.naxis1
     date_vector = date_conv(header.date_obs,'V')
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
  image_selected_array = fltarr(Nimages,ImageSize,ImageSize)

   openr,1,data_dir+file_list
   readf,1,N
   output_file_list = strmid(file_list,0,strlen(file_list)-4)+'_avg_files_'+suffix+'.txt'
   openw,2,data_dir+output_file_list
   printf,2,'Number of images used: ',Nimages
   if i0 gt 0 then for i=0,i0-1 do readf,1,filename ; First i0 images are skipped.
  for i = i0,ifinal do begin
     readf,1,filename
     mreadfits,  data_dir+filename, header, image;, /noscale
     printf,2,filename+'  Date_obs: '+header.date_obs
          
     ;; Make Average output header and filename from the header and filename
     ;; of the median image. Record also median_image.
     if i eq imedian then begin
        med_image           = image
        med_output_header   = header
        avg_output_header   = header
        avg_output_filename = strmid(filename,0,strlen(filename)-4)+'_avg_image_'+suffix+'.fts'
        med_output_filename = strmid(filename,0,strlen(filename)-4)+'_med_image_'+suffix+'.fts'
        mwritefits,med_output_header,med_image,outfile=data_dir+med_output_filename
     endif

     ;; Load ith-element of total_intensity_image_selected_array:
     image_selected_array(i-i0,*,*) = image

  endfor
  close,/all

  array = image_selected_array
  average_images,array=array,Nimages=Nimages,ImageSize=ImageSize,average_image=average_image

  avg_image = average_image
  mwritefits,avg_output_header,avg_image,outfile=data_dir+avg_output_filename
  
  print,'Averaged file: ',avg_output_filename
  print,'Median   file: ',med_output_filename

  compare_two_images,data_dir=data_dir,img1_filename=avg_output_filename,img2_filename=med_output_filename,r0=1.06,instrument='kcor'

  record_gif,data_dir,avg_output_filename+'.gif','X'
  
  return
end

