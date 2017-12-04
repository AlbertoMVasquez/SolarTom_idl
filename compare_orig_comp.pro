
; compare_orig_comp,orig_file='orig_WISPR_I_2025-06-14T22:00:00_Blank.dat',comp_file='comp_x_AWSOM_CR2081run5_WISPR_sphere.dat_WISPR_I_2025-06-14T22:00:00_Blank.dat'

pro compare_orig_comp,tomroot=tomroot,orig_file=orig_file,comp_file=comp_file,Nx=Nx,Ny=Ny

  if not keyword_set(tomroot) then tomroot = '/data1/'
  input_dir = tomroot+'tomography/bindata/Compare/'

  Io = fltarr(Nx,Ny)
  Ic = fltarr(Nx,Ny)

  openr,1,input_dir+orig_file
  readu,1,Io
  close,1
  openr,1,input_dir+comp_file
  readu,1,Ic
  close,1

  factor=2.
  Io2 = congrid(Io,Nx/factor,Ny/factor)
  Ic2 = congrid(Ic,Nx/factor,Ny/factor)
  window,xs=Nx,ys=Ny/factor
  tvscl,Io2,0
  tvscl,Ic2,1
  
  stop
end
