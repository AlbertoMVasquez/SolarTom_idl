
; convert_AWSOM_to_xfile,input_file='CR2081run5_WISPR_sphere_2.dat'

; convert_AWSOM_to_xfile,input_file='CR2081run5_sphere_custom1.dat',N_dummy_lines=26,Nrad=200,Nlat=180,Nlon=360,/givenrho
; convert_AWSOM_to_xfile,input_file='CR2081run5_sphere_custom2.dat',N_dummy_lines=26,Nrad=100,Nlat= 90,Nlon=180,/givenrho

; convert_AWSOM_to_xfile,input_file='CR2082_LASCOC2_custom1.dat',N_dummy_lines=10,Nrad=200,Nlat=180,Nlon=360

; convert_AWSOM_to_xfile,input_file='CR2082_sphere_WISPR.dat',N_dummy_lines=10,Nrad=100,Nlat=90,Nlon=180

pro convert_AWSOM_to_xfile,Nrad=Nrad,Nlat=Nlat,Nlon=Nlon,input_file=input_file,output_file=output_file,input_dir=input_dir,output_dir=output_dir,N_dummy_lines=N_dummy_lines,givenrho=givenrho

  if not keyword_set(input_file) then begin
     print,'No input file specified.'
     stop
  endif

  if not keyword_set(N_dummy_lines) then N_dummy_lines = 10
  if not keyword_set(Nvars)         then Nvars         =  4
  
     
  if not keyword_set( input_dir) then  input_dir='/data1/DATA/MHD_SWMF/'
  if not keyword_set(output_dir) then output_dir='/data1/tomography_dev/bindata/'

  if not keyword_set(output_file) then output_file='x_AWSOM_'+input_file

  if not keyword_set(Nrad) then Nrad=100
  if not keyword_set(Nlat) then Nlat= 90
  if not keyword_set(Nlon) then Nlon=180

  print,'Grid:',Nrad,Nlat,Nlon
  
  N_e = fltarr(Nrad,Nlat,Nlon)
  x   = ''

  mp  = 1.672621898e-27 * 1.e3   ; gr
  x1  = 0.
  y1  = 0.
  z1  = 0.
  Ne1 = 0.
  
; Read data from TECPLOT's SWMF tools:
  openr,1,input_dir+input_file
  for i=1,N_dummy_lines do readf,1,x
  for ilon=0,Nlon-1 do begin
     for ilat=0,Nlat-1 do begin
        for irad=0,Nrad-1 do begin
           readf,1,x1,y1,z1,Ne1
           if keyword_set(givenrho) then Ne1=Ne1/mp ; rho -> Ne
        endfor
     endfor   
  endfor
  close,1

  openw,1,output_dir+output_file
  writeu,1,N_e
  close,1

  print,'Your output is in: '+output_dir+output_file

end
