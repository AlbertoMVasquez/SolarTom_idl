pro wrapper_compare

compare_reconstruction_model,orbit= 1,ir=15,filename='Orbit_01_10Rs.gif'
compare_reconstruction_model,orbit= 1,ir=25,filename='Orbit_01_20Rs.gif'
compare_reconstruction_model,orbit= 1,ir=32,filename='Orbit_01_30Rs.gif'
compare_reconstruction_model,orbit= 1,ir=39,filename='Orbit_01_40Rs.gif'
compare_reconstruction_model,orbit= 1,ir=44,filename='Orbit_01_50Rs.gif'
compare_reconstruction_model,orbit= 1,ir=49,filename='Orbit_01_60Rs.gif'
compare_reconstruction_model,orbit= 1,ir=54,filename='Orbit_01_70Rs.gif'
compare_reconstruction_model,orbit= 1,ir=58,filename='Orbit_01_80Rs.gif'

stop

compare_reconstruction_model,orbit= 1,ir=00,filename='Orbit_CircularEquat_2.1Rs.gif',/circular_eq
compare_reconstruction_model,orbit= 1,ir=03,filename='Orbit_CircularEquat_3.0Rs.gif',/circular_eq
compare_reconstruction_model,orbit= 1,ir=07,filename='Orbit_CircularEquat_4.8Rs.gif',/circular_eq
compare_reconstruction_model,orbit= 1,ir=10,filename='Orbit_CircularEquat_6.5Rs.gif',/circular_eq
compare_reconstruction_model,orbit= 1,ir=13,filename='Orbit_CircularEquat_8.6Rs.gif',/circular_eq

stop

compare_reconstruction_model,orbit=12,ir=15,filename='Orbit_12_10Rs.gif'
compare_reconstruction_model,orbit=12,ir=25,filename='Orbit_12_20Rs.gif'
compare_reconstruction_model,orbit=12,ir=32,filename='Orbit_12_30Rs.gif'
compare_reconstruction_model,orbit=12,ir=39,filename='Orbit_12_40Rs.gif'
compare_reconstruction_model,orbit=12,ir=44,filename='Orbit_12_50Rs.gif'
compare_reconstruction_model,orbit=12,ir=49,filename='Orbit_12_60Rs.gif'
compare_reconstruction_model,orbit=12,ir=54,filename='Orbit_12_70Rs.gif'
compare_reconstruction_model,orbit=12,ir=58,filename='Orbit_12_80Rs.gif'

stop

compare_reconstruction_model,orbit=24,ir=15,filename='Orbit_24_10Rs.gif'
compare_reconstruction_model,orbit=24,ir=25,filename='Orbit_24_20Rs.gif'
compare_reconstruction_model,orbit=24,ir=32,filename='Orbit_24_30Rs.gif'
compare_reconstruction_model,orbit=24,ir=39,filename='Orbit_24_40Rs.gif'
compare_reconstruction_model,orbit=24,ir=44,filename='Orbit_24_50Rs.gif'
compare_reconstruction_model,orbit=24,ir=49,filename='Orbit_24_60Rs.gif'
compare_reconstruction_model,orbit=24,ir=54,filename='Orbit_24_70Rs.gif'
compare_reconstruction_model,orbit=24,ir=58,filename='Orbit_24_80Rs.gif'

return

compare_reconstruction_model,orbit= 1,ir=00,filename='Orbit_CircularOffEq_2.1Rs.gif',/circular_offeq
compare_reconstruction_model,orbit= 1,ir=03,filename='Orbit_CircularOffEq_3.0Rs.gif',/circular_offeq
compare_reconstruction_model,orbit= 1,ir=07,filename='Orbit_CircularOffEq_4.8Rs.gif',/circular_offeq
compare_reconstruction_model,orbit= 1,ir=10,filename='Orbit_CircularOffEq_6.5Rs.gif',/circular_offeq
compare_reconstruction_model,orbit= 1,ir=13,filename='Orbit_CircularOffEq_8.6Rs.gif',/circular_offeq

return

end

pro compare_reconstruction_model,ir=ir,filename=filename,orbit=orbit,circular_eq=circular_eq,circular_offeq=circular_offeq

