
; convert_AWSOM_to_xfile,input_file='CR2081run5_WISPR_sphere_2.dat'

pro convert_AWSOM_to_xfile,Nrad=Nrad,Nlat=Nlat,Nlon=Nlon,input_file=input_file,output_file=output_file,input_dir=input_dir,output_dir=output_dir

  if not keyword_set(input_file) then begin
     print,'No input file specified.'
  endif
  
  if not keyword_set( input_dir) then  input_dir='/data1/DATA/MHD_SWMF/'
  if not keyword_set(output_dir) then output_dir='/data1/tomography_dev/SolarTom/'

  if not keyword_set(output_file) then output_file='x_'+input_file

  if not keyword_set(Nrad) then Nrad=100
  if not keyword_set(Nlat) then Nlat= 90
  if not keyword_set(Nlon) then Nlon=180

  N_e = fltarr(Nrad,Nlat,Nlon)
  x=''

; Read data from TECPLOT's SWMF tools:
  openr,1,input_dir+input_file
  for i=1,10 do readf,1,x
  for ip=0,Nlon-1 do begin
     for it=0,Nlat-1 do begin
        for ir=0,Nrad-1 do begin
           readf,1,x1,y1,z1,Ne1
           N_e(irad,ilat,ilon) = Ne1
        endfor
     endfor   
  endfor
  close,1

  openw,1,output_dir+output_file
  writeu,1,map
  close,1

  print,'Your output is in: '+output_dir+output_file

end
