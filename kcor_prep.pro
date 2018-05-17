;---------------------------------------------------------------------
;
; Brief description:
;
; Tool to prepare KCOR images for tomography.
;
; History:  V1.0, Alberto M. Vasquez, CLaSP, Spring-2018.
;
; Calling sequence example:
; kcor_prep,data_dir='/data1/tomography/DATA/kcor/CR2198/',file_list='list.txt'
;
;---------------------------------------------------------------------

; Main routine:
pro kcor_prep,data_dir=data_dir,file_list=file_list
  common data,hdr
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
     mreadfits,data_dir+filename,hdr,img
     stop
     new_filename = strmid(filename,0,strlen(filename)-4)+'_prep.fts'
     expand_header
     mwritefits,hdr,img,outfile=data_dir+new_filename
     printf,2,new_filename
  endfor
  close,/all
  return
end

; Sub-routines:
pro expand_header
  common data,hdr
  common constants,AU  
  geocentric_sun_ephemeris = get_sun(hdr.DATE_OBS)
  DSUN = geocentric_sun_ephemeris[0] * AU  ; m
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