input_dir = '/data1/tomography/bindata/'
  
files=[$
  'x_AWSOM_CR2081run5_WISPR_sphere_2.dat',$
  'x_wisprI.512.Orbit01.60images_l1e-5',$
  'x_wisprI.512.Orbit12.60images_l1e-5',$
  'x_wisprI.512.Orbit24.60images_l1e-5',$
  'x_wisprO.512.Orbit01.60images_l1e-5',$   
  'x_wisprO.512.Orbit12.60images_l1e-5',$
  'x_wisprO.512.Orbit24.60images_l1e-5',$
  'x_wisprIO.512.Orbit01.60images_l1e-5',$
  'x_wisprIO.512.Orbit12.60images_l1e-5',$
  'x_wisprIO.512.Orbit24.60images_l1e-5']

files1=[$
'x_wisprI.512.Orbit01.60images_3regmat_l1e-5',$      
'x_wisprI.512.Orbit24.60images_3regmat_l1e-5',$      
'x_wisprO.512.Orbit01.60images_3regmat_l1e-5',$      
'x_wisprO.512.Orbit24.60images_3regmat_l1e-5',$      
'x_wisprIO.512.Orbit01.60images_3regmat_l1e-5',$     
'x_wisprIO.512.Orbit24.60images_3regmat_l1e-5']

files2=[$
'x_wisprI.512.CircularOrbit01.60images_l1e-5',$
'x_wisprO.512.CircularOrbit01.60images_l1e-5',$
'x_wisprIO.512.CircularOrbit01.60images_l1e-5']

files3=[$
'x_wisprI.512.CircularOrbit01.60images_3regmat_l1e-5',$
'x_wisprO.512.CircularOrbit01.60images_3regmat_l1e-5',$
'x_wisprIO.512.CircularOrbit01.60images_3regmat_l1e-5']

files4=['x_wisprIO.512.CircularOrbitOffEquator01.60images_hlaplac_l1e-5',$
        'x_wisprIO.512.CircularOrbitOffEquator01.60images_3regmat_l1e-5']

files5=['x_wisprIO.512.Orbit01.60images_identity_l1e-5',$
        'x_wisprIO.512.CircularOrbit01.60images_identity_l1e-5',$
        'x_wisprIO.512.CircularOrbitOffEquator01.60images_identity_l1e-5']

files6=['x_wisprIO.512.Orbit01.60images_identityNEW_l1e-5',$
        'x_wisprIO.512.CircularOrbit01.60images_identityNEW_l1e-5',$
        'x_wisprIO.512.CircularOrbitOffEquator01.60images_identityNEW_l1e-5',$
        'x_wisprIO.512.CircularOrbitOffEquator01.60images_identity_startfrommodel_l1e-5']

