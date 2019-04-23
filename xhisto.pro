pro xhisto,map=map,nr=nr,nt=nt,np=np,radii=radii,rad_range=rad_range,lat_range=lat_range,win=win,titulo=titulo,dir=dir,file=file,sufijo=sufijo,mini=mini,maxi=maxi

  if not keyword_set(sufijo) then sufijo =''

  dlat = 180./nt
  lat  = -90. + dlat/2. + dlat*findgen(nt)

  radA = fltarr(nr,nt,np)
  for ir=0,nr-1 do radA(ir,*,*)=radii[ir]

  latA = fltarr(nr,nt,np)
  for it=0,nt-1 do latA(*,it,*)=lat[it]

  p = where(radA ge rad_range[0] and radA le rad_range[1] and latA ge lat_range[0] and latA le lat_range[1] and finite(map) eq 1 )
  if (size(p))(1) eq -1 then stop
  x_data = reform(map(p))

  Npos = n_elements(where(x_data gt 0.))
  Nneg = n_elements(where(x_data lt 0.))
  Nnul = n_elements(where(x_data eq 0.))
  if Nneg(0)eq -1 then Nneg = 0.
  if Nnul(0)eq -1 then Nnul = 0.
  Ntot=Npos+Nnul+Nneg

  if keyword_set(mini) then x_data = x_data > mini
  if keyword_set(maxi) then x_data = x_data < maxi
  
  maxdata = max(x_data)
  histo_x_data = histogram(x_data,binsize=maxdata/50.,locations=xval)
  
     ps1,'/data1/tomography/SolarTom_idl/Figures/'+'histo_'+file+'_'+sufijo+'.eps',0
     plot,xval,histo_x_data,title=titulo,font=0,charsize=1
     xyouts,0.6*[1,1,1,1],0.8-0.05*findgen(4),['RadMin  [Rsun] =','RadMax [Rsun] =','Latmin  [deg]  =','LatMax  [deg]  =']+strmid(string([rad_range,lat_range]),4,6),/normal,Font=0
     xyouts,0.6*[1,1,1,1],0.8-0.05*(5+findgen(4)),['% Npos = ','% Nnul = ','% Nneg = ','Tot. Num= ']+string([[Npos,Nnul,Nneg]*(100./Ntot),Ntot]),/normal,Font=0
     ps2
      
  return  
end
