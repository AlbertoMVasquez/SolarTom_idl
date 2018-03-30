
pro comp_euvi,b171=b171,b195=b195,b284=b284,solution=solution
  common euv_stuff,model
  
  if keyword_set(solution) eq 0 OR solution gt 3 then begin
     print,'Please provide a known solution.'
     return
  endif

  if keyword_set(b171) then begin
     if solution eq 1 then model = 'x_euvi.A.171.cr2081.26x90_bf2_ri.98_ro1.025_l0.35_NODECON_ureg'
     if solution eq 2 then model = 'x_euvi.A.171.cr2081.26x90_bf4_ri.98_ro1.025_l0.75_NODECON_nalai'
     if solution eq 3 then model = 'x_euvi_A171_b4_nodecon_100_90_180_Rmax2.0_InstrRmax1.5_bf4'
     data_subdir = 'euvi/CR2081/A171/'
     compare_dir = '/data1/tomography/bindata/Compare/'
       data_file = '/list.A171.b4.nodecon.test'
    endif
  
   if keyword_set(b195) then begin
     if solution eq 1 then model = 'x_euvi.A.195.cr2081.26x90_bf4_ri.98_ro1.025_l0.35_NODECON_ureg'
     if solution eq 2 then model = 'x_euvi.A.195.cr2081.26x90_bf4_ri.98_ro1.025_l0.75_NODECON_nalai'
     if solution eq 3 then model = 'x_euvi_A195_b4_nodecon_100_90_180_Rmax2.0_InstrRmax1.5_bf4'
     data_subdir = 'euvi/CR2081/A195/'
     compare_dir = '/data1/tomography/bindata/Compare/'
       data_file = '/list.A195.b4.nodecon.test'
    endif
  
   if keyword_set(b284) then begin
     if solution eq 1 then model = 'x_euvi.A.284.cr2081.26x90_bf4_ri.98_ro1.025_l0.35_NODECON_ureg'
     if solution eq 2 then model = 'x_euvi.A.284.cr2081.26x90_bf4_ri.98_ro1.025_l0.75_NODECON_nalai'
     if solution eq 3 then model = 'x_euvi_A284_b4_nodecon_100_90_180_Rmax2.0_InstrRmax1.5_bf4'
     data_subdir = 'euvi/CR2081/A284/'
     compare_dir = '/data1/tomography/bindata/Compare/'
       data_file = '/list.A284.b4.nodecon.test'
    endif

               N = 0
               x = ''
  openr, 2, '/data1/tomography/DATA/' + data_subdir + data_file
  readf, 2, N
  orig_image_a = strarr(N)
  orig_file_a  = strarr(N)
  comp_file_a  = strarr(N)
  factor_unit  = 1.0
  for i=0,N-1 do begin
     readf, 2, x
     orig_image_a[i] = x
     orig_file_a [i] = 'orig_'               + strmid(x,0,strlen(x)-4) + '.dat' 
     comp_file_a [i] = 'comp_' + model + '_' + strmid(x,0,strlen(x)-4) + '.dat'
     compare_euv, $
        orig_image = orig_image_a[i],$
        orig_file  =  orig_file_a[i],$
        comp_file  =  comp_file_a[i],$
        data_dir   = data_subdir , winn = 0, factor_unit = factor_unit, /compare3
  endfor
  close,2
end

pro comp_kcor
  ;        model = 'x_KCOR.CR2198.13imgs.bf4.50_30_60_l1e-5_V2'
  ;        model = 'x_KCOR.CR2198.13imgs.bf4.50_30_60_l1e-5'
  ;        model = 'x_KCOR.CR2198.13imgs.bf4.50_90_180_l1e-5'
  ;        model = 'x_KCOR.CR2198.13imgs.bf2.295_45_90_l1e-5'
  ;        model = 'x_KCOR.CR2198.13imgs.bf1.295_90_180_l1e-5'
  ;        model = 'x_KCOR.CR2198.13imgs.bf2.295_90_180_l1e-5'
           model = 'x_KCOR.CR2198.13imgs.bf2.295_90_180_l1e-5_CORRECTED'

     data_subdir = 'kcor/CR2198/'
     compare_dir = '/data1/tomography/bindata/Compare/'
       data_file = 'list_prep_test.txt'
               N = 0
               x = ''
  openr, 2, '/data1/tomography/DATA/' + data_subdir + data_file
  readf, 2, N
  orig_image_a = strarr(N)
  orig_file_a  = strarr(N)
  comp_file_a  = strarr(N)
  factor_unit  = 1.0
  for i=0,N-1 do begin
     readf, 2, x
     orig_image_a[i] = x
     orig_file_a [i] = 'orig_'               + strmid(x,0,strlen(x)-4) + '.dat' 
     comp_file_a [i] = 'comp_' + model + '_' + strmid(x,0,strlen(x)-4) + '.dat'
     compare_lascoc2, $
        orig_image = orig_image_a[i],$
        orig_file  =  orig_file_a[i],$
        comp_file  =  comp_file_a[i],$
        data_dir   = data_subdir , winn = 0, factor_unit = factor_unit, /compare3
  endfor
  close,2
