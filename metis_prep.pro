; metis_prep,data_dir='/data1/tomography/DATA/metis/Perihelion_04-2023/',file_list='list.txt',r0=[3.0]

; metis_prep,data_dir='/data1/tomography/DATA/metis/Synthetic/',file_list='list.txt',r0=[1.93,3.5,4.11]
pro metis_prep,data_dir=data_dir,file_list=file_list,r0=r0,win=win
common constants,c,rsun,au

  loadconstants

  if not keyword_set(r0) then r0 = [3.0]
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
     new_filename = strmid(filename,0,strlen(filename)-5)+'_prep.fits'
     expand_header_metis,hdr=hdr,img=img
     p = where(img le 0.)
     if p(0) ne -1 then img(p) = -666.
     mwritefits,hdr,img,outfile=data_dir+new_filename
     printf,2,new_filename
     metis_inspect,hdr=hdr,img=img,r0=r0,data_dir=data_dir,filename=filename,win=win
    ;print,'Exp Time:',hdr.exptime
    ;print,'Units:',hdr.bunit
    ;print,'Note that KCOR images must be provided to tom codes in units of [Bsun]' 
  endfor
  close,/all
  stop
  return
end

pro metis_inspect,hdr=hdr,img=img,r0=r0,data_dir=data_dir,filename=filename,win=win
  compute_image_grid,hdr=hdr,ra=ra,pa=pa,x=x,y=y,instrument='metis'

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
 if NOT keyword_set(win) then win=0
 window,win,xs=hdr.naxis1,ys=hdr.naxis1
 loadct,39
 i  = where(img gt 0.) & mini  = min(img(i)) 
 tvscl,alog10(img2  > mini ),0
 record_gif,data_dir,filename+'_image.gif','X'
 return
end

pro display_latitudinal_profiles,height=height,hdr=hdr,img=img,ra=ra,pa=pa,x=x,y=y

if not keyword_set(height) then begin
   print,'please specify height.'
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
      title  = 'METIS pB ['+hdr.data_uni+'] at '+strmid(string(height),6,4)+' R!DSUN!N'
 loadct,12
 blue  = 100
 red   = 200
 green =  20
 oplot,t0a/!dtor,da,th=3,color=blue
 loadct,0
 
return
end

pro expand_header_metis,hdr=hdr,img=img
common constants,c,rsun,au

 DSUN     = hdr.distance * 1.e3 ; m
;CRLN_OBS = 0.                  ; deg
 CRLT_OBS = hdr.LATITUDE        ; deg
 INST_ROT = 0.                  ; deg

 ; Bring Units from [1.e-8 <Bsun>] to [1.e-10 <Bsun>]
 img          = 1.e+2 * img
 hdr.data_uni = '10^-10 Bsun'
 
 ; Correction to CRPIX1,2
 ; Federica informed me that she starts to count CRPIX1,2 from ZERO.
 ; I add 1 here to bring it to FITS start-from-1 convention,
 ; which is what the tom codes expect.
   hdr.CRPIX1 = hdr.CRPIX1 + 1.0
   hdr.CRPIX2 = hdr.CRPIX2 + 1.0

 ; The following is a tiny half-pixel correction determined by Alberto
 ; to be necesary. I cancel it until the issue is clarified with Federica. 
 ; hdr.CRPIX1 = hdr.CRPIX1 - .5
 ; hdr.CRPIX2 = hdr.CRPIX2 - .5
   
  hdr  = create_struct(hdr                      ,$
;                     'CRLN_OBS'  ,CRLN_OBS     ,$ ; deg
                      'CRLT_OBS'  ,CRLT_OBS     ,$ ; deg
                      'DSUN'      ,DSUN         ,$ ; m
                      'HAEX_OBS'  ,DSUN         ,$ ; m
                      'HAEY_OBS'  ,0.           ,$
                      'HAEZ_OBS'  ,0.           ,$
                      'INST_ROT'  ,INST_ROT     )

 ;hdr.BSCALE = 1.
 ;print, 'NOTE: BSCALE has been set to 1, because the IMAGE is now a FLOAT ARRAY.'
  
  return
end 

pro loadconstants
common constants,c,rsun,au
; Set useful constants
  c    = 299792.458e3    ; m/sec
  rsun = 695700.e3       ; m 
  au   = 149.597870700e9 ; m
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
