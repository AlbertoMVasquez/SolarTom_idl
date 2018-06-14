;---------------------------------------------------------------------
;
; Brief description:
;
; Tool to prepare KCOR images for tomography.
;
; History:  V1.0, Alberto M. Vasquez, CLaSP, Spring-2018.
;
; Calling sequence example:
; kcor_prep,data_dir='/data1/tomography/DATA/kcor/CR2198/Original_Images/',file_list='list.txt',r0=[1.05,1.5,2.0]
; kcor_prep,data_dir='/data1/tomography/DATA/kcor/CR2198/Nooffset_Images/',file_list='list.txt',r0=[1.09,1.5,2.0]
; kcor_prep,data_dir='/data1/tomography/DATA/kcor/CR2198/AvgNoOffset_Images/',file_list='list.txt',r0=[1.09,1.5,2.0]
; kcor_prep,data_dir='/data1/tomography/DATA/kcor/CR2198/2017/12/03/',file_list='list.txt'
;
;---------------------------------------------------------------------

; Main routine:
pro kcor_prep,data_dir=data_dir,file_list=file_list,r0=r0
  if not keyword_set(r0) then r0 = [1.1]
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
     stop
    ;print,'Exp Time:',hdr.exptime
  endfor
  close,/all
  return
end

; Sub-routines:
pro expand_header_kcor,hdr=hdr
  AU = 149597870700. ; m
  geocentric_sun_ephemeris = get_sun(hdr.DATE_OBS)
  DSUN = geocentric_sun_ephemeris[0] * AU  ; m
  hdr  = create_struct(hdr        ,      $
                      'DSUN'      ,DSUN ,$ ; m
                      'HAEX_OBS'  ,DSUN ,$ ; m
                      'HAEY_OBS'  ,0.   ,$
                      'HAEZ_OBS'  ,0.   )

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
 
 window,xs=hdr.naxis1,ys=hdr.naxis1
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
      title  = 'KCOR pB at '+strmid(string(height),6,4)+' R!DSUN!N'
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

