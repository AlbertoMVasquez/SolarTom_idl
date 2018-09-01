pro xdisplay,dir=dir,file=file,nr=nr,nt=nt,np=np,rmin=rmin,rmax=rmax,r0A=r0A,mini=mini,maxi=maxi,win=win,log=log,clrtbl=clrtbl,titulo=titulo,rad_range=rad_range,lat_range=lat_range,scalefactor=scalefactor

  if not keyword_set(titulo)      then titulo      = 'Reconstruction'
  if not keyword_set(clrtbl)      then clrtbl      = 39
  if not keyword_set(np)          then np          = 2*nt
  if not keyword_set(scalefactor) then scalefactor = 3
  if not keyword_set(lat_range)   then lat_range   = [-90.,+90.]
  if not keyword_set(rad_range)   then rad_range   = [1.0 , 1.3]
  if not keyword_set(r0A      )   then r0A         = [1.10,1.15,1.20]
  
  xread,dir=dir,file=file,nr=nr,nt=nt,np=np,map=map

  if keyword_set(rad_range) then  begin
     sufijo = strmid(string(rad_range[0]),6,5)+'-'+strmid(string(rad_range[1]),6,5)+'_Rsun'
     xhisto,map=map,nr=nr,nt=nt,np=np,rmin=rmin,rmax=rmax,rad_range=rad_range,lat_range=lat_range,win=0,dir=dir,file=file,titulo='Histogram of '+titulo,sufijo=sufijo
  endif
  
  for i=0,n_elements(r0A)-1 do begin
     drad = (rmax-rmin)/nr
     rad  = rmin + drad/2. + drad*findgen(nr)
     frad = abs(rad-r0A[i])
     ir   = median(where(frad eq min(frad)))
     r0   = rad[ir]
     rad_range=[r0,r0]
     sufijo = strmid(string(r0),6,5)+'_Rsun'
     win=i
     xhisto,map=map,nr=nr,nt=nt,np=np,rmin=rmin,rmax=rmax,rad_range=rad_range,lat_range=lat_range,win=win,dir=dir,file=file,titulo='Histogram of '+titulo,sufijo=sufijo
     if not keyword_set(log) then xshell,map=map,r0=r0,scalefactor=scalefactor,clrtbl=clrtbl,mini=mini,maxi=maxi,rmin=rmin,rmax=rmax,win=win+2,file=file,titulo=titulo
     if     keyword_set(log) then xshell,map=map,r0=r0,scalefactor=scalefactor,clrtbl=clrtbl,mini=mini,maxi=maxi,rmin=rmin,rmax=rmax,win=win+2,file=file,titulo=titulo,/log  
  endfor
  return
end
