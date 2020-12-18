;
; This is a code to make orig-versus-comp comparisons, where
; orig and comp are images produced by compare.c
;
; INPUT: Sample images, x-file, others, see wrappers.
;
; OUTPUT: GIF and EPS files with the comparison for each image,
;         recorded into the data_dir directory.
;
; HISTORY
; V1 Alberto M Vasquez, December 2020, IAFE.
;    First fully functional version with three wrappers
;    to serve as examples of use.
;    This first version works for KCOR, LASCO-C2 and AIA images.
;


pro wrapper_aia

  orig_image_array = ['20190626T0900.193.lev1p5.ETN.Norm-Ck0.1024.b.fts',$
                      '20190629T0300.193.lev1p5.ETN.Norm-Ck0.1024.b.fts',$
                      '20190629T0900.193.lev1p5.ETN.Norm-Ck0.1024.b.fts',$
                      '20190702T0900.193.lev1p5.ETN.Norm-Ck0.1024.b.fts',$
                      '20190705T0900.193.lev1p5.ETN.Norm-Ck0.1024.b.fts',$
                      '20190708T0900.193.lev1p5.ETN.Norm-Ck0.1024.b.fts']


  xfile = 'x_aia.193.cr2219.ri.00-ro1.02_rmax1.3_nrad_30_hollow.diego_l0.3'
  xmodel_type = 'Tomography'
  
  orig_file_array  = 'orig_'+          strmid(orig_image_array,0,strlen(orig_image_array[0])-3)+'dat'
  comp_file_array  = 'comp_'+xfile+'_'+strmid(orig_image_array,0,strlen(orig_image_array[0])-3)+'dat'
  
  Nx = 1024
  Ny = 1024
  factor_image=0.5
  instrument = 'aia'
  R1 = 1.02
  R2 = 1.25

  N_images=n_elements(orig_image_array)
  
for i=0,n_images-1 do begin
     data_dir   = 'aia/CR2219/193/'
     orig_image = orig_image_array[i]
     orig_file  = orig_file_array [i]
     comp_file  = comp_file_array [i]
  xcompare_origcomp,orig_image=orig_image,orig_file=orig_file,comp_file=comp_file,Nx=Nx,Ny=Ny,data_dir=data_dir,factor_image=factor_image,factor_unit=factor_unit,win=win,instrument=instrument,/log,/record,R1=R1,R2=R2,xmodel_type=xmodel_type
  endfor
  return
end

pro wrapper_c2

  orig_image_array = ['20190626UT150155_23759824pB_prep.fts',$
                      '20190701UT145410_23760472pB_prep.fts',$
                      '20190707UT150155_23761193pB_prep.fts']

  xfile = 'x_LASCOC2pB_CR2219_24hr-Cadence_Rmin2.25_Rmax8.25_IRmin2.5_IRmax6.0_60x60x120_BF4_r3D_l1.e-5'
 ;xfile = 'x_LASCOC2pB_CR2219_24hr-Cadence_Rmin2.25_Rmax8.25_IRmin2.5_IRmax6.0_60x60x120_BF4_r3D_l1.e-4'
 ;xfile = 'x_LASCOC2pB_CR2219_24hr-Cadence_Rmin2.5_Rmax8.5_IRmin2.5_IRmax6.0_60x60x120_BF4_r3D_l1.e-5'
 ;xfile = 'x_LASCOC2pB_CR2219_24hr-Cadence_Rmin2.5_Rmax8.5_IRmin2.5_IRmax6.0_60x60x120_BF4_r3D_l1.e-4'
  xmodel_type = 'Tomography'
  
  orig_file_array  = 'orig_'+          strmid(orig_image_array,0,strlen(orig_image_array[0])-3)+'dat'
  comp_file_array  = 'comp_'+xfile+'_'+strmid(orig_image_array,0,strlen(orig_image_array[0])-4)+'_pB.dat'
  
  Nx = 512
  Ny = 512
  factor_image=1
  instrument = 'lascoc2'
  R1 = 2.5
  R2 = 6.0

  N_images=n_elements(orig_image_array)

  for i=0,n_images-1 do begin
     data_dir   = 'c2/CR2219/'
     orig_image = orig_image_array[i]
     orig_file  = orig_file_array [i]
     comp_file  = comp_file_array [i]
  xcompare_origcomp,orig_image=orig_image,orig_file=orig_file,comp_file=comp_file,Nx=Nx,Ny=Ny,data_dir=data_dir,factor_image=factor_image,factor_unit=factor_unit,win=win,instrument=instrument,/log,/record,R1=R1,R2=R2,xmodel_type=xmodel_type
  endfor
  return
end