end

pro comp_lam
          ;model = 'x_AWSOM_CR2081run5_WISPR_sphere_2.dat'
          ;model = 'x_AWSOM_CR2081run5_sphere_custom1.dat'
           model = 'x_AWSOM_CR2082_LASCOC2_custom1.dat'
     data_subdir = 'c2/CR2082/'
     compare_dir = '/data1/tomography_dev/bindata/Compare/'
       data_file = 'list.txt'
               N = 0
               x = ''
  openr, 2, '/data1/tomography/DATA/' + data_subdir + data_file
  readf, 2, N
  orig_image_a = strarr(N)
  orig_file_a  = strarr(N)
  comp_file_a  = strarr(N)
  factor_unit  = 0.79
  for i=0,N-1 do begin
     readf, 2, x
     orig_image_a[i] = x
     orig_file_a [i] = 'orig_'               + strmid(x,0,strlen(x)-4) + '.dat' 
     comp_file_a [i] = 'comp_' + model + '_' + strmid(x,0,strlen(x)-4) + '_pB.dat'
     compare_lascoc2, $
        orig_image = orig_image_a[i],$
        orig_file  =  orig_file_a[i],$
        comp_file  =  comp_file_a[i],$
        data_dir   = data_subdir , winn = i, factor_unit = factor_unit, /compare3
;     stop
  endfor
  close,/all
end

pro comp4

  compare_lascoc2,  orig_image='C2-PB-20020707_1644.fts',$
                    orig_file ='orig_C2-PB-20020707_1644.dat',$
                    comp_file ='comp_x_AWSOM_CR2081run5_WISPR_sphere_2.dat_C2-PB-20020707_1644.dat',$
                    data_dir  ='c2/pB_2002_highFreq/', winn=0

  compare_lascoc2,  orig_image='C2-PB-20020714_1244.fts',$
                    orig_file ='orig_C2-PB-20020714_1244.dat',$
                    comp_file ='comp_x_AWSOM_CR2081run5_WISPR_sphere_2.dat_C2-PB-20020714_1244.dat',$
                    data_dir  ='c2/pB_2002_highFreq/', winn=1

  compare_lascoc2,  orig_image='C2-PB-20020721_1644.fts',$
                    orig_file ='orig_C2-PB-20020721_1644.dat',$
                    comp_file ='comp_x_AWSOM_CR2081run5_WISPR_sphere_2.dat_C2-PB-20020721_1644.dat',$
                    data_dir  ='c2/pB_2002_highFreq/', winn=2

  compare_lascoc2,  orig_image='C2-PB-20020726_1644.fts',$
                    orig_file ='orig_C2-PB-20020726_1644.dat',$
                    comp_file ='comp_x_AWSOM_CR2081run5_WISPR_sphere_2.dat_C2-PB-20020726_1644.dat',$
                    data_dir  ='c2/pB_2002_highFreq/', winn=3
end

pro compare_euv,orig_image=orig_image,orig_file=orig_file,comp_file=comp_file,data_dir=data_dir,winn=winn,compare3=compare3,factor_unit=factor_unit
  Nx=1024
  Ny=1024
  factor_image=1
 ;factor_unit = 1.e10*0.79
  if NOT keyword_set(compare3)  then $
  compare_orig_comp,orig_image=orig_image,orig_file=orig_file,comp_file=comp_file,Nx=Nx,Ny=Ny,data_dir=data_dir,factor_image=factor_image,factor_unit=factor_unit,winn=winn
  if     keyword_set(compare3) then $
  compare_orig_comp,orig_image=orig_image,orig_file=orig_file,comp_file=comp_file,Nx=Nx,Ny=Ny,data_dir=data_dir,factor_image=factor_image,factor_unit=factor_unit,winn=winn,/compare3,/record,/euv,/log
