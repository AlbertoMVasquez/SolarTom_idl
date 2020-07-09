pro xcarrmap,map=map,xi=xi,yi=yi,np=np,nt=nt,scalefactor=scalefactor,clrtbl=clrtbl,$
            xtitle_status=xtitle_status,ytitle_status=ytitle_status,$
            titulo_status=titulo_status,title=title,toptitle=toptitle,$
            color_scale=color_scale,DX=DX,DY=DY,mini=mini,maxi=maxi,$
            xsimage=xsimage,ysimage=ysimage,instrument=instrument,mmapoc=mapoc2
  
    x=xi
    y=yi
    if clrtbl le 40 then loadct,clrtbl
    if clrtbl gt 40 AND instrument ne 'aia' then secchi_colors, 'EUVI', clrtbl, R, G, B,/load
    if clrtbl gt 40 AND instrument eq 'aia' then aia_lct,wave=clrtbl,/load
    tvscl,map,x,y
;stop
    nlon=np*scalefactor
    nlat=nt*scalefactor
    LatMIN = -90.
    LatMAX = +90.
    LonMIN =   0.
    LonMAX = 360.
    LAT=LatMIN+(LatMAX-LatMIN)*FINDGEN(Nlat)/FLOAT(Nlat-1)
    LON=LonMIN+(LonMAX-LonMIN)*FINDGEN(Nlon)/FLOAT(Nlon-1)
    xtitle=''
    ytitle=''
    titulo=''
    if xtitle_status eq 1 then xtitle='Carrington Longitude [deg]'
    if ytitle_status eq 1 then ytitle='Latitude [deg]'
    if titulo_status eq 1 then titulo=title
    loadct,40

    contour,map,lon,lat,pos=[X,Y,X+nlon,Y+nlat],/noerase,/nodata,$
        /device,color=255,xstyle=1,ystyle=1,charsize=3.,$
        xtitle=xtitle,$
        ytitle=ytitle,$
        title=titulo,$
        yticklen=.02,xticklen=.03,ythick=2,xthick=2,charthick=2,Font=1
    if keyword_set(mapoc2) then begin
       contour,mapoc2,lon,lat,/noerase,color=0,pos=[X,Y,X+nlon,Y+nlat],$
               /device,xstyle=1,ystyle=1,yticklen=.02,xticklen=0.03,ythick=2,$
               xthick=2,charthick=0.1,charsize=0.1,font=1,c_thick=4,c_linestyle=lstyle
    endif
;stop    
   if keyword_set(color_scale) then begin
      nsy = ysimage
      nsx = Dx/5

      frame=1
      black = fltarr(Nsx+frame,Nsy+frame)
      scale = fltarr(nsx,nsy)
      for ix=0,nsx-1 do scale(ix,*)=mini+(maxi-mini)*findgen(nsy)/float(nsy-1)
      xs0 = x + xsimage + DX/3
      ys0 = y
      loadct,0
      tvscl,black,xs0-frame/2,ys0-frame/2
;stop
      if clrtbl le 40 then loadct,clrtbl
      if clrtbl gt 40 AND instrument ne 'aia' then secchi_colors, 'EUVI', clrtbl, R, G, B,/load
      if clrtbl gt 40 AND instrument eq 'aia' then aia_lct,wave=clrtbl,/load
      tvscl,scale,xs0,ys0
;stop
      loadct,0
      contour,scale,findgen(nsx),reform(scale(0,*)),$
              pos=[xs0,ys0,xs0+nsx,ys0+nsy],/device,color=0,/noerase,$
              yticklen=.2,/nodata,ythick=2,xthick=2,charthick=3,$
              xstyle=5,ystyle=1,charsize=scalefactor,font=1
;stop
   endif

    return
 end