files7=['x_wisprIO.512.CircularOrbit01.60images_l1e-4',$
        'x_wisprIO.512.CircularOrbit01.60images_3regmat_l1e-4']

 nr = 100
 nt =  90
 np = 180
 rmin =   2.0
 rmax = 214.5

 readtom_sph,input_dir,files[0],nr,nt,rmin,rmax,Ne_model
 readtom_sph,input_dir,files[1],nr,nt,rmin,rmax,Ne_wI_O01
 readtom_sph,input_dir,files[2],nr,nt,rmin,rmax,Ne_wI_O12
 readtom_sph,input_dir,files[3],nr,nt,rmin,rmax,Ne_wI_O24
 readtom_sph,input_dir,files[4],nr,nt,rmin,rmax,Ne_wO_O01
 readtom_sph,input_dir,files[5],nr,nt,rmin,rmax,Ne_wO_O12
 readtom_sph,input_dir,files[6],nr,nt,rmin,rmax,Ne_wO_O24
 readtom_sph,input_dir,files[7],nr,nt,rmin,rmax,Ne_wIO_O01
 readtom_sph,input_dir,files[8],nr,nt,rmin,rmax,Ne_wIO_O12
 readtom_sph,input_dir,files[9],nr,nt,rmin,rmax,Ne_wIO_O24

 readtom_sph,input_dir,files1[0],nr,nt,rmin,rmax,Ne_wI_O01_3regmat
 readtom_sph,input_dir,files1[1],nr,nt,rmin,rmax,Ne_wI_O24_3regmat
 readtom_sph,input_dir,files1[2],nr,nt,rmin,rmax,Ne_wO_O01_3regmat
 readtom_sph,input_dir,files1[3],nr,nt,rmin,rmax,Ne_wO_O24_3regmat
 readtom_sph,input_dir,files1[4],nr,nt,rmin,rmax,Ne_wIO_O01_3regmat
 readtom_sph,input_dir,files1[5],nr,nt,rmin,rmax,Ne_wIO_O24_3regmat

 readtom_sph,input_dir,files2[0],nr,nt,rmin,rmax,Ne_wI_CO01
 readtom_sph,input_dir,files2[1],nr,nt,rmin,rmax,Ne_wO_CO01
 readtom_sph,input_dir,files2[2],nr,nt,rmin,rmax,Ne_wIO_CO01

 readtom_sph,input_dir,files3[0],nr,nt,rmin,rmax,Ne_wI_CO01_3regmat
 readtom_sph,input_dir,files3[1],nr,nt,rmin,rmax,Ne_wO_CO01_3regmat
 readtom_sph,input_dir,files3[2],nr,nt,rmin,rmax,Ne_wIO_CO01_3regmat

 readtom_sph,input_dir,files4[0],nr,nt,rmin,rmax,Ne_wIO_COOE01_hlaplac
 readtom_sph,input_dir,files4[1],nr,nt,rmin,rmax,Ne_wIO_COOE01_3regmat

 readtom_sph,input_dir,files5[0],nr,nt,rmin,rmax,Ne_wIO_O01_identity
 readtom_sph,input_dir,files5[1],nr,nt,rmin,rmax,Ne_wIO_CO01_identity
 readtom_sph,input_dir,files5[2],nr,nt,rmin,rmax,Ne_wIO_COOE01_identity

 readtom_sph,input_dir,files6[0],nr,nt,rmin,rmax,Ne_wIO_O01_identityNEW
 readtom_sph,input_dir,files6[1],nr,nt,rmin,rmax,Ne_wIO_CO01_identityNEW
 readtom_sph,input_dir,files6[2],nr,nt,rmin,rmax,Ne_wIO_COOE01_identityNEW
 readtom_sph,input_dir,files6[3],nr,nt,rmin,rmax,Ne_wIO_COOE01_identity_startfrommodel

 readtom_sph,input_dir,files7[0],nr,nt,rmin,rmax,Ne_wIO_CO01_hlaplac_1e4
 readtom_sph,input_dir,files7[1],nr,nt,rmin,rmax,Ne_wIO_CO01_3regmat_1e4

files8=[$
'x_wisprIO.512.CircularOrbit01.60images_3regmat_l1e-6',$
'x_wisprIO.512.CircularOrbit01.60images_hlaplac_l1e-6',$
'x_wisprIO.512.CircularOrbit01.60images_identit_l1e-6',$
'x_wisprIO.512.Orbit01.60images_3regmat_l1e-6',$
'x_wisprIO.512.Orbit01.60images_hlaplac_l1e-6',$
'x_wisprIO.512.Orbit01.60images_identit_l1e-6',$
'x_wisprIO.512.Orbit12.60images_hlaplac_l1e-6',$
'x_wisprIO.512.Orbit24.60images_hlaplac_l1e-6']

readtom_sph,input_dir,files8[0],nr,nt,rmin,rmax,Ne_wIO_CO01_3regmat_1e6
readtom_sph,input_dir,files8[1],nr,nt,rmin,rmax,Ne_wIO_CO01_hlaplac_1e6
readtom_sph,input_dir,files8[2],nr,nt,rmin,rmax,Ne_wIO_CO01_identit_1e6
readtom_sph,input_dir,files8[3],nr,nt,rmin,rmax,Ne_wIO_O01_3regmat_1e6
readtom_sph,input_dir,files8[4],nr,nt,rmin,rmax,Ne_wIO_O01_hlaplac_1e6
readtom_sph,input_dir,files8[5],nr,nt,rmin,rmax,Ne_wIO_O01_identit_1e6
readtom_sph,input_dir,files8[6],nr,nt,rmin,rmax,Ne_wIO_O12_hlaplac_1e6
readtom_sph,input_dir,files8[7],nr,nt,rmin,rmax,Ne_wIO_O24_hlaplac_1e6

