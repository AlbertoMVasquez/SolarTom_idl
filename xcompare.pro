pro xcompare,dir=dir,fileA=fileA,fileB=fileB,nrA=nrA,ntA=ntA,npA=npA,nrB=nrB,ntB=ntB,npB=npB,rminA=rminA,rmaxA=rmaxA,rminB=rminB,rmaxB=rmaxB,$
             radial_grid_file_A=radial_grid_file_A,radial_grid_file_B=radial_grid_file_B,$
             r0A=r0A,lat_range=lat_range,lon_range=lon_range,rad_range_A=rad_range_A,rad_range_B=rad_range_B,$
             clrtbl=clrtbl,scalefactor=scalefactor,comp_suffix=comp_suffix,$
             tit=tit,x_tit=x_tit,y_tit=y_tit,histo_x_tit=histo_x_tit,max_ratio=max_ratio,min_ratio=min_ratio,rad_y_tit=rad_y_tit,$
             radd_range=rad_range,Nvals=Nvals,LabelA=LabelA,LabelB=LabelB,diff=diff,fileC=fileC,r_crit=r_crit,min_diff=min_diff,max_diff=max_diff

;diff implica utilizar FileA=awsom y fileB=demt entonces hace (demt-awsom)/awsom
;ademas si se defince /diff y fileC =Rmap entonces selecciona solo
;donde R<0.25
  EPS=1.e-4                     ; fractional tolerance to evaluate if same height is being compared.
  
  if not keyword_set(dir)         then dir         = '/data1/tomography/bindata/'
  if not keyword_set(comp_suffix) then comp_suffix = 'A_vs_B'
; if not keyword_set(tit)         then tit         = 'Scatter Plot'
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
;  if not keyword_set(min_ratio)   then min_ratio   = 0.
;  if not keyword_set(max_ratio)   then max_ratio   = 5.
  if not keyword_set(nvals)       then Nvals       = 50.
  if not keyword_set(LabelA)      then LabelA      = 'Map-A'
  if not keyword_set(LabelA)      then LabelA      = 'Map-B'

  if n_elements(min_ratio)  eq 0  then min_ratio   = fltarr(n_elements(r0A))*0.
  if n_elements(max_ratio)  eq 0  then max_ratio   = fltarr(n_elements(r0A)) + 5.
  
  xread,dir=dir,file=fileA,nr=nrA,nt=ntA,np=npA,map=mapA
  xread,dir=dir,file=fileB,nr=nrB,nt=ntB,np=npB,map=mapB
  if keyword_set(fileC) then   xread,dir=dir,file=fileC,nr=26,nt=90,np=180,map=mapC;se utiliza con /diff
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

  ; 3D rat lat and lon maps
  mapB_lon3d = fltarr(nrB,ntB,npB)
  mapA_lon3d = fltarr(nrA,ntA,npA)
  for ipA=0,npA-1 do mapA_lon3d(*,*,ipA) = lonA[ipA]
  for ipB=0,npB-1 do mapB_lon3d(*,*,ipB) = lonB[ipB]
  mapA_lat3d = fltarr(nrA,ntA,npA)
  mapB_lat3d = fltarr(nrB,ntB,npB)
  for itA=0,ntA-1 do mapA_lat3d(*,itA,*) = latA[itA]
  for itB=0,ntB-1 do mapB_lat3d(*,itB,*) = latb[itB]
  mapA_rad3d = fltarr(nrA,ntA,npA)
  mapB_rad3d = fltarr(nrB,ntB,npB)
  for irA=0,nrA-1 do mapA_rad3d(irA,*,*) = radA[irA]
  for irB=0,nrB-1 do mapB_rad3d(irB,*,*) = radB[irB]

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
     ratio       = values_A/values_B > min_ratio(i) < max_ratio(i)

     tit1=tit+' at r = '+strmid(sufijo,0,5)+' R!DSUN!N'
     PRINT, CORRELATE(values_A, values_B)
     graphs,ratio,values_A,values_B,comp_suffix=comp_suffix,sufijo=sufijo,x_tit=x_tit,y_tit=y_tit,tit=tit1,histo_x_tit=histo_x_tit,Nvals=Nvals

  endfor

  if keyword_set(diff) then begin
     diff_rel = (mapB - mapA )/mapA 
     name_file = 'relative_difference_'+fileA+'-'+fileB
     diff_rel (where(mapB eq -999.)) = -1.;-999. 
     diff_rel (where(mapC gt  r_crit)) = -1.;-999. 
     minA = min_diff ;fltarr(n_elements(r0A))-1
     maxA = max_diff ;fltarr(n_elements(r0A))+10
     xdisplay,map=diff_rel,file=name_file,nr=26,nt=90,rmin=1.0,rmax=1.26,r0A=r0A,win=0,titulo='Rel diff '+strmid(fileB,0,2)+' (demt-awsom)/awsom',clrtb=39 ,minA=minA,maxA=maxA,scalefactor=scalefactor
     
  endif



;compute comparison at all heights
  pA_B = where(mapA_rad3d ge rad_range[0] and mapA_rad3d le rad_range[1] and mapA_lat3d ge lat_range[0] and mapA_lat3d le lat_range[1] and mapA_lon3d ge lon_range[0] and mapA_lon3d le lon_range[1] and mapA gt 0. and mapB_rad3d ge rad_range[0] and mapB_rad3d le rad_range[1] and mapB_lat3d ge lat_range[0] and mapB_lat3d le lat_range[1] and mapB_lon3d ge lon_range[0] and mapB_lon3d le lon_range[1] and mapB gt 0.)

