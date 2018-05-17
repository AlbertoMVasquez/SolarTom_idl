;---------------------------------------------------------------------
;
; Brief description:
;
; Tool to prepare CoMP/UCoMP images for tomography.
;
; History:  V1.0, Alberto M. Vasquez, CLaSP, Spring-2018.
;
; Calling sequence example:
; comp_prep,data_dir='/data1/tomography/DATA/comp/1074/CR2198/',file_list='list.txt'
;
;---------------------------------------------------------------------

; Main routine:
pro comp_prep,data_dir=data_dir,file_list=file_list
  common data,header_peak_struct,output_header
  common constants,AU
  load_constants
  N=0
  filename=''
  openr,1,data_dir+file_list
  readf,1,N
  new_file_list = strmid(file_list,0,strlen(file_list)-4)+'_prep.txt'
   openw,2,data_dir+new_file_list
  printf,2,N  
  for i = 0,N-1 do begin
     readf,1,filename

     goto,skip_readfits
     crap  = readfits(data_dir+filename,header_primary, exten_no=0)
     peak  = readfits(data_dir+filename,header_peak,    exten_no=1)
     width = readfits(data_dir+filename,header_width,   exten_no=4)
     skip_readfits:
     
    ; The following fits_open sequence produces same results as the readfits
    ; sequence above, but it is a bit faster. NOTE from Giuliana: These
    ; apply scaling by default, but CoMP data does not use BZERO and BSCALE. 
     fits_open, data_dir+filename, fcb
     fits_read,  fcb, tmp,         header_primary, /header_only, exten_no=0; reads primary header only
     fits_read,  fcb, image_peak,  header_peak,    extname='Intensity'
     fits_read,  fcb, image_width, header_width,   extname='Line Width'
     fits_close, fcb
     header_primary_struct = fitshead2struct(header_primary, dash2underscore=dash2underscore)
     header_peak_struct    = fitshead2struct(header_peak   , dash2underscore=dash2underscore)
     header_width_struct   = fitshead2struct(header_width  , dash2underscore=dash2underscore)
     stop
     expand_header
     
     new_filename = strmid(filename,0,strlen(filename)-4)+'_prep.fts'
     mwritefits,hdr,img,outfile=data_dir+new_filename
     printf,2,new_filename
  endfor
  close,/all
  return
end

; Sub-routines:
pro create_output_header
  common data,header_peak_struct,output_header
  common constants,AU  

  stop
  geocentric_sun_ephemeris = get_sun(hdr.DATE_OBS)
  DSUN = geocentric_sun_ephemeris[0] * AU ; m
  
  hdr  = create_struct(hdr        ,      $
                      'DSUN'      ,DSUN ,$ ; m
                      'HAEX_OBS'  ,DSUN ,$ ; m
                      'HAEY_OBS'  ,0.   ,$
                      'HAEZ_OBS'  ,0.   )

  return
end

pro load_constants
  common constants,AU
  AU = 149597870700. ; m
return
end