pro wrapper_kcor

  orig_image_array = ['20171203_174921_kcor_l1.5_extavg_prep.fts',$
                      '20171209_182006_kcor_l1.5_extavg_prep.fts',$
                      '20171215_175739_kcor_l1.5_extavg_prep.fts']

  xfile       = 'x_KCOR.CR2198.13imgs-reduced.bf2.ri1.05.ro2.25_Inst_1.09_2.00_120_90_180_dropneg_r3D_l1e-4'
  xmodel_type = 'Tomography'
  
  orig_file_array  = 'orig_'+          strmid(orig_image_array,0,strlen(orig_image_array[0])-3)+'dat'
  comp_file_array  = 'comp_'+xfile+'_'+strmid(orig_image_array,0,strlen(orig_image_array[0])-3)+'dat'

  Nx = 1024
  Ny = 1024
  factor_image=0.5
  instrument = 'kcor'
  R1 = 1.1
  R2 = 2.0

  N_images=n_elements(orig_image_array)

for i=0,n_images-1 do begin
     data_dir   = 'kcor/CR2198/10MinAvg/'
     orig_image = orig_image_array[i]
     orig_file  = orig_file_array [i]
     comp_file  = comp_file_array [i]
  xcompare_origcomp,orig_image=orig_image,orig_file=orig_file,comp_file=comp_file,Nx=Nx,Ny=Ny,data_dir=data_dir,factor_image=factor_image,factor_unit=factor_unit,win=win,instrument=instrument,/log,/record,R1=R1,R2=R2,xmodel_type=xmodel_type
  endfor
  return
end

pro xcompare_origcomp,tomroot=tomroot,data_dir=data_dir,orig_image=orig_image,orig_file=orig_file,comp_file=comp_file,Nx=Nx,Ny=Ny,instrument=instrument,$
                     factor_image=factor_image,factor_unit=factor_unit,win=win,log=log,record=record,R1=R1,R2=R2,xmodel_type=xmodel_type

  if not keyword_set(R1) or not keyword_set(R2) then begin
     print,'Please specify occulters radii R1 and R2'
     return
  endif
  
  if not keyword_set(factor_unit)  then factor_unit  = 1.
  if not keyword_set(factor_image) then factor_image = 1.
  if not keyword_set(win)          then win          = 0.
  
 ;Set all required directories
  if not keyword_set(tomroot) then tomroot = '/data1/'
  origcomp_dir = tomroot+'tomography/bindata/Compare/'
      data_dir = tomroot+'tomography/DATA/'+data_dir

 ;Load into memory the original fitsfile
  mreadfits,data_dir+orig_image,hdr,Img
  compute_image_grid,hdr=hdr,ra=ra,pa=pa,x=x,y=y,instrument=instrument

 ; Fix UNITS as needed. Use same factors coded in compare.c and build_subA.c
 if instrument eq 'kcor'    then Img=Img*1.e10
 if instrument eq 'lascoc2' then Img=Img*0.79
 
 ;Load into memory the original and compare images
  Io = fltarr(Nx,Ny)
  Ic = fltarr(Nx,Ny)
  openr,1,origcomp_dir+orig_file
  readu,1,Io
  close,1
  openr,1,origcomp_dir+comp_file
  readu,1,Ic
  close,1
  Io = rotate(Io,4)
  Ic = rotate(Ic,4)

 ; Scale images
  Nx2  = Nx*factor_image
  Ny2  = Ny*factor_image
  Img2 = congrid(Img,Nx2,Ny2)
  Io2  = congrid(Io ,Nx2,Ny2)
  Ic2  = congrid(Ic ,Nx2,Ny2)
  ra2  = congrid(ra ,Nx2,Ny2)

 ; Set up suitable mini/maxi for display
  p=where(ra2 gt R1 and ra2 le R2 and Img2 gt 0.)
  mini=min(Img2(p))
  maxi=max(Img2(p))
  mini=median(Img2(p))/10.
  maxi=median(Img2(p))*50.

 ;Force mini/maxi
  Img2(0,0:1)=[mini,maxi]
  Io2 (0,0:1)=[mini,maxi]
  Ic2 (0,0:1)=[mini,maxi]
  Img2 = Img2 > mini < maxi
  Io2  = Io2  > mini < maxi
  Ic2  = Ic2  > mini < maxi

; Apply log scale if requested
  if keyword_set(log) then begin
  Img2 = alog10(Img2)
  Io2  = alog10(Io2)
  Ic2  = alog10(Ic2)
  endif

 ;Apply occulters
  p       = where(ra2 lt R1 OR ra2 gt R2)
  if NOT keyword_set(log) then begin
  Img2(p) = 0.
  Io2 (p) = 0.
  Ic2 (p) = 0.
  endif
  if     keyword_set(log) then begin
  Img2(p) = alog10(mini)
  Io2 (p) = alog10(mini)
  Ic2 (p) = alog10(mini)
  endif

