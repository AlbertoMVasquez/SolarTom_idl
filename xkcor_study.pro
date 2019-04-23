; xkcor_study,model_name='x_KCOR.CR2198.13imgs.bf2.295_90_180_l1e-5',Nr=295,Nth=90,Rmin=1.05,Rmax=4.0,factor=1.e4
; xkcor_study,model_name='x_KCOR.CR2198.13imgs.bf2.295_90_180_l1e-5_CORRECTED',Nr=295,Nth=90,Rmin=1.05,Rmax=4.0,factor=1.e4

pro xkcor_study,model_name=model_name,Nr=Nr,Nth=Nth,Rmin=Rmin,Rmax=Rmax,factor=factor

Nph = 2*Nth
 
readtom_sph,'/data1/tomography_dev/bindata/',model_name,Nr,Nth,Rmin,Rmax,xkcor

xkcor = xkcor * factor

dr=(rmax-rmin)/Nr
r=rmin+dr/2.+dr*findgen(Nr)

Ne_streamer = fltarr(Nr)

; These are specifically selected for CR-2198 ---
ith0=35
ith1=55
iph0= (1./4)*Nph
iph1= (1./2)*Nph
;------------------------------------------------

ir0=0
ir1=Nr-1

for ir=ir0,ir1 do begin
   xtmp = 0.
   Ntmp = 0
   for ith=ith0,ith1 do begin
      for iph=iph0,iph1 do begin
         x1 = xkcor(ir,ith,iph) 
         if x1 gt 0. then begin
            xtmp = xtmp + x1
            Ntmp = Ntmp + 1            
         endif
      endfor   
   endfor
   Ne_streamer[ir] = xtmp / float(Ntmp)
endfor

range_DEMT = where(r ge 1.02 and r le 1.2)
r_DEMT     = r(range_DEMT)
Ne_2081_lloveras_etal = 1.7e8 * exp(-((r_DEMT-1.0)/0.078)/r_DEMT)

;Ne_2081_lloveras_etal = Ne_2081_lloveras_etal * 4.

window,1
!p.charsize=4
 plot,r,Ne_streamer,/ylog,xtitle='r [R!DSUN!N]',ytitle='N!De!N [cm!U-3!N]',$
     title='CR-2198 Average Streamer-Core Density from KCOR Tomography',font=1,$
     xr=[1.,2.],xstyle=1,ystyle=1,psym=4,th=5

 oplot,r_DEMT,Ne_2081_lloveras_etal,linestyle=2,th=4
 
stop
end
