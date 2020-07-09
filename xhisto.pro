pro xhisto,map=map,nr=nr,nt=nt,np=np,radii=radii,rad_range=rad_range,lat_range=lat_range,lon_range=lon_range,win=win,titulo=titulo,dir=dir,file=file,sufijo=sufijo,mini=mini,maxi=maxi

  old_device = !D.NAME
  if not keyword_set(sufijo) then sufijo =''

  dlat = 180./nt
  lat  = -90. + dlat/2. + dlat*findgen(nt)

  dlon = 360./np
  lon  =   0. + dlon/2. + dlon*findgen(np)

  radA = fltarr(nr,nt,np)
  for ir=0,nr-1 do radA(ir,*,*)=radii[ir]

  latA = fltarr(nr,nt,np)
  for it=0,nt-1 do latA(*,it,*)=lat[it]

  lonA = fltarr(nr,nt,np)
  for ip=0,np-1 do lonA(*,*,ip)=lon[ip]

  p = where(radA ge rad_range[0] and radA le rad_range[1] and latA ge lat_range[0] and latA le lat_range[1] and lonA ge lon_range[0] and lonA le lon_range[1]and finite(map) eq 1 )
  if (size(p))(1) eq -1 then begin
     print,'There are no valid data points in the specified box.'
     stop
  endif
  x_data = reform(map(p))

  Npos = n_elements(where(x_data gt 0.))
  Nneg = n_elements(where(x_data lt 0.))
  Nnul = n_elements(where(x_data eq 0.))
  if Nneg(0)eq -1 then Nneg = 0.
  if Nnul(0)eq -1 then Nnul = 0.
  Ntot=Npos+Nnul+Nneg

  if keyword_set(mini) then x_data = x_data > mini
  if keyword_set(maxi) then x_data = x_data < maxi

  Nbins   = 50
  maxdata = max(x_data)
  histo_x_data = histogram(x_data,binsize=maxdata/Nbins,locations=xval) / total(x_data)
  
     ps1,'/data1/tomography/SolarTom_idl/Figures/'+'histo_'+file+'_'+sufijo+'.eps',0
     plot,xval,histo_x_data,title=titulo,font=0,charsize=1,psym=10
     top = 0.9
     xyouts,0.6*[1,1,1],top-0.05*findgen(3),['Rad [Rsun]: ','Lat [deg]:     ','Lon [deg]:    ']+ $
            ['['+strmid(string(rad_range[0]),6,5)+' , '+strmid(string(rad_range[1]),6,5)+']',    $
             '['+strmid(string(lat_range[0]),5,3)+' , '+strmid(string(lat_range[1]),5,3)+']',    $
             '['+strmid(string(lon_range[0]),6,3)+' , '+strmid(string(lon_range[1]),6,3)+']'],   $
            /normal,Font=1,charsize=1.5
     xyouts,0.6*[1],top-0.05*[4],['Median value:'+string(median(x_data))],/normal,Font=1,charsize=1.5
     xyouts,0.6*[1,1,1,1],top-0.05*(6+findgen(4)),['% Npos:','% Nnul:','% Nneg:','    Ntot:']+string([[Npos,Nnul,Nneg]*(100./Ntot),Ntot]),/normal,Font=1,charsize=1.5
     ps2

     SET_PLOT, old_device      
  return  
end