files9=[$
'x_wisprIO.512.CircularOrbit01.60images_3regmat_l1e0',$
'x_wisprIO.512.CircularOrbit01.60images_hlaplac_l1e0',$
'x_wisprIO.512.CircularOrbit01.60images_identit_l1e0']

readtom_sph,input_dir,files9[0],nr,nt,rmin,rmax,Ne_wIO_CO01_3regmat_1e0
readtom_sph,input_dir,files9[1],nr,nt,rmin,rmax,Ne_wIO_CO01_hlaplac_1e0
readtom_sph,input_dir,files9[2],nr,nt,rmin,rmax,Ne_wIO_CO01_identit_1e0

 map1 = reform(Ne_model  (ir,*,*)) ;1
 if orbit eq 1 then begin
 map2 = reform(Ne_wI_O01 (ir,*,*))
 map3 = reform(Ne_wO_O01 (ir,*,*))
 map4 = reform(Ne_wIO_O01(ir,*,*)) ;4
 map5 = reform(Ne_wI_O01_3regmat(ir,*,*))
 map6 = reform(Ne_wO_O01_3regmat(ir,*,*))
 map7 = reform(Ne_wIO_O01_3regmat(ir,*,*)) ;7
 map8 = reform(Ne_wI_CO01(ir,*,*))
 map9 = reform(Ne_wO_CO01(ir,*,*))
 map10= reform(Ne_wIO_CO01(ir,*,*)) ;10
 map11= reform(Ne_wI_CO01_3regmat(ir,*,*))
 map12= reform(Ne_wO_CO01_3regmat(ir,*,*))
 map13= reform(Ne_wIO_CO01_3regmat(ir,*,*)) ;13
 map14= reform(Ne_wIO_COOE01_hlaplac(ir,*,*))
 map15= reform(Ne_wIO_COOE01_3regmat(ir,*,*))
 map16= reform(Ne_wIO_O01_identity(ir,*,*));16
 map17= reform(Ne_wIO_CO01_identity(ir,*,*))
 map18= reform(Ne_wIO_COOE01_identity(ir,*,*))
;map19= reform(Ne_wIO_O01_identityNEW(ir,*,*))
;map20= reform(Ne_wIO_CO01_identityNEW(ir,*,*))
;map21= reform(Ne_wIO_COOE01_identityNEW(ir,*,*))
 map22= reform(Ne_wIO_COOE01_identity_startfrommodel(ir,*,*))
 map23= reform(Ne_wIO_CO01_hlaplac_1e4(ir,*,*))
 map24= reform(Ne_wIO_CO01_3regmat_1e4(ir,*,*))

 map25= reform(Ne_wIO_CO01_hlaplac_1e6(ir,*,*))
 map26= reform(Ne_wIO_CO01_3regmat_1e6(ir,*,*))
 map27= reform(Ne_wIO_CO01_identit_1e6(ir,*,*))
 
 map28= reform(Ne_wIO_O01_hlaplac_1e6(ir,*,*))
 map29= reform(Ne_wIO_O01_3regmat_1e6(ir,*,*))
 map30= reform(Ne_wIO_O01_identit_1e6(ir,*,*))

 map31= reform(Ne_wIO_CO01_hlaplac_1e0(ir,*,*))
 map32= reform(Ne_wIO_CO01_3regmat_1e0(ir,*,*))
 map33= reform(Ne_wIO_CO01_identit_1e0(ir,*,*))