;  pA = where(mapA_rad3d ge rad_range[0] and mapA_rad3d le rad_range[1] and mapA_lat3d ge lat_range[0] and mapA_lat3d le lat_range[1] and mapA_lon3d ge lon_range[0] and mapA_lon3d le lon_range[1] and mapA gt 0.)
  if (size(pA_B))(0) eq -1 then stop
  x_dataA = reform(mapA(pA_B))
;  pB = where(mapB_rad3d ge rad_range[0] and mapB_rad3d le rad_range[1] and mapB_lat3d ge lat_range[0] and mapB_lat3d le lat_range[1] and mapB_lon3d ge lon_range[0] and mapB_lon3d le lon_range[1] and mapB gt 0.)
  if (size(pA_B))(0) eq -1 then stop
  x_dataB = reform(mapB(pA_B)) 
  ratio       = x_dataA/x_dataB > min_ratio < max_ratio
  sss='range'+strmid(string(rad_range[0]),6,5)+'-'+strmid(string(rad_range[1]),6,5)+'_Rsun'
  tit2=tit+' at r = '+strmid(string(rad_range[0]),6,5)+'-'+strmid(string(rad_range[1]),6,5)+' R!DSUN!N'
  graphs,ratio,x_dataA,x_dataB,comp_suffix=comp_suffix,sufijo=sss,x_tit=x_tit,y_tit=y_tit,tit=tit2,histo_x_tit=histo_x_tit,Nvals=Nvals


;Compute average radial profile of x_A(r) in selected lat/lon range.
  x_A_avg = fltarr(NrA)
  for irA=0,nrA-1 do begin
     map_A = reform(mapA(irA,*,*))     
     index = where(map_A gt 0. and $
                   mapA_lat ge lat_range[0] and mapA_lat le lat_range[1] and $
                   mapA_lon ge lon_range[0] and mapA_lon le lon_range[1] )
     if index(0) ne -1 then begin  
        x_A_avg[irA] = mean(map_A(index))
     endif else begin
        x_A_avg[irA] = 0.
     endelse
  endfor
;Compute average radial profile of x_B(r) in selected lat/lon range.
  x_B_avg = fltarr(NrB)
  for irB=0,nrB-1 do begin
     map_B = reform(mapB(irB,*,*))     
     index = where(map_B gt 0. and $
                   mapB_lat ge lat_range[0] and mapB_lat le lat_range[1] and $
                   mapB_lon ge lon_range[0] and mapB_lon le lon_range[1] )
     if index(0) ne -1 then begin
        x_B_avg[irB] = mean(map_B(index))
     endif else begin
        x_B_avg[irB] = 0.
     endelse
  endfor
;Plot average radial profiles of x_A(r) abd x_B(r) in selected lat/lon/rad ranges.
  iA = where(radA ge rad_range_A[0] and radA le rad_range_A[1])
  iB = where(radB ge rad_range_B[0] and radB le rad_range_B[1])
  ps1,'/data1/tomography/SolarTom_idl/Figures/'+'Average_Radial_Profiles_'+comp_suffix+'.eps',12
  device,/inches,xsize=8,ysize=5
  plot,radA,x_A_avg,font=0,xr=[1,max([radA(iA),radB(iB)])],xstyle=1,yr=[0,max([x_A_avg(iA),x_B_avg(iB)])],/nodata,$     
       title='Average Radial Profiles '+tit,xtitle='r [R!DSUN!N]',ytitle=rad_y_tit,charsize=2.1
  oplot,radA(iA),x_A_avg(iA),color=100,thick=4
  oplot,radB(iB),x_B_avg(iB),color=200,thick=4
  xyouts,0.7,0.8-[0.,0.05],[LabelA,LabelB],/normal,color=[100,200],charthick=4,charsize=2.1
  ps2
  
  return
end

pro graphs,ratio,values_A,values_B,comp_suffix=comp_suffix,sufijo=sufijo,x_tit=x_tit,y_tit=y_tit,tit=tit,histo_x_tit=histo_x_tit,Nvals=Nvals

  histo_ratio = histogram(ratio,binsize=(max(ratio)-min(ratio))/Nvals,locations=xval)
  histo_ratio = float(histo_ratio) / float(n_elements(ratio))
  
  avg        =   mean(ratio)
  med        = median(ratio)
  stdev_frac =  stdev(ratio)/abs(avg)
  cant       = long(n_elements(ratio))
  
  ps1,'/data1/tomography/SolarTom_idl/Figures/'+'comparison_'+comp_suffix+'_'+sufijo+'.eps',0
  device,/inches,xsize=12,ysize=5
;  !p.multi = [0,2,1]
 ; plot,values_A,values_B,font=0,psym=4,xtitle=x_tit,ytitle=y_tit,title=tit
  plot,xval,histo_ratio ,font=0,xtitle=histo_x_tit,title='Frequency Histogram'+tit,linestyle=8,psym=10,thick=4,charsize=2.2
  xyouts,0.8*[1,1,1,1],0.98-[0.18,0.25,0.32,0.38],['m='+strmid(string(med),4,6),'!9m!3='+strmid(string(avg),4,6),'!9s!3/!9m!3='+strmid(string(stdev_frac),4,6),'N='+strmid(string(cant),7,7)],/normal,charthick=1,Font=0,charsize=2.2
  !p.multi = 0





return
end
