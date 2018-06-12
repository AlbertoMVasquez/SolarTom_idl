pro xcarrmap,map=map,xi=xi,yi=yi,np=np,nt=nt,scalefactor=scalefactor,clrtbl=clrtbl,$
            xtitle_status=xtitle_status,ytitle_status=ytitle_status,$
            titulo_status=titulo_status,title=title,toptitle=toptitle,$
            color_scale=color_scale,DX=DX,DY=DY,mini=mini,maxi=maxi,$
            xsimage=xsimage,ysimage=ysimage
  
    x=xi
    y=yi
    loadct,clrtbl
    tvscl,map,x,y
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
        /device,color=255,xstyle=1,ystyle=1,charsize=4.,$
        xtitle=xtitle,$
        ytitle=ytitle,$
        title=titulo,$
        yticklen=.02,xticklen=.03,ythick=2,xthick=2,charthick=4,font=1

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
      loadct,clrtbl
      tvscl,scale,xs0,ys0

      loadct,0
      contour,scale,findgen(nsx),reform(scale(0,*)),$
              pos=[xs0,ys0,xs0+nsx,ys0+nsy],/device,color=0,/noerase,$
              yticklen=.2,/nodata,ythick=2,xthick=2,charthick=4,$
              xstyle=5,ystyle=1,charsize=5,font=1
    endif

    return
 end