endif
 if orbit eq 12 then begin
 map2 = reform(Ne_wI_O12 (ir,*,*))
 map3 = reform(Ne_wO_O12 (ir,*,*))
 map4 = reform(Ne_wIO_O12(ir,*,*))
 map34= reform(Ne_wIO_O12_hlaplac_1e6(ir,*,*)) 
 endif
 if orbit eq 24 then begin
 map2 = reform(Ne_wI_O24 (ir,*,*))
 map3 = reform(Ne_wO_O24 (ir,*,*))
 map4 = reform(Ne_wIO_O24(ir,*,*)) ;4
 map5 = reform(Ne_wI_O24_3regmat(ir,*,*))
 map6 = reform(Ne_wO_O24_3regmat(ir,*,*))
 map7 = reform(Ne_wIO_O24_3regmat(ir,*,*)) ;7
 map35= reform(Ne_wIO_O24_hlaplac_1e6(ir,*,*))
 endif

 mini = min(map1)
 maxi = max(map1)
 
 map1 = saturate(map1,mini,maxi)
 map2 = saturate(map2,mini,maxi)
 map3 = saturate(map3,mini,maxi)
 map4 = saturate(map4,mini,maxi)
 if orbit eq 1 then begin
 map5 = saturate(map5,mini,maxi)
 map6 = saturate(map6,mini,maxi)
 map7 = saturate(map7,mini,maxi)

 map8 = saturate(map8 ,mini,maxi)
 map9 = saturate(map9 ,mini,maxi)
 map10= saturate(map10,mini,maxi)
 map11= saturate(map11,mini,maxi)
 map12= saturate(map12,mini,maxi)
 map13= saturate(map13,mini,maxi)
 map14= saturate(map14,mini,maxi)
 map15= saturate(map15,mini,maxi)
 map16= saturate(map16,mini,maxi)
 map17= saturate(map17,mini,maxi)
 map18= saturate(map18,mini,maxi)
;map19= saturate(map19,mini,maxi)
;map20= saturate(map20,mini,maxi)
;map21= saturate(map21,mini,maxi)
 map22= saturate(map22,mini,maxi)
 map23= saturate(map23,mini,maxi)
 map24= saturate(map24,mini,maxi)
 map25= saturate(map25,mini,maxi)
 map26= saturate(map26,mini,maxi)
 map27= saturate(map27,mini,maxi)
 map28= saturate(map28,mini,maxi)
 map29= saturate(map29,mini,maxi)
 map30= saturate(map30,mini,maxi)
 map31= saturate(map31,mini,maxi)
 map32= saturate(map32,mini,maxi)
 map33= saturate(map33,mini,maxi)
endif

if orbit eq 12 then begin
 map34= saturate(map34,mini,maxi)
endif
if orbit eq 24 then begin
 map35= saturate(map35,mini,maxi)
endif
 
 device, retain     = 2
 device, true_color = 24
 device, decomposed = 0
 
 scalefactor=4
 rot=4
 loadct,39

 if not keyword_set(circular_eq) AND not keyword_set(circular_offeq)  then begin
 window,0,xs=np*scalefactor, ys=nt*scalefactor*2
 tvscl,alog10(rotate(congrid(map1,nt*scalefactor,np*scalefactor),rot)),0
;tvscl,alog10(rotate(congrid(map4,nt*scalefactor,np*scalefactor),rot)),1
 if orbit eq  1 then $
 tvscl,alog10(rotate(congrid(map28,nt*scalefactor,np*scalefactor),rot)),1
 if orbit eq 12 then $
 tvscl,alog10(rotate(congrid(map34,nt*scalefactor,np*scalefactor),rot)),1
 if orbit eq 24 then $
 tvscl,alog10(rotate(congrid(map35,nt*scalefactor,np*scalefactor),rot)),1

;tvscl,alog10(rotate(congrid(map7,nt*scalefactor,np*scalefactor),rot)),2
;tvscl,alog10(rotate(congrid(map16,nt*scalefactor,np*scalefactor),rot)),3
;tvscl,alog10(rotate(congrid(map29,nt*scalefactor,np*scalefactor),rot)),5
;tvscl,alog10(rotate(congrid(map30,nt*scalefactor,np*scalefactor),rot)),6
 endif
 if keyword_set(circular_eq) then begin
 window,0,xs=np*scalefactor, ys=nt*scalefactor*2
 tvscl,alog10(rotate(congrid(map1 ,nt*scalefactor,np*scalefactor),rot)),0
;tvscl,alog10(rotate(congrid(map10,nt*scalefactor,np*scalefactor),rot)),1
 tvscl,alog10(rotate(congrid(map25,nt*scalefactor,np*scalefactor),rot)),1
