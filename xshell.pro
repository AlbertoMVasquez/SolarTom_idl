pro xshell,map=map,r0=r0,scalefactor=scalefactor,clrtbl=clrtbl,mini=mini,maxi=maxi,rmin=rmin,rmax=rmax,log=log,interp=interp,win=win,file=file,titulo=titulo

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
r0   = rad[ir]

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
if ipos(0) eq -1 then ipos = where(finite(map2) eq 1)  
if not keyword_set(mini) then mini = min(map2(ipos))
if not keyword_set(maxi) then maxi = max(map2(ipos))

; Inform mini and maxi in terminal
print,'---------------------------'
print,'r0A  = ['+string(r0)+']'
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
  DX      = xsimage/1.25
  DY      = ysimage/1.25
  x0      = DX/2.5
  y0      = (ysimage+DY)*(Npanels-1)
  window,win,xs=xsimage+DX,ys=(ysimage+DY)*Npanels
  loadct,27
  tvscl,fltarr(xsimage+DX,(ysimage+DY)*Npanels)

 if clrtbl le 40 then loadct,clrtbl
 if clrtbl gt 40 then secchi_colors, 'EUVI', clrtbl, R, G, B,/load
    height_string = strmid(string(r0),6,5)
    x = x0
    y = y0+DY/2
    xcarrmap,map=map2,xi=x,yi=y,np=np,nt=nt,scalefactor=scalefactor,clrtbl=clrtbl,$
            xtitle_status=1,ytitle_status=1,titulo_status=1,$
            title=titulo+' at '+height_string+' R!DSUN!N',$
            /color_scale,DX=DX,DY=DY,mini=mini,maxi=maxi,xsimage=xsimage,ysimage=ysimage
    record_gif,'/data1/tomography/SolarTom_idl/Figures/','map_'+file+'_'+height_string+'_Rsun.gif','X'

   ; Set mini and maxi back to ZERO
    mini = 0.
    maxi = 0.
return
end