end

; compare_lascoc2,  orig_image='C2-PB-20070416_2100.fts',  orig_file ='orig_C2-PB-20070416_2100.dat',  comp_file ='comp_x_AWSOM_CR2081run5_WISPR_sphere_2.dat_C2-PB-20070416_2100.dat',  data_dir  ='c2/2007.04/'
pro compare_lascoc2,orig_image=orig_image,orig_file=orig_file,comp_file=comp_file,data_dir=data_dir,winn=winn,compare3=compare3,factor_unit=factor_unit
  Nx=512;1024
  Ny=512;1024
  factor_image=0.5
 ;factor_unit = 1.e10*0.79
  if NOT keyword_set(compare3)  then $
  compare_orig_comp,orig_image=orig_image,orig_file=orig_file,comp_file=comp_file,Nx=Nx,Ny=Ny,data_dir=data_dir,factor_image=factor_image,factor_unit=factor_unit,winn=winn
  if     keyword_set(compare3) then $
  compare_orig_comp,orig_image=orig_image,orig_file=orig_file,comp_file=comp_file,Nx=Nx,Ny=Ny,data_dir=data_dir,factor_image=factor_image,factor_unit=factor_unit,winn=winn,/compare3,/record,/pB,/log,/lasco_awsom;/kcor
end

; compare_wispr,orig_image='WISPR_I_2025-06-13T22:00:00_squareFOV_binfac4_Blank.fts'
; compare_wispr,orig_image='WISPR_I_2025-06-14T22:00:00_squareFOV_binfac4_Blank.fts'
; compare_wispr,orig_image='WISPR_I_2025-06-15T22:00:00_squareFOV_binfac4_Blank.fts'

; movie,input_file='list.wisprI.512.Orbit01.txt',data_dir='wisprI/',table_file='table.Orbit01.short.txt',/pB
; movie,input_file='list.wisprI.512.Orbit12.txt',data_dir='wisprI/',table_file='table.Orbit12.short.txt',/pB
; movie,input_file='list.wisprI.512.Orbit24.txt',data_dir='wisprI/',table_file='table.Orbit24.short.txt',/pB

; movie,input_file='list.wisprI.512.Orbit01.txt',data_dir='wisprI/',table_file='table.Orbit01.short.txt',/BK
; movie,input_file='list.wisprI.512.Orbit12.txt',data_dir='wisprI/',table_file='table.Orbit12.short.txt',/BK
; movie,input_file='list.wisprI.512.Orbit24.txt',data_dir='wisprI/',table_file='table.Orbit24.short.txt',/BK

; movie,input_file='list.wisprO.512.Orbit01.txt',data_dir='wisprO/',table_file='table.Orbit01.short.txt',/BK
; movie,input_file='list.wisprO.512.Orbit12.txt',data_dir='wisprO/',table_file='table.Orbit12.short.txt',/BK
; movie,input_file='list.wisprO.512.Orbit24.txt',data_dir='wisprO/',table_file='table.Orbit24.short.txt',/BK

; movie,input_file='list.wisprI.512.CircularOrbit01.txt',data_dir='wisprI/',table_file='table.CircularOrbit01.short.txt',/BK
; movie,input_file='list.wisprO.512.CircularOrbit01.txt',data_dir='wisprO/',table_file='table.CircularOrbit01.short.txt',/BK

; movie,input_file='list.wisprI.512.CircularOrbit01_OffEq.txt',data_dir='wisprI/',table_file='table.CircularOrbit01_OffEq.short.txt',/BK
; movie,input_file='list.wisprO.512.CircularOrbit01_OffEq.txt',data_dir='wisprO/',table_file='table.CircularOrbit01_OffEq.short.txt',/BK

; movie,input_file='list.test.txt',data_dir='wisprI/',table_file='table.test.txt',/BK
; movie,input_file='list.test2.txt',data_dir='wisprI/',table_file='table.test2.txt',/BK

