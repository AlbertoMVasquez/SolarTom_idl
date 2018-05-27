pro average_images,dir=dir,list=list
  common mean_data,img_mean,hdr_mean
  N=0
  filename=''
  openrf,1,dir+file
  readf,1,N
  indmedian = median(indgen(N))
  for i=0,N-1 do begin
     readf,1,filename
     mreadfits,dir+filename,hdr,img
     if i eq 0         then img_mean = img
     if i gt 0         then img_mean = img_mean + img
     if i eq indmedian then hdr_mean = hdr
  endfor
  img_mean = img_mean / float(N)
  return
end
