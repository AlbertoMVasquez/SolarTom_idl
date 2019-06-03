pro xread,dir=dir,file=file,nr=nr,nt=nt,np=np,map=map
  map=fltarr(nr,nt,np)
  openr,1,dir+file
  readu,1,map
  close,1
  return
end