; movie,input_file='list.wisprI.Blank.CR2081.UnifLong.ExtOrb01.txt',data_dir='wisprI/CR2081_UnifLong/',model_file='x_AWSOM_CR2081run5_WISPR_sphere.dat',table_file='table.UnifLong.ExtOrbit.01.txt',/BK
; movie,input_file='list.wisprO.Blank.CR2081.UnifLong.ExtOrb01.txt',data_dir='wisprO/CR2081_UnifLong/',table_file='table.UnifLong.ExtOrbit.01.txt',/BK

; movie,input_file='list.wisprI.Blank.CR2081.UnifLong.ExtOrb12.txt',data_dir='wisprI/CR2081_UnifLong/',table_file='table.UnifLong.ExtOrbit.12.txt',/BK
; movie,input_file='list.wisprO.Blank.CR2081.UnifLong.ExtOrb12.txt',data_dir='wisprO/CR2081_UnifLong/',table_file='table.UnifLong.ExtOrbit.12.txt',/BK

; movie,input_file='list.wisprI.Blank.CR2081.UnifLong.ExtOrb24.txt',data_dir='wisprI/CR2081_UnifLong/',table_file='table.UnifLong.ExtOrbit.24.txt',/BK
; movie,input_file='list.wisprO.Blank.CR2081.UnifLong.ExtOrb24.txt',data_dir='wisprO/CR2081_UnifLong/',table_file='table.UnifLong.ExtOrbit.24.txt',/BK

; movie,input_file='list.wisprI.circular.txt',data_dir='wisprI/Circular/',table_file='table_spp_orbits_short_squareFOV_binfac4.CircularOrbits3degUnifStep_.dat',/BK
; movie,input_file='list.wisprO.circular.txt',data_dir='wisprO/Circular/',table_file='table_spp_orbits_short_squareFOV_binfac4.CircularOrbits3degUnifStep_.dat',/BK

; CR2082:

; movie,input_file='list.wisprI.Blank.CR2082.UnifLong.ExtOrb01.txt',data_dir='wisprI/CR2082_UnifLong/',model_file='x_AWSOM_CR2082_sphere_WISPR.dat',table_file='table.UnifLong.ExtOrbit.01.UPDATED-POINTINGS.txt',/BK
; movie,input_file='list.wisprO.Blank.CR2082.UnifLong.ExtOrb01.txt',data_dir='wisprO/CR2082_UnifLong/',model_file='x_AWSOM_CR2082_sphere_WISPR.dat',table_file='table.UnifLong.ExtOrbit.01.UPDATED-POINTINGS.txt',/BK

; movie,input_file='list.wisprI.circular.txt',data_dir='wisprI/Circular_CR2082/',model_file='x_AWSOM_CR2082_sphere_WISPR.dat',table_file='table.CircularOrbit01.short.UPDATED-POINTINGS.txt',/BK
; movie,input_file='list.wisprO.circular.txt',data_dir='wisprO/Circular_CR2082/',model_file='x_AWSOM_CR2082_sphere_WISPR.dat',table_file='table.CircularOrbit01.short.UPDATED-POINTINGS.txt',/BK

; movie,input_file='list.wisprI.Blank.CR2082.UnifLong.ExtOrb24.txt',data_dir='wisprI/CR2082_UnifLong/',model_file='x_AWSOM_CR2082_sphere_WISPR.dat',table_file='table.UnifLong.ExtOrbit.24.UPDATED-POINTINGS.txt',/BK
; movie,input_file='list.wisprO.Blank.CR2082.UnifLong.ExtOrb24.txt',data_dir='wisprO/CR2082_UnifLong/',model_file='x_AWSOM_CR2082_sphere_WISPR.dat',table_file='table.UnifLong.ExtOrbit.24.UPDATED-POINTINGS.txt',/BK


