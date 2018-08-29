pro xhisto,map=map,nr=nr,nt=nt,np=np,rmin=rmin,rmax=rmax,rad_range=rad_range,lat_range=lat_range,win=win,titulo=titulo,dir=dir,file=file,eps=eps,sufijo=sufijo,scalefactor=scalefactor

  if not keyword_set(sufijo) then sufijo =''
  
  drad = (rmax-rmin)/nr
  rad  = rmin + drad/2. + drad*findgen(nr)

  dlat = 180./nt
  lat  = -90. + dlat/2. + dlat*findgen(nt)

  radA = fltarr(nr,nt,np)
  for ir=0,nr-1 do radA(ir,*,*)=rad[ir]

  latA = fltarr(nr,nt,np)
  for it=0,nt-1 do latA(*,it,*)=lat[it]

  p = where(radA ge rad_range[0] and radA le rad_range[1] and latA ge lat_range[0] and latA le lat_range[1])
  if (size(p))(1) eq -1 then stop
  x_data = reform(map(p))

  Npos = n_elements(where(x_data gt 0.))
  Nneg = n_elements(where(x_data lt 0.))
  Nnul = n_elements(where(x_data eq 0.))
  if Nneg(0)eq -1 then Nneg = 0.
  if Nnul(0)eq -1 then Nnul = 0.
  Ntot=Npos+Nnul+Nneg
  
  maxdata = max(x_data)
  histo_x_data = histogram(x_data,binsize=maxdata/50.,locations=xval)

  case scalefactor of
     3: begin
        xsize=800
        ysize=600
        !p.charsize=2
     end

     2: begin
        xsize=600
        ysize=400
        !p.charsize=1
     end
     1: begin
        xsize=400
        ysize=250
        !p.charsize=1
     end
     else: begin
        xsize=800
        ysize=900
        !p.charsize=3
     end
  endcase
  
  
  if keyword_set(eps) then begin
     ps1,'/home/diegol/Pictures/'+'histo_'+file+sufijo+'.eps',0
     DEVICE,SCALE_FACTOR=scalefactor
   ; !p.charsize=3
     plot,xval,histo_x_data,title=titulo,font=0,charsize=2,charthick=3
     xyouts,0.6*[1,1,1,1],0.8-0.05*findgen(4),['RadMin  [Rsun] =','RadMax [Rsun] =','Latmin  [deg]  =','LatMax  [deg]  =']+strmid(string([rad_range,lat_range]),4,6),/normal,Font=0
     xyouts,0.6*[1,1,1,1],0.8-0.05*(5+findgen(4)),['% Npos = ','% Nnul = ','% Nneg = ','Tot. Num= ']+string([[Npos,Nnul,Nneg]*(100./Ntot),Ntot]),/normal,Font=0
     ps2
  endif
      
  window,win,XSIZE=xsize, YSIZE=ysize
;  !p.charsize=2
  plot,xval,histo_x_data,title=titulo,font=0,charthick=3
  xyouts,0.6*[1,1,1,1],0.8-0.05*findgen(4),['RadMin  [Rsun] =','RadMax [Rsun] =','Latmin  [deg]  =','LatMax  [deg]  =']+strmid(string([rad_range,lat_range]),4,6),/normal
  xyouts,0.6*[1,1,1,1],0.8-0.05*(5+findgen(4)),['% Npos = ','% Nnul = ','% Nneg = ','Tot. Num= ']+string([[Npos,Nnul,Nneg]*(100./Ntot),Ntot]),/normal
  !p.charsize=1
  
  return  
end
