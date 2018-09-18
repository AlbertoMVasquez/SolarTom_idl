pro xcompare,dir=dir,fileA=fileA,fileB=fileB,nrA=nrA,ntA=ntA,npA=npA,nrB=nrB,ntB=ntB,npB=npB,rminA=rminA,rmaxA=rmaxA,rminB=rminB,rmaxB=rmaxB,$
             radial_grid_file_A=radial_grid_file_A,radial_grid_file_B=radial_grid_file_B,$
             r0A=r0A,lat_range=lat_range,lon_range=lon_range,rad_range_A=rad_range_A,rad_range_B=rad_range_B,$
             clrtbl=clrtbl,scalefactor=scalefactor,comp_suffix=comp_suffix,$
             tit=tit,x_tit=x_tit,y_tit=y_tit,histo_x_tit=histo_x_tit,max_ratio=max_ratio,min_ratio=min_ratio,rad_y_tit=rad_y_tit

  EPS=1.e-4                     ; fractional tolerance for evaluating same height is being compared.
  
  if not keyword_set(dir)         then dir         = '/data1/tomography/bindata/'
  if not keyword_set(comp_suffix) then comp_suffix = 'A_vs_B'
  if not keyword_set(tit)         then tit         = 'Scatter Plot'
  if not keyword_set(xtit)        then xtit        = 'A'
  if not keyword_set(ytit)        then ytit        = 'B'
  if not keyword_set(clrtbl)      then clrtbl      = 39
  if not keyword_set(nrB)         then nrB         = nrA
  if not keyword_set(ntB)         then ntB         = ntA
  if not keyword_set(npA)         then npA         = 2*ntA
  if not keyword_set(npB)         then npB         = 2*ntB
  if not keyword_set(rminB)       then rminB       = rminA
  if not keyword_set(rmaxB)       then rmaxB       = rmaxA
  if not keyword_set(scalefactor) then scalefactor = 3
  if not keyword_set(lat_range)   then lat_range   = [-90., +90.]
  if not keyword_set(lon_range)   then lon_range   = [  0., 360.]
  if not keyword_set(rad_range)   then rad_range   = [1.02 , 1.255]
  if not keyword_set(r0A      )   then r0A         = [1.10,1.15,1.20]
  if not keyword_set(min_ratio)   then min_ratio   = 0.
  if not keyword_set(max_ratio)   then max_ratio   = 5.

  xread,dir=dir,file=fileA,nr=nrA,nt=ntA,np=npA,map=mapA
  xread,dir=dir,file=fileB,nr=nrB,nt=ntB,np=npB,map=mapB

  ; Uniform radial grid
  if not keyword_set(radial_grid_file) then begin
     dradA = (rmaxA-rminA)/nrA
     radA  = rminA + dradA/2. + dradA*findgen(nrA)
     dradB = (rmaxB-rminB)/nrB
     radB  = rminB + dradB/2. + dradB*findgen(nrB)
  endif
  ; NonUniform radial grid
  if keyword_set(radial_grid_file_A) then begin
     input_dir = './DATA/'
     readcol,input_dir+radial_grid_file_A,indexA,radA,dradA,format='U,F,F',skipline=3,/quick
  endif
  if keyword_set(radial_grid_file_B) then begin
     input_dir = './DATA/'
     readcol,input_dir+radial_grid_file_B,indexB,radB,dradB,format='U,F,F',skipline=3,/quick
  endif

  ; Uniform latitudinal and longitudinal grids
  dlatA = 180./ntA
  latA  = -90 + dlatA/2. + dlatA*findgen(ntA)
  dlonA = 360./npA
  lonA  = 0.0 + dlonA/2. + dlonA*findgen(npA)
  dlatB = 180./ntB
  latB  = -90 + dlatB/2. + dlatB*findgen(ntB)
  dlonB = 360./npB
  lonB  = 0.0 + dlonB/2. + dlonB*findgen(npB)

  ; 2D lat and lon maps
  mapA_lat = fltarr(ntA,npA)
  mapB_lat = fltarr(ntB,npB)
  for ipA=0,npA-1 do mapA_lat(*,ipA) = latA
  for ipB=0,npB-1 do mapB_lat(*,ipB) = latB
  mapA_lon = fltarr(ntA,npA)
  mapB_lon = fltarr(ntB,npB)
  for itA=0,ntA-1 do mapA_lon(itA,*) = lonA
  for itB=0,ntB-1 do mapB_lon(itB,*) = lonb
  
  ; Statistical comparison at each height for the specified lat and lon ranges.
  ; For the momento this only works when A and B have the same
  ; lat and lon grids. In the future I will put above a bi-linear interpolator
  ; to a common grid before getting into this loop below
  for i=0,n_elements(r0A)-1 do begin
     frad = abs(radA-r0A[i]) & irA  = median(where(frad eq min(frad))) & r0_A = radA[irA]
     frad = abs(radB-r0A[i]) & irB  = median(where(frad eq min(frad))) & r0_B = radB[irB]
     if abs(r0_A-r0_B)/mean([r0_A,r0_B]) gt EPS then STOP
     
     map_A = reform(mapA(irA,*,*))
     map_B = reform(mapB(irB,*,*))

     sufijo = strmid(string(r0_A),6,5)+'_Rsun'
     
     index = where(map_A gt 0. and map_B gt 0. and $
                   mapA_lat ge lat_range[0] and mapA_lat le lat_range[1] and $
                   mapB_lat ge lat_range[0] and mapB_lat le lat_range[1] and $
                   mapA_lon ge lon_range[0] and mapA_lon le lon_range[1] and $
                   mapB_lon ge lon_range[0] and mapB_lon le lon_range[1] )
     
     values_A    = reform(map_A(index))
     values_B    = reform(map_B(index))
     ratio       = values_A/values_B > min_ratio < max_ratio
     Nvals       = 50.
     histo_ratio = histogram(ratio,binsize=(max(ratio)-min(ratio))/Nvals,locations=xval)
     histo_ratio = float(histo_ratio) / float(n_elements(ratio))

     ps1,'/data1/tomography/SolarTom_idl/Figures/'+'comparison_'+comp_suffix+'_'+sufijo+'.eps',0
     device,/inches,xsize=12,ysize=5
     !p.multi = [0,2,1]
     plot,values_A,values_B,font=0,psym=4,xtitle=x_tit,ytitle=y_tit,title=tit+' at r = '+strmid(sufijo,0,5)+' R!DSUN!N'
     plot,xval,histo_ratio ,font=0,xtitle=histo_x_tit,title='Frequency Histogram'
     !p.multi = 0
     ps2
  endfor