;;
; IMPORTANT NOTES on the "movie" tool:
;
; The "input_file" must contain the list of BLANK images generated by
; wispr_tool.pro. The file and the images must be located in:
; $tomroot/DATA/data_dir/
;
; The "orig*" and "comp*" images, generated by compare.c, must be located in:
; $tomroot/bindata/Compare/
;
; The "table_file", containing the ephemeris table generated by
; "wispr_tool.pro", in its "short" version and with the first 4 lines
; of header, must be located in:
; /data1/work/SPP/SORBET_VIZZER_WISPR_RevA/
;
; The "model_file" is the filename of the model used to run compare.c,
; which is located in $tomroot/bindata/
;
;;
pro movie,input_file=input_file,data_dir=data_dir,table_file=table_file,model_file=model_file,pB=pB,BK=BK
common ephemeris,orbit,date,time,dsun_rsun,dsun_au,lon,lat,WIEHH,WIWHH,WOEHH,WOWHH,data_string
  openr,3,'/data1/work/SPP/SORBET_VIZZER_WISPR_RevA/'+table_file
  x=''
  data_string=''
  orbit=0
  date=''
  time=''
  dsun_rsun=0.
  dsun_au=0.
  lon=0.
  lat=0.
  WIEHH=0.
  WIWHH=0.
  WOEHH=0.
  WOWHH=0.
  for i=1,4 do readf,3,x  
  N=0
  orig_image=''
  openr,2,'/data1/tomography_dev/DATA/'+data_dir+input_file
  readf,2,N
  for i=0,N-1 do begin
;    readf,3,orbit,date,time,dsun_rsun,dsun_au,lon,lat,WIEHH,WIWHH,WOEHH,WOWHH
     readf,3,data_string
     readf,2,orig_image
     if keyword_set(BK) then compare_wispr,orig_image=orig_image,data_dir=data_dir,model_file=model_file,/BK
     if keyword_set(pB) then compare_wispr,orig_image=orig_image,data_dir=data_dir,model_file=model_file,/pB
  endfor
  close,/all
end

pro compare_wispr,orig_image=orig_image,data_dir=data_dir,model_file=model_file,pB=pB,BK=BK

  model     = model_file
 ;model     = 'x_AWSOM_CR2081run5_WISPR_sphere_2.dat'
 ;model     = 'x_AWSOM_CR2081run5_sphere_custom1.dat'
  
  orig_file = 'orig_'          +strmid(orig_image,0,strlen(orig_image)-4)+'.dat'
  if keyword_set(pB) then begin
     comp_file = 'comp_'+model+'_'+strmid(orig_image,0,strlen(orig_image)-4)+'.dat'
     comp_gif  = 'comp_'+model+'_'+strmid(orig_image,0,strlen(orig_image)-4)+'_pB.gif'
  endif
  if keyword_set(BK) then begin
     comp_file = 'comp_'+model+'_'+strmid(orig_image,0,strlen(orig_image)-4)+'_BK.dat'
     comp_gif  = 'comp_'+model+'_'+strmid(orig_image,0,strlen(orig_image)-4)+'_BK.gif'
  endif
     
  Nx= 512 & Ny= 512 & Delta= 32 & factor_image = .5
 ;Nx=2048 & Ny=2048 & Delta=128 & factor_image = 2.

  if keyword_set(BK) then $
  compare_orig_comp,orig_image=orig_image,orig_file=orig_file,comp_file=comp_file,Nx=Nx,Ny=Ny,factor_image=factor_image,Delta=Delta,/record,comp_gif=comp_gif,/create_FITS_for_tom,data_dir=data_dir,/BK,/log,/wispr

  if keyword_set(pB) then $
  compare_orig_comp,orig_image=orig_image,orig_file=orig_file,comp_file=comp_file,Nx=Nx,Ny=Ny,factor_image=factor_image,Delta=Delta,/record,/crop,comp_gif=comp_gif,/create_FITS_for_tom,data_dir=data_dir,/pB,/log
  
end

pro compare_orig_comp,tomroot=tomroot,data_dir=data_dir,orig_image=orig_image,orig_file=orig_file,comp_file=comp_file,Nx=Nx,Ny=Ny,factor_image=factor_image,factor_unit=factor_unit,crop_image=crop_image,compare3=compare3,winn=winn,Delta=Delta,record=record,comp_gif=comp_gif,create_FITS_for_tom=create_FITS_for_tom,BK=BK,pB=pB,euv=euv,kcor=kcor,lasco_awsom=lasco_awsom,wispr=wispr,log=log

