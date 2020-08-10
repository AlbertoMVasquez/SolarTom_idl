pro xshell,map=map,r0=r0,ir=ir,scalefactor=scalefactor,clrtbl=clrtbl,mini=mini,maxi=maxi,log=log,interp=interp,win=win,file=file,titulo=titulo,$
           box_lat=box_lat,box_lon=box_lon,instrument=instrument,raiz=raiz,ysize_factor=ysize_factor,mmap_oc=mmap_oc,prefijo_mapoc=prefijo_mapoc

  old_device = !D.NAME

  if not keyword_set(ysize_factor) then ysize_factor=1.

; set graph stuff
  device, retain     = 2
  device, true_color = 24
  device, decomposed = 0
;  DEVICE, SET_FONT='Helvetica Bold Italic', /TT_FONT
;  device,/inches,xsize=10,ysize=7, /helvetica,SCALE_FACTOR=1  ;solo
;  fuciona dentro de eps
  if not keyword_set(pos) then pos=0
  
  nr=fix((size(map))(1))
  nt=fix((size(map))(2))
  np=fix((size(map))(3))
  
  if keyword_set(interp) then $
     map2=rotate(rebin(reform(map(ir,*,*)),nt*scalefactor,np*scalefactor),4)

  if keyword_set(mmap_oc) then load_mapoc,'CR'+prefijo_mapoc+'_90X180blines_r_',r0,/mhd,mapoc

  if NOT keyword_set(interp) then begin
     tmin= -90.
     tmax= +90.
     pmin=   0.
     pmax= 360.
     t=tmin+(tmax-tmin)*findgen(nt)/float(nt-1)
     p=pmin+(pmax-pmin)*findgen(np)/float(np-1)
     map2d=reform(map(ir,*,*))
     if keyword_set(mmap_oc) then     mapoc2d= reform(mapoc(ir,*,*))
     nt2=nt*scalefactor
     np2=np*scalefactor
     t2=tmin+(tmax-tmin)*findgen(nt2)/float(nt2-1)
     p2=pmin+(pmax-pmin)*findgen(np2)/float(np2-1)
     map2  =fltarr(nt2,np2)
     if keyword_set(mmap_oc) then mapoc2=fltarr(nt2,np2)
     for ip2=0,np2-1 do begin
        p0=p2(ip2)
        fp=abs(p-p0)
        ip=fix( (where(fp eq min(fp)))(0) )
        for it2=0,nt2-1 do begin
           t0=t2(it2)
           ft=abs(t-t0)
           it=fix( (where(ft eq min(ft)))(0) )
           map2(it2,ip2)=map2d(it,ip)
           if keyword_set(mmap_oc) then mapoc2(it2,ip2)=mapoc2d(it,ip)
        endfor
     endfor
     map2=rotate(map2,4)
     if keyword_set(mmap_oc) then mapoc2 = rotate(mapoc2,4)
  endif

; Default mini and maxi
  ipos = where(map2 gt 0.)
  if ipos(0) eq -1 then ipos = where(finite(map2) eq 1)  
  if n_elements(mini) eq 0 then mini = min(map2(ipos)) 
  ;keyword_set return 1 for nonzero values, for mini=0 doesn't work 
  if not keyword_set(maxi) then maxi = max(map2(ipos))
  
; Force mini and maxi
  map3=map2
  map2=map2>mini<maxi
  map2(0,0)=mini
;  stop
if keyword_set(treshold) then map2(where(map2 ge 1.3e8 and map2 lt maxi)) = mini
  map2(0,1)=maxi
  ;para treshold dejar el maxi, pero todo entre trsh y maxi llevarlo a mini.
;for R maps
;  if clrtbl eq 12. then begin
;     map2(where(map3 eq -999.)) = 0.
;     low = where(map3 ge 0. and map3 le 0.01)
;     map2(low) =0.01
;     map2(0,0)=0.
  ;necessary to make zda black voxels in R maps and low valuesof R, dark green