;Compute average radial profile of x_A(r) in selected lat/lon range.
  x_A_avg = fltarr(NrA)
  for irA=0,nrA-1 do begin
     map_A = reform(mapA(irA,*,*))     
     index = where(map_A gt 0. and $
                   mapA_lat ge lat_range[0] and mapA_lat le lat_range[1] and $
                   mapA_lon ge lon_range[0] and mapA_lon le lon_range[1] )
     x_A_avg[irA] = mean(map_A)
  endfor
;Compute average radial profile of x_B(r) in selected lat/lon range.
  x_B_avg = fltarr(NrA)
  for irB=0,nrB-1 do begin
     map_B = reform(mapB(irB,*,*))     
     index = where(map_B gt 0. and $
                   mapB_lat ge lat_range[0] and mapB_lat le lat_range[1] and $
                   mapB_lon ge lon_range[0] and mapB_lon le lon_range[1] )
     x_B_avg[irB] = mean(map_B)
  endfor
;Plot average radial profiles of x_A(r) abd x_B(r) in selected lat/lon/rad ranges.
  iA = where(radA ge rad_range_A[0] and radA le rad_range_A[1])
  iB = where(radB ge rad_range_B[0] and radB le rad_range_B[1])
  ps1,'/data1/tomography/SolarTom_idl/Figures/'+'Average_Radial_Profiles_'+comp_suffix+'.eps',0
  device,/inches,xsize=8,ysize=5
  plot,radA,x_A_avg,font=0,xr=[1,max([radA(iA),radB(iB)])],xstyle=1,yr=[0,max([x_A_avg(iA),x_B_avg(iB)])],/nodata,$     
       title='Average Radial Profiles. '+tit,xtitle='r [R!DSUN!N]',ytitle=rad_y_tit
  oplot,radA(iA),x_A_avg(iA)
  oplot,radB(iB),x_B_avg(iB)
  ps2
  
  return
end
