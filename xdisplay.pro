pro xdisplay,dir=dir,file=file,nr=nr,nt=nt,np=np,rmin=rmin,rmax=rmax,r0A=r0A,mini=mini,maxi=maxi,win=win,log=log,clrtbl=clrtbl,$
             titulo=titulo,rad_range=rad_range,lat_range=lat_range,scalefactor=scalefactor,minA=minA,maxA=maxA,minS=minS,maxS=maxS,map=map,$
             radial_grid_file=radial_grid_file,box_lat=box_lat,box_lon=box_lon,instrument=instrument,raiz=raiz,ysize_factor=ysize_factor,units=units

  if not keyword_set(dir)          then dir          = '/data1/tomography/bindata/'
  if not keyword_set(titulo)       then titulo       = 'Reconstruction'
  if not keyword_set(clrtbl)       then clrtbl       = 39
  if not keyword_set(np)           then np           = 2*nt
  if not keyword_set(scalefactor)  then scalefactor  = 3
  if not keyword_set(lat_range)    then lat_range    = [-90.,+90.]
  if not keyword_set(rad_range)    then rad_range    = [2.5 , 8.5]
  if not keyword_set(r0A      )    then r0A          = [1.10,1.15,1.20]
  if not keyword_set(box_lat )     then box_lat      = 0.
  if not keyword_set(box_lon )     then box_lon      = 0.
  if not keyword_set(map)          then xread,dir=dir,file=file,nr=nr,nt=nt,np=np,map=map
  if not keyword_set(instrument)   then instrument   = 'aia'
  if not keyword_set(ysize_factor) then ysize_factor = 1.
  if not keyword_set (units)       then units        = 1.
  map = map /units
  
  if not keyword_set(radial_grid_file) then begin
     drad = (rmax-rmin)/nr     
     rad  = rmin + drad/2. + drad*findgen(nr)
  endif

  
  if keyword_set(radial_grid_file) then begin
     input_dir = './DATA/'
     readcol,input_dir+radial_grid_file,index,rad,drad,format='U,F,F',skipline=3,/quick
  endif
  
  if keyword_set(rad_range) then  begin
     sufijo = strmid(string(rad_range[0]),6,5)+'-'+strmid(string(rad_range[1]),6,5)+'_Rsun'
     xhisto,map=map,nr=nr,nt=nt,np=np,radii=rad,rad_range=rad_range,lat_range=lat_range,win=win,dir=dir,file=file,titulo='Histogram of '+titulo,sufijo=sufijo
  endif

  mins = fltarr(n_elements(r0A))
  maxs = fltarr(n_elements(r0A))
  for i=0,n_elements(r0A)-1 do begin
     frad = abs(rad-r0A[i])
     ir   = median(where(frad eq min(frad)))
     r0   = rad[ir]
;    rad_range=[r0,r0]
     sufijo = strmid(string(r0),6,5)+'_Rsun'

     if keyword_set(minA) then mini = minA[i]
     if keyword_set(maxA) then maxi = maxA[i]

;stop     
     if (not keyword_set(log) AND not keyword_set(raiz)) then $
        xshell,map=map,r0=r0,ir=ir,scalefactor=scalefactor,clrtbl=clrtbl,mini=mini,maxi=maxi,win=win+1+i,file=file,titulo=titulo,box_lat=box_lat,box_lon=box_lon,instrument=instrument;,ysize_factor=ysize_factor
     if     keyword_set(log)  then $
        xshell,map=map,r0=r0,ir=ir,scalefactor=scalefactor,clrtbl=clrtbl,mini=mini,maxi=maxi,win=win+1+i,file=file,titulo=titulo,box_lat=box_lat,box_lon=box_lon,instrument=instrument;,/log,ysize_factor=ysize_factor
     if     keyword_set(raiz) then $
        xshell,map=map,r0=r0,ir=ir,scalefactor=scalefactor,clrtbl=clrtbl,mini=mini,maxi=maxi,win=win+1+i,file=file,titulo=titulo,box_lat=box_lat,box_lon=box_lon,instrument=instrument;,/raiz,ysize_factor=ysize_factor
     
;     xhisto,map=map,nr=nr,nt=nt,np=np,radii=rad,rad_range=rad_range,lat_range=lat_range,win=win+3,dir=dir,file=file,titulo='Histogram of '+titulo,sufijo=sufijo,mini=mini,maxi=maxi
     ; Store mini and maxi for a final report.
     mins[i] = mini
     maxs[i] = maxi
     ; Set mini and max back to zero. 
     mini      = 0.
     maxi      = 0.
  endfor
  print,'-----------------------------------------------'
  print,'r0A    = ',r0A   
  print,'mins = ',mins
  print,'maxs = ',maxs
  print,'-----------------------------------------------'

  return
end