;-------------------------------------------------------
  ;Display images

  ; Display original inage from FITS file as a reference
  loadct,39
  window,win,xs=Nx2,ys=Ny2
  tvscl,Img2

  ;---create over-sized window with white background----------------
  xsimage = Nx2
  ysimage = Ny2
  DX      = xsimage/2
  DY      = ysimage/4
  x0      = DX/4
  y0      = DY/2
  window,win+1,xs=2*xsimage+DX,ys=ysimage+DY
  loadct,27
  tvscl,fltarr(2*xsimage+DX,ysimage+DY)

  ; Display ORIG and COMP images
  loadct,39
  frame=10
  black = fltarr(Nx2+frame,Ny2+frame)
  tvscl,black,x0-frame/2,y0-frame/2
  tvscl,Io2,x0,y0
  deltaX = Nx2+Dx/10
  tvscl,black,x0+deltaX-frame/2,y0-frame/2  
  tvscl,Ic2,x0+deltaX,y0

;---PUT COLOR SCALE BAR---------------------------------------------------------
  if     keyword_set(log) then begin
  logmini = alog10(mini)
  logmaxi = alog10(maxi)
  endif
  
  nsy= Ny2
  nsx= Dx/5

  black = fltarr(Nsx+frame,Nsy+frame)
  scale = fltarr(nsx,nsy)

  if     keyword_set(log) then for ix=0,nsx-1 do scale(ix,*)=logmini+(logmaxi-logmini)*findgen(nsy)/float(nsy-1)
  if NOT keyword_set(log) then for ix=0,nsx-1 do scale(ix,*)=   mini+(   maxi-   mini)*findgen(nsy)/float(nsy-1)

  xs0 = x0 + 2*xsimage + DX/2
  ys0 = y0
  tvscl,black,xs0-frame/2,ys0-frame/2    
  tvscl,scale,xs0,ys0

  csize = 4
  loadct,0
  contour,scale,findgen(nsx),reform(scale(0,*)),$
              pos=[xs0,ys0,xs0+nsx,ys0+nsy],/device,color=0,/noerase,$
              yticklen=.2,/nodata,ythick=2,xthick=2,charthick=4,$
              xstyle=5,ystyle=1,charsize=csize,font=1

  if NOT keyword_set(log) then label = 'I'
  if     keyword_set(log) then label = 'Log(I)'
  xyouts,[xs0-Dx/8],[ys0+ysimage+DY/5],[label],$
         color=0,charsize=csize,charthick=4,font=1,/device


;--------------------------------------------------------------------------------------
; Place information around images
if instrument eq 'kcor' then begin
  xyouts,x0+[0,deltaX],(y0+ysimage+DY/5)*[1,1],$
         ['KCOR Image','Synthetic '+xmodel_type+' Image'],$
         color=0,charsize=4,charthick=4,font=1,/device

  xyouts,[x0],[y0-DY/3],['DATE_OBS: '+hdr.DATE_OBS],$
         color=0,charsize=4,charthick=4,font=1,/device
endif

if instrument eq 'lascoc2' then begin
  xyouts,x0+[0,deltaX],(y0+ysimage+DY/5)*[1,1],$
         ['LASCO-C2 Image','Synthetic '+xmodel_type+' Image'],$
         color=0,charsize=4,charthick=4,font=1,/device

  xyouts,[x0],[y0-DY/3],['DATE_OBS: '+hdr.DATE_OBS+'UT'+hdr.TIME_OBS],$
         color=0,charsize=4,charthick=4,font=1,/device
endif

if instrument eq 'aia' then begin
  xyouts,x0+[0,deltaX],(y0+ysimage+DY/5)*[1,1],$
         ['AIA-'+strmid(string(hdr.wavelnth),9,3)+' Image','Synthetic '+xmodel_type+' Image'],$
         color=0,charsize=4,charthick=4,font=1,/device

  xyouts,[x0],[y0-DY/3],['DATE_OBS: '+hdr.T_OBS],$
         color=0,charsize=4,charthick=4,font=1,/device
endif

;--------------------------------------------------------------------------------------
  ; Record image
  outdir   = data_dir
  filename = comp_file+'.gif'
  if keyword_set(record) then record_gif,outdir,filename,'X'
  
;-------------------------------------------------------------------------------------
; Make histogram of the ratio Ic/Io over pixels within [R1,R2] and
; characterized by Io>0.
  ratio = Ic/Io
  i     = where(ra gt R1 and ra lt R2 and Io gt 0.)
  ratio_data = reform(ratio(i)) 
  pdf = HISTOGRAM(ratio_data, Nbins=50, LOCATIONS=xbin) / float(n_elements(ratio_data))
  !p.charsize=1
  archivo=outdir+comp_file+'_histogram.eps'
  set_plot,'ps'
  loadct,0
  device,filename=archivo,bits_per_pixel=8,/color,/encapsulated
  plot,xbin,pdf,psym=10,xstyle=1,xtitle='I!DSYNTH!N / I!DDATA!N',ytitle='Frequency',title='Frequency Histogram',font=0,charsize=1.5,th=4
  xyouts,0.6*[1,1],0.5+[0.35,0.30],['Median = '+string(median(ratio_data)),'StDev  = '+string(stdev(ratio_data))],/normal,font=0,charsize=1
  device,/close
  set_plot,'x'

  return
end
