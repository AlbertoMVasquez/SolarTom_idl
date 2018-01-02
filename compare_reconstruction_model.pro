
pro compare_reconstruction_model,ir=ir,filename=filename,orbit=orbit

input_dir = '/data1/tomography/bindata/'
  
files=['x_AWSOM_CR2081run5_WISPR_sphere_2.dat',$
  'x_wisprI.512.Orbit01.60images_l1e-5',$
  'x_wisprI.512.Orbit12.60images_l1e-5',$
  'x_wisprI.512.Orbit24.60images_l1e-5',$
  'x_wisprO.512.Orbit01.60images_l1e-5',$   
  'x_wisprO.512.Orbit12.60images_l1e-5',$
  'x_wisprO.512.Orbit24.60images_l1e-5',$
  'x_wisprIO.512.Orbit01.60images_l1e-5',$
  'x_wisprIO.512.Orbit24.60images_l1e-5']

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
 readtom_sph,input_dir,files[7],nr,nt,rmin,rmax,Ne_wIO_O24

 scalefactor=4
 rot=4

 device, retain     = 2
 device, true_color = 24
 device, decomposed = 0
 
 window, xs=np*scalefactor, ys=nt*scalefactor*4
 loadct,39

 map1 = reform(Ne_model  (ir,*,*))
 if orbit eq 1 then begin
 map2 = reform(Ne_wI_O01 (ir,*,*))
 map3 = reform(Ne_wO_O01 (ir,*,*))
 map4 = reform(Ne_wIO_O01(ir,*,*))
 endif
 if orbit eq 12 then begin
 map2 = reform(Ne_wI_O12 (ir,*,*))
 map3 = reform(Ne_wO_O12 (ir,*,*))
 map4 = reform(Ne_wIO_O12(ir,*,*))
 endif
 if orbit eq 24 then begin
 map2 = reform(Ne_wI_O24 (ir,*,*))
 map3 = reform(Ne_wO_O24 (ir,*,*))
 map4 = reform(Ne_wIO_O24(ir,*,*))
 endif
 
 mini = min(map1)
 maxi = max(map1)

 map1 = saturate(map1,mini,maxi)
 map2 = saturate(map2,mini,maxi)
 map3 = saturate(map3,mini,maxi)
 map4 = saturate(map4,mini,maxi)
  
 tvscl,alog10(rotate(congrid(map1,nt*scalefactor,np*scalefactor),rot)),0
 tvscl,alog10(rotate(congrid(map2,nt*scalefactor,np*scalefactor),rot)),1
 tvscl,alog10(rotate(congrid(map3,nt*scalefactor,np*scalefactor),rot)),2
 tvscl,alog10(rotate(congrid(map4,nt*scalefactor,np*scalefactor),rot)),3

 record_gif,'~/Pictures/',filename,'X'
 
 stop

end

function saturate,map,mini,maxi
  map(0:1,0) = [mini,maxi]
  map = map > mini < maxi
  return,map
end

 