;  endif
 
  if keyword_set(log) then begin
     map2=alog10(map2)
     mini=alog10(mini)
     maxi=alog10(maxi)
  endif
  
  if keyword_set(raiz) then begin
     map2=sqrt(map2)
     mini=sqrt(mini)
     maxi=sqrt(maxi)
  endif
  
  if n_elements (box_lat) gt 1. then begin
     map_lat = fltarr(np2,nt2)
     map_lon = fltarr(np2,nt2)
     for it2=0,nt2-1 do map_lon(*,it2) = p2
     for ip2=0,np2-1 do map_lat(ip2,*) = t2
     
     for i=0,n_elements(box_lat)-1 do begin
        near1=Min(Abs(t2 - box_lat(i  )), ind1) & w1 = t2(ind1)
        near2=Min(Abs(t2 - box_lat(i+1)), ind2) & w2 = t2(ind2)
        near3=Min(Abs(p2 - box_lon(i  )), ind3) & w3 = p2(ind3)
        near4=Min(Abs(p2 - box_lon(i+1)), ind4) & w4 = p2(ind4)
        
        index1 = where(map_lat eq w1 and map_lon ge box_lon(i) and map_lon le box_lon(i+1)  )
        index2 = where(map_lat eq w2 and map_lon ge box_lon(i) and map_lon le box_lon(i+1)  )
        index3 = where(map_lon eq w3 and map_lat ge box_lat(i) and map_lat le box_lat(i+1)  )
        index4 = where(map_lon eq w4 and map_lat ge box_lat(i) and map_lat le box_lat(i+1)  )
        map2(index1)=maxi
        map2(index2)=maxi
        map2(index3)=maxi
        map2(index4)=maxi
        i=i+1
     endfor
  endif


 ;---create over-sized window with white background----------------
  Npanels = 1*ysize_factor
  xsimage = np*scalefactor
  ysimage = nt*scalefactor
  DX      = xsimage/1.25
  DY      = ysimage/1.25
  x0      = DX/2.5
  y0      = (ysimage+DY)*(Npanels-1)
;   window,win,xs=xsimage+DX,ys=(ysimage+DY)*Npanels
;  loadct,27
;  tvscl,fltarr(xsimage+DX,(ysimage+DY)*Npanels)
x0=80
y0=60
DX=x0+90
DY=y0+40
;stop
window,win,xs=750,ys=420;xs=np*scalefactor+DX,ys=nt*scalefactor+DY
;window,win,xs=750,ys=420
loadct,27
;tvscl,fltarr(2*np*scalefactor+DX,nt*scalefactor+DY)
tvscl,fltarr(2*np*scalefactor+DX,420)
 
; if clrtbl le 40 then loadct,clrtbl
; if clrtbl gt 40 AND instrument ne 'aia' then secchi_colors, 'EUVI', clrtbl, R, G, B,/load
; if clrtbl gt 40 AND instrument eq 'aia' then aia_lct,wave=clrtbl,/load
    height_string = strmid(string(r0),6,5)
    x = 100;x0
    y = 90;y0+DY/2
    if keyword_set(mmap_oc) then xcarrmap,map=map2,xi=x,yi=y,np=np,nt=nt,scalefactor=scalefactor,clrtbl=clrtbl,$
                                         xtitle_status=1,ytitle_status=1,titulo_status=1,$
                                         title=titulo+' at '+height_string+' R!DSUN!N',$
                                         /color_scale,DX=DX,DY=DY,mini=mini,maxi=maxi,xsimage=xsimage,ysimage=ysimage,instrument=instrument,mmapoc=mapoc2
    if not keyword_set(mmap_oc) then xcarrmap,map=map2,xi=x,yi=y,np=np,nt=nt,scalefactor=scalefactor,clrtbl=clrtbl,$
                                             xtitle_status=1,ytitle_status=1,titulo_status=1,$
                                             title=titulo+' at '+height_string+' R!DSUN!N',$
                                             /color_scale,DX=DX,DY=DY,mini=mini,maxi=maxi,xsimage=xsimage,ysimage=ysimage,instrument=instrument

    str='map_'+file+'_'+height_string+'_Rsun'
    record_gif,'/data1/tomography/SolarTom_idl/Figures/',(STRJOIN(STRSPLIT(str, /EXTRACT,'.'), '_'))+'.gif','X'
    if keyword_set(log) then begin
      mini=10.^mini
      maxi=10.^maxi
   endif
   SET_PLOT, old_device
   return
end
