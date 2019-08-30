pro xlam_extract_tom,filename=filename,dir=dir,number=number,$
                     map=map,nr=nr,nt=nt,np=np,rmin=rmin,rmax=rmax

  if NOT keyword_set(dir)    then dir    = './'
  if NOT keyword_set(number) then number = 0

  file = dir+filename

  goto,skip_printout_info
  h5_list,file
  print
  print,'Ne_LAM dataset dimensions:'
  help,Ne_LAM
  print,'where (1st dim: radius 2nd dim: latitude, 3rd dim: longitude, 4th dim : time)'
  print
  skip_printout_info:

  rad    = h5_getdata(file,'/axes/rad')
  lat    = h5_getdata(file,'/axes/latitudes')
  lon    = h5_getdata(file,'/axes/longitudes')
  Ne_LAM = h5_getdata(file,'/volume/dataset_4D')
   N_LAM = h5_getdata(file,'/volume/dataset_4D_size')

  map = float(reform(Ne_LAM(*,*,*,number)))
  nr  = fix(N_LAM[0])
  nt  = fix(N_LAM[1])
  np  = fix(N_LAM[2])

  dr  = rad[1]-rad[0]
  rmin= min(rad) - dr/2.
  rmax= max(rad) + dr/2.

  if number lt 10 then number_string = strmid(string(number),7,1)
  if number ge 10 then number_string = strmid(string(number),6,2)

  output_filename = filename+'_N'+number_string
  openw,1,dir+output_filename
 writeu,1,map
  close,1

  print
  print,'Output file is: '+dir+output_filename
  print
  print,'help,map,nr,nt,np,rmin,rmax'
         help,map,nr,nt,np,rmin,rmax
  
  return
end