common ephemeris,orbit,date,time,dsun_rsun,dsun_au,lon,lat,WIEHH,WIWHH,WOEHH,WOWHH,data_string
common euv_stuff,model

  if not keyword_set(factor_unit) then factor_unit = 1.
  
  if not keyword_set(tomroot) then tomroot = '/data1/'
  input_dir = tomroot+'tomography/bindata/Compare/'

 ;if keyword_set(pB) then input_dir = input_dir + 'pB/'
  
 ;if not keyword_set(data_dir) then data_dir='wisprI/'
  input_data_dir = tomroot+'tomography/DATA/'+data_dir

  Io = fltarr(Nx,Ny)
  Ic = fltarr(Nx,Ny)

  openr,1,input_dir+comp_file
  readu,1,Ic
  close,1
  openr,1,input_dir+orig_file
  readu,1,Io
  close,1

  Io = rotate(Io,4)
  Ic = rotate(Ic,4)  
                                ;if keyword_set(compare3) then
  mreadfits,input_data_dir+orig_image,hdr,img

  Io = Io / factor_unit
  Ic = Ic / factor_unit

  if keyword_set(create_FITS_for_tom) then begin
     if keyword_set(BK) then newfilename = strmid(orig_image,0,strlen(orig_image)-9)+'Synth.BK.fts'
     if keyword_set(pB) then newfilename = strmid(orig_image,0,strlen(orig_image)-9)+'Synth.pB.fts'
     mwritefits,hdr,Ic,outfile=input_data_dir+newfilename
  endif
  
  if not keyword_set(factor_image) then factor_image=1.

 ;if keyword_set(compare3) then $
  img2= congrid(img,Nx/factor_image,Ny/factor_image)
  Io2 = congrid(Io ,Nx/factor_image,Ny/factor_image)
  Ic2 = congrid(Ic ,Nx/factor_image,Ny/factor_image)

 ;Set suitable mini and maxi values for the images
  po = where(Io  gt 0.)
  pc = where(Ic  gt 0.)

  if keyword_set(wispr) then begin
    mini =      min(Ic(pc))
    maxi =      max(Ic(pc))
 endif
  
  if keyword_set(kcor) or keyword_set(lasco_awsom) then begin
     mini = min([min(Io(po)),min(Ic(pc))])
     maxi = max([max(Io(po)),max(Ic(pc))])
     medo = median(Io(po))
     medc = median(Ic(pc))
     correction = medo/medc
     correction = 0.15
     print,'Correction:',correction
     Ic2        = Ic2*correction     
  endif
  if keyword_set(euv) then begin
     mini = min([median(Io(po)),median(Ic(pc))])/500.
     maxi = max(Io(po))
  endif

if keyword_set(compare3) then begin
 ;Force all images to have same mini and maxi
  Img2([0,1],0) = [mini,maxi]
   Io2([0,1],0) = [mini,maxi]
   Ic2([0,1],0) = [mini,maxi]
  Img2 = Img2 > mini < maxi
   Io2 =  Io2 > mini < maxi
   Ic2 =  Ic2 > mini < maxi

 ;An option for WISPR only
  if keyword_set(crop_image) then crop,img2,Io2,Ic2,Nx,Ny,Delta,factor_image

 goto,skip_this
  loadct,39
  window,winn,xs=3*Nx/factor_image,ys=Ny/factor_image
  tvscl,alog10(img2),0
  tvscl,alog10( Io2),1
  tvscl,alog10( Ic2),2
  stop 
 skip_this:

;---create over-sized window with white background----------------
  xsimage = Nx/factor_image
  ysimage = Ny/factor_image
  DX      = xsimage/2
  DY      = ysimage/4
  x0      = DX/4
  y0      = DY/2
  window,winn,xs=2*xsimage+DX,ys=ysimage+DY
  loadct,27
  tvscl,fltarr(2*xsimage+DX,ysimage+DY)

;-------------------------------------------------------
;Display images

  ; Load a convenient color scale
  if keyword_set(euv) then begin
     if hdr.detector eq 'EUVI' then eit_colors,hdr.WAVELNTH
  endif
  if keyword_set(kcor) or keyword_set(lasco_awsom) then begin
     loadct,39
  endif

  frame=10
  black = fltarr(Nx/factor_image+frame,Ny/factor_image+frame)
  tvscl,black,x0-frame/2,y0-frame/2
  if     keyword_set(log) then tvscl,alog10( Io2),x0,y0
  if NOT keyword_set(log) then tvscl,      ( Io2),x0,y0
  deltaX = Nx/factor_image+Dx/10
  tvscl,black,x0+deltaX-frame/2,y0-frame/2  
  if     keyword_set(log) then tvscl,alog10( Ic2),x0+deltaX,y0
  if NOT keyword_set(log) then tvscl,      ( Ic2),x0+deltaX,y0
