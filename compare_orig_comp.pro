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

; compare_lascoc2,  orig_image='C2-PB-20070416_2100.fts',  orig_file ='orig_C2-PB-20070416_2100.dat',  comp_file ='comp_x_AWSOM_CR2081run5_WISPR_sphere_2.dat_C2-PB-20070416_2100.dat',  data_dir  ='c2/2007.04/'
pro compare_lascoc2,orig_image=orig_image,orig_file=orig_file,comp_file=comp_file,data_dir=data_dir,winn=winn
  Nx=512
  Ny=512
  factor_image=0.5
  factor_unit = 1.e10*0.79  
  compare_orig_comp,orig_image=orig_image,orig_file=orig_file,comp_file=comp_file,Nx=Nx,Ny=Ny,data_dir=data_dir,factor_image=factor_image,factor_unit=factor_unit,winn=winn
end

; compare_wispr,orig_image='WISPR_I_2025-06-13T22:00:00_squareFOV_binfac4_Blank.fts'
; compare_wispr,orig_image='WISPR_I_2025-06-14T22:00:00_squareFOV_binfac4_Blank.fts'
; compare_wispr,orig_image='WISPR_I_2025-06-15T22:00:00_squareFOV_binfac4_Blank.fts'

; movie,input_file='list.wisprI.512.Orbit01.txt'
; movie,input_file='list.wisprI.512.Orbit12.txt'
; movie,input_file='list.wisprI.512.Orbit24.txt'

pro movie,input_file=input_file
  if not keyword_set(data_dir) then data_dir='/data1/tomography_dev/DATA/wisprI/'
  N=0
  orig_image=''
  openr,2,data_dir+input_file
  readf,2,N
  for i=0,N-1 do begin
     readf,2,orig_image
     compare_wispr,orig_image=orig_image,data_dir=data_dir
  endfor
  close,2
end

pro compare_wispr,orig_image=orig_image,data_dir=data_dir

  model     = 'x_AWSOM_CR2081run5_WISPR_sphere_2.dat'  
  orig_file = 'orig_'          +strmid(orig_image,0,strlen(orig_image)-4)+'.dat'
  comp_file = 'comp_'+model+'_'+strmid(orig_image,0,strlen(orig_image)-4)+'.dat'
  comp_gif  = 'comp_'+model+'_'+strmid(orig_image,0,strlen(orig_image)-4)+'.gif'

  Nx= 512 & Ny= 512 & Delta= 32 & factor_image = .5
 ;Nx=2048 & Ny=2048 & Delta=128 & factor_image = 2.

  compare_orig_comp,orig_image=orig_image,orig_file=orig_file,comp_file=comp_file,Nx=Nx,Ny=Ny,factor_image=factor_image,Delta=Delta,/record,/crop,comp_gif=comp_gif,/create_FITS_for_tom
  
end

pro compare_orig_comp,tomroot=tomroot,data_dir=data_dir,orig_image=orig_image,orig_file=orig_file,comp_file=comp_file,Nx=Nx,Ny=Ny,factor_image=factor_image,factor_unit=factor_unit,crop_image=crop_image,compare3=compare3,winn=winn,Delta=Delta,record=record,comp_gif=comp_gif,create_FITS_for_tom=create_FITS_for_tom

  if not keyword_set(factor_unit) then factor_unit = 1.
  
  if not keyword_set(tomroot) then tomroot = '/data1/'
  input_dir = tomroot+'tomography/bindata/Compare/'

  if not keyword_set(data_dir) then data_dir='wisprI/'
  input_data_dir = tomroot+'tomography/DATA/'+data_dir
  
  Io = fltarr(Nx,Ny)
  Ic = fltarr(Nx,Ny)

  openr,1,input_dir+orig_file
  readu,1,Io
  close,1
  openr,1,input_dir+comp_file
  readu,1,Ic
  close,1

  Io = rotate(Io,4)
  Ic = rotate(Ic,4)

  mreadfits,input_data_dir+orig_image,hdr,img
  img=img*factor_unit

  if keyword_set(create_FITS_for_tom) then begin
     newfilename = strmid(orig_image,0,strlen(orig_image)-9)+'Synth.fts'
     mwritefits,hdr,Ic,outfile=input_data_dir+newfilename
  endif
  
  p = where(Ic gt 0.)
  mini = min(Ic(p))
  
  if not keyword_set(factor_image) then factor_image=1.

  img2= congrid(img,Nx/factor_image,Ny/factor_image)
  Io2 = congrid(Io ,Nx/factor_image,Ny/factor_image)
  Ic2 = congrid(Ic ,Nx/factor_image,Ny/factor_image)

; Io2(Nx/factor_image-1,*) = max(Io2)

  if keyword_set(compare3) then begin

  maxi = max([max(img),max(Io),max(Ic)])

  Img2([0,1],0) = [mini,maxi]
   Io2([0,1],0) = [mini,maxi]
   Ic2([0,1],0) = [mini,maxi]

  Img2 = Img2 > mini < maxi
   Io2 =  Io2 > mini < maxi
   Ic2 =  Ic2 > mini < maxi

  if keyword_set(crop_image) then crop,img2,Io2,Ic2,Nx,Ny,Delta,factor_image

  loadct,39
  window,xs=3*Nx/factor_image,ys=Ny/factor_image
  tvscl,alog10(img2),0
  tvscl,alog10( Io2),1
  tvscl,alog10( Ic2),2
  endif

  if NOT keyword_set(compare3) then begin
  if NOT keyword_set(winn) then winn=0
  if keyword_set(crop_image) then crop,img2,Io2,Ic2,Nx,Ny,Delta,factor_image   
  Ic2  = Ic2 > mini
  loadct,39
  window,winn,xs=Nx/factor_image,ys=Ny/factor_image
  tvscl,alog10( Ic2)
  if keyword_set(record) then record_gif,input_dir,comp_gif,'X'
  endif

; stop
end

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
