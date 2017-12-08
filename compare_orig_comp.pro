
pro compare

  orig_image='WISPR_I_2025-06-14T22:00:00_Blank.fts'
  orig_file ='orig_WISPR_I_2025-06-14T22:00:00_Blank.dat'
  comp_file ='comp_x_AWSOM_CR2081run5_WISPR_sphere_2.dat_WISPR_I_2025-06-14T22:00:00_Blank.dat'

  Nx=2048
  Ny=2048

  compare_orig_comp,orig_image=orig_image,orig_file=orig_file,comp_file=comp_file,Nx=Nx,Ny=Ny
end

pro compare_orig_comp,tomroot=tomroot,data_dir=data_dir,orig_image=orig_image,orig_file=orig_file,comp_file=comp_file,Nx=Nx,Ny=Ny

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
  
  factor=2.
  Io2 =        congrid(Io ,Nx/factor,Ny/factor)
  Ic2 = alog10(congrid(Ic ,Nx/factor,Ny/factor)>1.e-3)
  img2=        congrid(img,Nx/factor,Ny/factor)

  Io2(Nx/factor-1,*) = max(Io2)

  Io2([0,1],0) = [min(img2),max(img2)]
  Io2 = Io2 > min(img2) < max(img2)
  
  loadct,39
  window,xs=3*Nx/factor,ys=Ny/factor
  tvscl,img2,0
  tvscl,Io2 ,1
  tvscl,Ic2 ,2
  
  stop
end