;---PUT COLOR SCALE BAR---------------------------------------------------------
  if     keyword_set(log) then begin
  logmini = alog10(mini)
  logmaxi = alog10(maxi)
  endif
  
  nsy= Ny/factor_image
  nsx= Dx/5

  black = fltarr(Nsx+frame,Nsy+frame)
  scale = fltarr(nsx,nsy)

  if     keyword_set(log) then for ix=0,nsx-1 do scale(ix,*)=logmini+(logmaxi-logmini)*findgen(nsy)/float(nsy-1)
  if NOT keyword_set(log) then for ix=0,nsx-1 do scale(ix,*)=   mini+(   maxi-   mini)*findgen(nsy)/float(nsy-1)

  xs0 = x0 + 2*xsimage + DX/3
  ys0 = y0
  tvscl,black,xs0-frame/2,ys0-frame/2    
  tvscl,scale,xs0,ys0

  loadct,0
  contour,scale,findgen(nsx),reform(scale(0,*)),$
              pos=[xs0,ys0,xs0+nsx,ys0+nsy],/device,color=0,/noerase,$
              yticklen=.2,/nodata,ythick=2,xthick=2,charthick=4,$
              xstyle=5,ystyle=1,charsize=5,font=1

 if keyword_set(pB) then $
  xyouts,[xs0-Dx/10],[ys0+ysimage+DY/10],['Log!d10!N(p!DB!N)'],$
         color=0,charsize=5,charthick=4,font=1,/device

 if keyword_set(euv) then $
  xyouts,[xs0-Dx/10],[ys0+ysimage+DY/10],['Log!d10!N(I)'],$
         color=0,charsize=5,charthick=4,font=1,/device

 ; Place information around images:

if keyword_set(lasco_awsom) then begin
 xyouts,x0+[0,deltaX],(y0+ysimage+DY/5)*[1,1],$
         ['LASCO-C2 LAM Image: '+hdr.filename,'AWSoM Model'],$
         color=0,charsize=5,charthick=4,font=1,/device

  xyouts,[x0],[y0-DY/3],['DATE_OBS: '+hdr.DATE_OBS+'      '+$
                         'TIME_OBS: '+hdr.TIME_OBS],$
         color=0,charsize=5,charthick=4,font=1,/device

  filename = 'comparison_'+hdr.filename+'_AWSoM-CR2082-SCALED.gif'
endif

if keyword_set(kcor) then begin
  xyouts,x0+[0,deltaX],(y0+ysimage+DY/5)*[1,1],$
         ['KCOR Image','Synthetic Tomography Image'],$
         color=0,charsize=5,charthick=4,font=1,/device

  xyouts,[x0],[y0-DY/3],['DATE_OBS: '+hdr.DATE_OBS],$
         color=0,charsize=5,charthick=4,font=1,/device

  filename = 'comparison_'+hdr.DATE_OBS+'.gif'
endif

if keyword_set(euv) then begin

  xyouts,x0+[0,deltaX],(y0+ysimage+DY/5)*[1,1],$
         [hdr.detector+' image in band '+strmid(string(hdr.WAVELNTH),9,3)+' A','Synthetic Tomography Image'],$
         color=0,charsize=5,charthick=4,font=1,/device

  xyouts,[x0],[y0-DY/3],['DATE_OBS: '+hdr.DATE_OBS],$
         color=0,charsize=5,charthick=4,font=1,/device

  filename = 'comparison_'+hdr.DATE_OBS+'_'+model+'.gif'
endif

 ; Record image
    outdir   = '/data1/tomography/DATA/'+data_dir
  if keyword_set(record) then record_gif,outdir,filename,'X'
skip2:
endif

if NOT keyword_set(compare3) then begin
  if NOT keyword_set(winn) then winn=0
  if keyword_set(crop_image) then crop,img2,Io2,Ic2,Nx,Ny,Delta,factor_image   
  Ic2  = Ic2 > mini < maxi