;tvscl,alog10(rotate(congrid(map13,nt*scalefactor,np*scalefactor),rot)),2
;tvscl,alog10(rotate(congrid(map17,nt*scalefactor,np*scalefactor),rot)),3

;tvscl,alog10(rotate(congrid(map26,nt*scalefactor,np*scalefactor),rot)),5
;tvscl,alog10(rotate(congrid(map27,nt*scalefactor,np*scalefactor),rot)),6
;tvscl,alog10(rotate(congrid(map31,nt*scalefactor,np*scalefactor),rot)),7
;tvscl,alog10(rotate(congrid(map32,nt*scalefactor,np*scalefactor),rot)),8
;tvscl,alog10(rotate(congrid(map33,nt*scalefactor,np*scalefactor),rot)),9

;tvscl,alog10(rotate(congrid(map23,nt*scalefactor,np*scalefactor),rot)),4
;tvscl,alog10(rotate(congrid(map24,nt*scalefactor,np*scalefactor),rot)),5
 endif
 if keyword_set(circular_offeq) then begin
 window,0,xs=np*scalefactor, ys=nt*scalefactor*5
 tvscl,alog10(rotate(congrid(map1 ,nt*scalefactor,np*scalefactor),rot)),0
 tvscl,alog10(rotate(congrid(map14,nt*scalefactor,np*scalefactor),rot)),1
 tvscl,alog10(rotate(congrid(map15,nt*scalefactor,np*scalefactor),rot)),2
 tvscl,alog10(rotate(congrid(map18,nt*scalefactor,np*scalefactor),rot)),3
 tvscl,alog10(rotate(congrid(map22,nt*scalefactor,np*scalefactor),rot)),4
 endif
 
 record_gif,'~/Pictures/',filename,'X'
;print,median(map1),median(map10),median(map25),median(map31)
;stop
 return
 
 window,0,xs=np*scalefactor, ys=nt*scalefactor*4
 tvscl,alog10(rotate(congrid(map1,nt*scalefactor,np*scalefactor),rot)),0
 tvscl,alog10(rotate(congrid(map2,nt*scalefactor,np*scalefactor),rot)),1
 tvscl,alog10(rotate(congrid(map3,nt*scalefactor,np*scalefactor),rot)),2
 tvscl,alog10(rotate(congrid(map4,nt*scalefactor,np*scalefactor),rot)),3
 window,1,xs=np*scalefactor, ys=nt*scalefactor*4
 tvscl,alog10(rotate(congrid(map1,nt*scalefactor,np*scalefactor),rot)),0
 tvscl,alog10(rotate(congrid(map5,nt*scalefactor,np*scalefactor),rot)),1
 tvscl,alog10(rotate(congrid(map6,nt*scalefactor,np*scalefactor),rot)),2
 tvscl,alog10(rotate(congrid(map7,nt*scalefactor,np*scalefactor),rot)),3
 if orbit eq 1 then begin
 window,2,xs=np*scalefactor, ys=nt*scalefactor*4
 tvscl,alog10(rotate(congrid(map1 ,nt*scalefactor,np*scalefactor),rot)),0
 tvscl,alog10(rotate(congrid(map8 ,nt*scalefactor,np*scalefactor),rot)),1
 tvscl,alog10(rotate(congrid(map9 ,nt*scalefactor,np*scalefactor),rot)),2
 tvscl,alog10(rotate(congrid(map10,nt*scalefactor,np*scalefactor),rot)),3
 window,3,xs=np*scalefactor, ys=nt*scalefactor*4
 tvscl,alog10(rotate(congrid(map1 ,nt*scalefactor,np*scalefactor),rot)),0
 tvscl,alog10(rotate(congrid(map11,nt*scalefactor,np*scalefactor),rot)),1
 tvscl,alog10(rotate(congrid(map12,nt*scalefactor,np*scalefactor),rot)),2
 tvscl,alog10(rotate(congrid(map13,nt*scalefactor,np*scalefactor),rot)),3
 endif

end

function saturate,map,mini,maxi
  map(0:1,0) = [mini,maxi]
  map = map > mini < maxi
  return,map
end

 
