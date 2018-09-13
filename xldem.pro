pro xldem,dir=dir,file=file,r0A=r0A,tmmin=tmmin,tmmax=tmmax,nmin=nmin,nmax=nmax,default=default
  common results_images,ima,sima,ra,pa,ya,za,em,npx
  common comunes,tm,wt,nband,demc,PHI,parametrizacion,Tmin,Tmax,nr,nth,np,rad,lat,lon,lambda,WTc
  common results_tomo,tfbe,sfbe,N_e
  common demc_extra,demc2,demc3
  common loss_rate,Er
  common fixed_width,sigma
  common fixed_parameter_equalizer,xmax,sigma_v,demv

  if not keyword_set (r0A) then r0A=[1.025,1.055,1.105,1.155,1.205,1.235]

  if  keyword_set (default) then begin
     if not keyword_set (tmmin) then tmmin=r0A*0.
     if not keyword_set (tmmax) then tmmax=[2.8,2.8,3.,3.2,3.2,3.4];tmmax=[1.7,2.,2.2,2.2,2.,2.]
     if not keyword_set (nmin)  then nmin=r0A*0.
     if not keyword_set (nmax)  then nmax=[2.5,1.6,1.4,1.,.8,.8];nmax=[2.5,2.,1.5,1.1,.8,.8]
     size_vec=[n_elements(r0A),n_elements(tmmin),n_elements(tmmax),n_elements(nmin),n_elements(nmax)]
     if max(size_vec - n_elements(r0A)) ne 0 || min(size_vec - n_elements(r0A)) ne 0  then print,'please insert same size vectors' && stop
  endif
 

  read_ldem_albert,file,/ldem,/gauss1
  ratio=sfbe/tfbe
  chisqr=total( (1.-ratio)^2 , 4 ) / float(nband)
  R=total( abs(1.-ratio), 4 ) / float(nband)

  ZDA = where(demc eq -999.)
  CNS = where(demc ne -999. AND (R      gt 0.25  ))
  superhigh=0.25
  superlow=0.01
  p=where(demc ne -999. AND R ge superhigh) & if p(0) ne -1 then R(p)=superhigh
  if ZDA(0) ne -1 then R(ZDA)=0.;superlow
  
  Nesat = N_e
  Tmsat = Tm
  if ZDA(0) ne -1 then begin
     Nesat(ZDA)=0.
     Tmsat(ZDA)=0.
  endif
  
  if CNS(0) ne -1 then begin
     Nesat(CNS)=0.
     Tmsat(CNS)=0.
  endif


  slv=r0A*0.                    ;superlow
  shv=r0A*0. + superhigh
  pp=where(R gt 0. and R le 0.02)
  R(pp)=0.03
  R(*,0,0) = 0
  R(*,0,1) = 0.25
;esta parte no es correcta, ver el xshell o xcarrmap.
  stop
  if keyword_set (default) or keyword_set (tmmax) or keyword_set (nmax) then begin
     xdisplay,map=R         ,dir=dir,file='R_'+file ,nr=26,nt=90,rmin=1.0,rmax=1.26,r0A=r0A,win=0,minA=slv ,maxA=shv  ,clrtbl=12,titulo='R ' 
     xdisplay,map=Nesat/1.e8,dir=dir,file='Ne_'+file,nr=26,nt=90,rmin=1.0,rmax=1.26,r0A=r0A,win=0,minA=nmin,maxA=nmax, clrtbl= 4,titulo='Ne [10!U8!Ncm!U-3!N]'
     xdisplay,map=Tmsat/1.e6,dir=dir,file='Tm_'+file,nr=26,nt=90,rmin=1.0,rmax=1.26,r0A=r0A,win=0,minA=tmmin,maxA=tmmax,clrtbl= 5,titulo='Tm [MK]'
stop
  endif
  xdisplay,map=R         ,dir=dir,file='R_'+file ,nr=26,nt=90,rmin=1.0,rmax=1.26,r0A=r0A,win=0,clrtbl=12,titulo='R '
  xdisplay,map=Nesat/1.e8,dir=dir,file='Ne_'+file,nr=26,nt=90,rmin=1.0,rmax=1.26,r0A=r0A,win=0,clrtbl= 4,titulo='Ne [10!U8!Ncm!U-3!N]'
  stop 
  xdisplay,map=Tmsat/1.e6,dir=dir,file='Tm_'+file,nr=26,nt=90,rmin=1.0,rmax=1.26,r0A=r0A,win=0,clrtbl= 5,titulo='Tm [MK]'


  return
end
