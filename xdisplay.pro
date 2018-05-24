
; xdisplay,dir='/data1/tomography/bindata/',file='x_KCOR.CR2198.13imgs.bf2.295_90_180_l1e-5_hlaplac_CORRECTED_3',nr=295,nt=90,rmin=1.05,rmax=4.00,r0=1.2,win=0
; xdisplay,dir='/data1/tomography/bindata/',file='x_KCOR.CR2198.13imgs.bf2.295_90_180_l1e-6_hlaplac_CORRECTED_3',nr=295,nt=90,rmin=1.05,rmax=4.00,r0=1.2,win=1
; xdisplay,dir='/data1/tomography/bindata/',file='x_KCOR.CR2198.13imgs.bf2.295_90_180_NoOffSet_l1e-6_hlaplac'   ,nr=295,nt=90,rmin=1.05,rmax=4.00,r0=1.2,win=2
; xdisplay,dir='/data1/tomography/bindata/',file='x_KCOR.CR2198.13imgs.bf2.295_90_180_AvgNoOffSet_l1e-6_hlaplac',nr=295,nt=90,rmin=1.05,rmax=4.00,r0=1.2,win=3
; xdisplay,dir='/data1/tomography/bindata/',file='x_comp1074.CR2198.bf2.ri1.00.ro1.50_50_90_180_meanimage_hlaplac_l1e-1',nr=50,nt=90,rmin=1.0,rmax=1.5,r0=1.1,win=4

pro xdisplay,dir=dir,file=file,nr=nr,nt=nt,np=np,rmin=rmin,rmax=rmax,r0=r0,mini=mini,maxi=maxi,win=win
  clrtbl = 40
  if not keyword_set(np)          then np          = 2*nt
  if not keyword_set(scalefactor) then scalefactor = 4
  xread,dir=dir,file=file,nr=nr,nt=nt,np=np,map=map
  xshell,map=map,r0=r0,scalefactor=scalefactor,clrtbl=clrtbl,mini=mini,maxi=maxi,rmin=rmin,rmax=rmax,win=win,file=file
  return
end

pro xread,dir=dir,file=file,nr=nr,nt=nt,np=np,map=map
map=fltarr(nr,nt,np)
openr,1,dir+file
readu,1,map
close,1
return
end

pro xshell,map=map,r0=r0,scalefactor=scalefactor,clrtbl=clrtbl,mini=mini,maxi=maxi,rmin=rmin,rmax=rmax,log=log,interp=interp,win=win,file=file

; set graph stuff
device, retain     = 2
device, true_color = 24
device, decomposed = 0

if not keyword_set(pos) then pos=0

nr=fix((size(map))(1))
nt=fix((size(map))(2))
np=fix((size(map))(3))

; Determine radial index for shell
drad = (rmax-rmin)/nr
rad  = rmin + drad/2. + drad*findgen(nr)
frad = abs(rad-r0)
ir   = median(where(frad eq min(frad)))

if keyword_set(interp) then $
map2=rotate(rebin(reform(map(ir,*,*)),nt*scalefactor,np*scalefactor),4)

if NOT keyword_set(interp) then begin
tmin= -90.
tmax= +90.
pmin=   0.
pmax= 360.
t=tmin+(tmax-tmin)*findgen(nt)/float(nt-1)
p=pmin+(pmax-pmin)*findgen(np)/float(np-1)
map2d=reform(map(ir,*,*))
nt2=nt*scalefactor
np2=np*scalefactor
t2=tmin+(tmax-tmin)*findgen(nt2)/float(nt2-1)
p2=pmin+(pmax-pmin)*findgen(np2)/float(np2-1)
map2=fltarr(nt2,np2)
for ip2=0,np2-1 do begin
p0=p2(ip2)
fp=abs(p-p0)
ip=fix( (where(fp eq min(fp)))(0) )
for it2=0,nt2-1 do begin
t0=t2(it2)
ft=abs(t-t0)
it=fix( (where(ft eq min(ft)))(0) )
map2(it2,ip2)=map2d(it,ip)
endfor
endfor
map2=rotate(map2,4)
endif

; Default mini and maxi
ipos = where(map2 gt 0.)
if not keyword_set(mini) then mini = min(map2(ipos))
if not keyword_set(maxi) then maxi = max(map2(ipos))

; Inform mini and maxi in terminal
print,'---------------------------'
print,'mini = ',mini
print,'maxi = ',maxi
print,'---------------------------'
; Force mini and maxi
map2(0,0)=mini
map2(0,1)=maxi
map2=map2>mini<maxi

if keyword_set(log) then begin
   map2=alog10(map2)
   mini=alog10(mini)
   maxi=alog10(maxi)
endif

 ;---create over-sized window with white background----------------
  Npanels = 1
  xsimage = np*scalefactor
  ysimage = nt*scalefactor
  DX      = xsimage/2
  DY      = ysimage/1.25
  x0      = DX/2.5
  y0      = (ysimage+DY)*(Npanels-1)
  window,0,xs=xsimage+DX,ys=(ysimage+DY)*Npanels
  loadct,27
  tvscl,fltarr(xsimage+DX,(ysimage+DY)*Npanels)

 if clrtbl lt 100 then loadct,clrtbl
 if clrtbl gt 100 then secchi_colors, 'EUVI', clrtbl, R, G, B,/load
    height_string = strmid(string(r0),6,4)
    x = x0
    y = y0+DY/2
    carrmap,map=map2,xi=x,yi=y,np=np,nt=nt,scalefactor=scalefactor,clrtbl=clrtbl,$
            xtitle_status=1,ytitle_status=1,titulo_status=1,$
            title='Reconstruction at '+height_string+' R!DSUN!N',$
            /color_scale,DX=DX,DY=DY,mini=mini,maxi=maxi,xsimage=xsimage,ysimage=ysimage
  record_gif,'~/Pictures/',file+'_'+height_string+'_Rsun.gif','X'
return
end

pro carrmap,map=map,xi=xi,yi=yi,np=np,nt=nt,scalefactor=scalefactor,clrtbl=clrtbl,$
            xtitle_status=xtitle_status,ytitle_status=ytitle_status,$
            titulo_status=titulo_status,title=title,toptitle=toptitle,$
            color_scale=color_scale,DX=DX,DY=DY,mini=mini,maxi=maxi,$
            xsimage=xsimage,ysimage=ysimage

  
    x=xi
    y=yi
    tvscl,map,x,y
    loadct,0
    nlon=np*scalefactor
    nlat=nt*scalefactor
    LatMIN = -90.
    LatMAX = +90.
    LonMIN =   0.
    LonMAX = 360.
    LAT=LatMIN+(LatMAX-LatMIN)*FINDGEN(Nlat)/FLOAT(Nlat-1)
    LON=LonMIN+(LonMAX-LonMIN)*FINDGEN(Nlon)/FLOAT(Nlon-1)
    loadct,clrtbl
    xtitle=''
    ytitle=''
    titulo=''
    if xtitle_status eq 1 then xtitle='Carrington Longitude [deg]'
    if ytitle_status eq 1 then ytitle='Latitude [deg]'
    if titulo_status eq 1 then titulo=title
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
      tvscl,black,xs0-frame/2,ys0-frame/2    
      tvscl,scale,xs0,ys0

      loadct,0
      contour,scale,findgen(nsx),reform(scale(0,*)),$
              pos=[xs0,ys0,xs0+nsx,ys0+nsy],/device,color=0,/noerase,$
              yticklen=.2,/nodata,ythick=2,xthick=2,charthick=4,$
              xstyle=5,ystyle=1,charsize=5,font=1
    endif

    return
 end