;---create over-sized window with white background----------------
  xsimage = Nx/factor_image
  ysimage = Ny/factor_image
  DX      = xsimage/3
  DY      = ysimage/4
  x0      = DX/4
  y0      = DY/2.5
  window,xs=xsimage+DX,ys=ysimage+DY
  loadct,27
  tvscl,fltarr(xsimage+DX,ysimage+DY)
;-------------------------------------------------------
;Display image
  loadct,39
  frame=10
  black = fltarr(Nx/factor_image+frame,Ny/factor_image+frame)
  tvscl,black,x0-frame/2,y0-frame/2  
  tvscl,alog10( Ic2),x0,y0

;---PUT COLOR SCALE BAR---------------------------------------------------------
  logmini = alog10(mini)
  logmaxi = alog10(maxi)
  nsy= Ny/factor_image
  nsx= Dx/5

  black = fltarr(Nsx+frame,Nsy+frame)
  scale = fltarr(nsx,nsy)

  for ix=0,nsx-1 do scale(ix,*)=logmini+(logmaxi-logmini)*findgen(nsy)/float(nsy-1)

  xs0 = x0 + xsimage + DX/3
  ys0 = y0
  tvscl,black,xs0-frame/2,ys0-frame/2    
  tvscl,scale,xs0,ys0

  loadct,0
  contour,scale,findgen(nsx),reform(scale(0,*)),$
              pos=[xs0,ys0,xs0+nsx,ys0+nsy],/device,color=0,/noerase,$
              yticklen=.2,/nodata,ythick=2,xthick=2,charthick=4,$
              xstyle=5,ystyle=1,charsize=4,font=1

;print data on top of image
  loadct,0
  lens    = strlen(data_string)
  Orb     = strmid(data_string, 2, 2)
  UT      = strmid(data_string, 6,20)
  dsun_rs = strmid(data_string,28, 6)
  dsun_au = strmid(data_string,40, 6)
  lon     = strmid(data_string,50, 6)
  lat     = strmid(data_string,61, 5)
  
  instrument_string = strmid(data_dir,5,1)

  if instrument_string eq 'I' then begin
    East_rs = strmid(data_string,69, 5)
    West_rs = strmid(data_string,79, 5)
  endif
  
  if instrument_string eq 'O' then begin
    East_rs = strmid(data_string,89, 5)
    West_rs = strmid(data_string,98, 6)
  endif

  device, set_font = 'Helvetica',/TT_FONT
  
  xyouts,[x0],[y0+ysimage+DY/3],['WISPR-'+instrument_string+', Orbit #'+Orb+'.  AWSoM Model for CR-2081.'],$
         color=0,charsize=4,charthick=4,font=1,/device
  
  xyouts,[x0],[y0+ysimage+DY/10],$
         ['D!DPSP-SUN!N = '+dsun_au+' AU = '+dsun_rs+' R!DS!N'+$
          '        Lon / Lat [deg]: '+lon+' / '+lat],$
         color=0,charsize=4,charthick=4,font=1,/device
  
  xyouts,[x0],[y0-DY/4],$
         ['East: '+East_rs+' R!DS!N            UT: '+UT+'             West: '+West_rs+'R!DS!N'],$
         color=0,charsize=4,charthick=4,font=1,/device

  if keyword_set(BK) then $
  xyouts,[xs0-Dx/10],[ys0+ysimage+DY/10],['Log!d10!N(B!DK!N)'],$
         color=0,charsize=4,charthick=4,font=1,/device
  
  if keyword_set(pB) then $
  xyouts,[xs0-Dx/10],[ys0+ysimage+DY/10],['Log!d10!N(p!DB!N)'],$
         color=0,charsize=4,charthick=4,font=1,/device
    
  ; Record image
  if keyword_set(record) then record_gif,input_dir,comp_gif,'X'
endif

;close,/all
;stop

end

; This routine is designed only for WISPR
pro crop,img2,Io2,Ic2,Nx,Ny,Delta,factor_image
  Delta=Delta/factor_image
  Nx   = (size(Io2))(1)
  Ny   = (size(Io2))(2)
  img2 = reform(img2(*,Delta/2:Ny-Delta/2-1))  
  Io2  = reform( Io2(*,Delta/2:Ny-Delta/2-1))  
  Ic2  = reform( Ic2(*,Delta/2:Ny-Delta/2-1))  
  Ny   = (size(Io2))(2)
  factor_image = 1.
end
