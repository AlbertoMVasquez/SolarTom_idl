pro wrapper_compare

  radial_grid_file='radial_grid_sphere_wedge_WISPR.dat'
 ;radial_grid_file='radial_grid_sphere_wedge_WISPR_20points.dat'

  tol        = 2.0e-1
  correction = 1.;0.15
  
nrads=50
r0A=2.+8.*findgen(nrads)/float(nrads-1)
for i=0,nrads-1 do begin
   compare_reconstruction_model,orbit=01,r0=r0A[i],filename='Ne-WISPR-Tom_CircOrbit_reg2D_Tol-0.20_TEST',/circular_eq,radial_grid_file=radial_grid_file,/CR2082,tol=tol,fraction=fraction,correction=correction
endfor
return


nrads=80
r0A=2.+18.*findgen(nrads)/float(nrads-1)
fraction_A = fltarr(nrads)
for i=0,nrads-1 do begin
   filename0='Ne-WISPR-Tom_Orb-24_reg2D_CR2082'
   compare_reconstruction_model,orbit=24,r0=r0A[i],filename=filename0,/UniformLong,radial_grid_file=radial_grid_file,/CR2082,fraction=fraction,tol=tol
   fraction_A[i]=fraction
endfor
goto,fraction_plot

nrads=80
r0A=2.+18.*findgen(nrads)/float(nrads-1)
fraction_A = fltarr(nrads)
for i=0,nrads-1 do begin
   filename0='Ne-WISPR-Tom_Orb-12_reg2D_CR2082'
   compare_reconstruction_model,orbit=12,r0=r0A[i],filename=filename0,/UniformLong,radial_grid_file=radial_grid_file,/CR2082,fraction=fraction,tol=tol
   fraction_A[i]=fraction
;  stop
endfor
goto,fraction_plot

fraction_plot:
loadct,0
ps1,'~/Pictures/Fraction_'+filename0+'.eps',0
plot,r0A,fraction_A,psym=4,Charsize=2,font=1,title='Tol = '+string(tol),xtitle='r [R!DSUN!N]'
ps2
stop
return


nrads=30
r0A=2.+0.5*findgen(nrads)
for i=0,nrads-1 do compare_reconstruction_model,orbit=24,r0=r0A[i],filename='Ne-WISPR-Tom_Orb-24_reg2D_CR2082_Tol-0.10',/UniformLong,radial_grid_file=radial_grid_file,/CR2082
return

r0A=10.+findgen(31)
nrads=n_elements(r0A)  
for i=0,nrads-1 do compare_reconstruction_model,orbit=01,r0=r0A[i],filename='Ne-WISPR-Tom_Orb-01_reg2D_Tol-0.20',/UniformLong,radial_grid_file=radial_grid_file,/CR2082
return

suffix_model='CR2082'
compare_reconstruction_model,orbit= 1,ir=00,filename='Orbit_CircularEquat_2.1Rs_'+suffix_model+'.gif',/circular_eq,/CR2082
compare_reconstruction_model,orbit= 1,ir=01,filename='Orbit_CircularEquat_2.4Rs_'+suffix_model+'.gif',/circular_eq,/CR2082
compare_reconstruction_model,orbit= 1,ir=03,filename='Orbit_CircularEquat_3.0Rs_'+suffix_model+'.gif',/circular_eq,/CR2082
compare_reconstruction_model,orbit= 1,ir=07,filename='Orbit_CircularEquat_4.8Rs_'+suffix_model+'.gif',/circular_eq,/CR2082
compare_reconstruction_model,orbit= 1,ir=10,filename='Orbit_CircularEquat_6.5Rs_'+suffix_model+'.gif',/circular_eq,/CR2082
compare_reconstruction_model,orbit= 1,ir=13,filename='Orbit_CircularEquat_8.6Rs_'+suffix_model+'.gif',/circular_eq,/CR2082
compare_reconstruction_model,orbit= 1,ir=14,filename='Orbit_CircularEquat_9.3Rs_'+suffix_model+'.gif',/circular_eq,/CR2082

return

stop
compare_reconstruction_model,orbit=12,ir=00,filename='Orb_12_UnifLong_02Rs.gif',/UniformLong
compare_reconstruction_model,orbit=12,ir=03,filename='Orb_12_UnifLong_03Rs.gif',/UniformLong
compare_reconstruction_model,orbit=12,ir=07,filename='Orb_12_UnifLong_05Rs.gif',/UniformLong
compare_reconstruction_model,orbit=12,ir=15,filename='Orb_12_UnifLong_10Rs.gif',/UniformLong
compare_reconstruction_model,orbit=12,ir=20,filename='Orb_12_UnifLong_15Rs.gif',/UniformLong
compare_reconstruction_model,orbit=12,ir=25,filename='Orb_12_UnifLong_20Rs.gif',/UniformLong
compare_reconstruction_model,orbit=12,ir=32,filename='Orb_12_UnifLong_30Rs.gif',/UniformLong
compare_reconstruction_model,orbit=12,ir=39,filename='Orb_12_UnifLong_40Rs.gif',/UniformLong
compare_reconstruction_model,orbit=12,ir=44,filename='Orb_12_UnifLong_50Rs.gif',/UniformLong
compare_reconstruction_model,orbit=12,ir=49,filename='Orb_12_UnifLong_60Rs.gif',/UniformLong
compare_reconstruction_model,orbit=12,ir=54,filename='Orb_12_UnifLong_70Rs.gif',/UniformLong
compare_reconstruction_model,orbit=12,ir=58,filename='Orb_12_UnifLong_80Rs.gif',/UniformLong

stop

compare_reconstruction_model,orbit= 1,ir=15,filename='Orbit_01_10Rs.gif'
compare_reconstruction_model,orbit= 1,ir=25,filename='Orbit_01_20Rs.gif'
compare_reconstruction_model,orbit= 1,ir=32,filename='Orbit_01_30Rs.gif'
compare_reconstruction_model,orbit= 1,ir=39,filename='Orbit_01_40Rs.gif'
compare_reconstruction_model,orbit= 1,ir=44,filename='Orbit_01_50Rs.gif'
compare_reconstruction_model,orbit= 1,ir=49,filename='Orbit_01_60Rs.gif'
compare_reconstruction_model,orbit= 1,ir=54,filename='Orbit_01_70Rs.gif'
compare_reconstruction_model,orbit= 1,ir=58,filename='Orbit_01_80Rs.gif'

stop


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

pro compare_reconstruction_model,r0=r0,filename=filename,orbit=orbit,circular_eq=circular_eq,circular_offeq=circular_offeq,UniformLong=UniformLong,CR2082=CR2082,radial_grid_file=radial_grid_file,fraction=fraction,tol=tol,correction=correction

common adjust,correction_2

correction_2 = correction

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

if keyword_set(CR2082) then begin
   files[0] = 'x_AWSOM_CR2082_sphere_WISPR.dat'
endif
   print,'---> Using model: '+files[0]+' <---'

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


 nt =  90
 np = 180
 readcol,'./DATA/'+radial_grid_file,index,rad,drad,format='U,F,F',skipline=3,/quick
 nr = n_elements(rad)
 rmin = min(rad)
 rmax = max(rad)
 frad = abs(rad-r0)
 ir   = median(where(frad eq min(frad)))
 r0   = rad[ir]
 sufijo = strmid(string(r0),6,5)+'_Rsun'
 filename = filename + '_' + sufijo + '.gif'

 ; Read Model, assign as map1, and set mini/maxi at this height
 readtom_sph,input_dir,files[0],nr,nt,rmin,rmax,Ne_model

 map1 = reform(Ne_model  (ir,*,*)) ;1
 map1 = correct(map1,correction)
 mini = min(map1)
 maxi = max(map1)
 print,'Log10(mini/maxi) at r0 = '+string(r0)+' set to: ',alog10(mini),'    /',alog10(maxi)
 
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

files10=[$
'x_wisprIO.512.CR2081.UnifLong.ExtOrb01.bf4_hlaplac_l1e-6',$
'x_wisprIO.512.CR2081.UnifLong.ExtOrb12.bf4_hlaplac_l1e-6',$
'x_wisprIO.512.CR2081.UnifLong.ExtOrb24.bf4_hlaplac_l1e-6',$
'x_wisprIO.512.CR2081.UnifLong.SciOrb01.bf4_hlaplac_l1e-6',$
'x_wisprIO.512.CR2081.UnifLong.SciOrb12.bf4_hlaplac_l1e-6',$
'x_wisprIO.512.CR2081.UnifLong.SciOrb24.bf4_hlaplac_l1e-6']

if keyword_set(CR2082) then begin
files10[0]='x_wisprIO.512.CR2082.UnifLong.ExtOrb01.bf4_hlaplac_l1e-6'
files10[3]='x_wisprIO.512.CR2082.UnifLong.SciOrb01.bf4_hlaplac_l1e-6'
endif

readtom_sph,input_dir,files10[0],nr,nt,rmin,rmax,Ne_wIO_UnifLong_ExtOrb01_bf4_hlaplac_l1e6
readtom_sph,input_dir,files10[1],nr,nt,rmin,rmax,Ne_wIO_UnifLong_ExtOrb12_bf4_hlaplac_l1e6
readtom_sph,input_dir,files10[2],nr,nt,rmin,rmax,Ne_wIO_UnifLong_ExtOrb24_bf4_hlaplac_l1e6
readtom_sph,input_dir,files10[3],nr,nt,rmin,rmax,Ne_wIO_UnifLong_SciOrb01_bf4_hlaplac_l1e6
readtom_sph,input_dir,files10[4],nr,nt,rmin,rmax,Ne_wIO_UnifLong_SciOrb12_bf4_hlaplac_l1e6
readtom_sph,input_dir,files10[5],nr,nt,rmin,rmax,Ne_wIO_UnifLong_SciOrb24_bf4_hlaplac_l1e6

map36= reform(Ne_wIO_UnifLong_ExtOrb01_bf4_hlaplac_l1e6(ir,*,*))
map37= reform(Ne_wIO_UnifLong_ExtOrb12_bf4_hlaplac_l1e6(ir,*,*))
map38= reform(Ne_wIO_UnifLong_ExtOrb24_bf4_hlaplac_l1e6(ir,*,*))
map39= reform(Ne_wIO_UnifLong_SciOrb01_bf4_hlaplac_l1e6(ir,*,*))
map40= reform(Ne_wIO_UnifLong_SciOrb12_bf4_hlaplac_l1e6(ir,*,*))
map41= reform(Ne_wIO_UnifLong_SciOrb24_bf4_hlaplac_l1e6(ir,*,*))

files11=[$
 'x_wisprIO.512.CR2081.UnifLong.ExtOrb01.bf4_hlaplac_l1e-6_2',$
 'x_wisprIO.512.CR2081.UnifLong.ExtOrb12.bf4_hlaplac_l1e-6_2',$
 'x_wisprIO.512.CR2081.UnifLong.ExtOrb24.bf4_hlaplac_l1e-6_2',$
 'x_wisprIO.512.CR2081.UnifLong.SciOrb01.bf4_hlaplac_l1e-6_2',$
 'x_wisprIO.512.CR2081.UnifLong.SciOrb12.bf4_hlaplac_l1e-6_2',$
;'x_wisprIO.512.CR2081.UnifLong.SciOrb24.bf4.NonUniform_20_90_180.10Rs_r2D_l1e-6']
;'x_wisprIO.512.CR2081.UnifLong.SciOrb24.bf4.NonUniform_20_90_180.10Rs_r3D_l1e-6']
 'x_wisprIO.512.CR2081.UnifLong.SciOrb24.bf4_r3_l1e-6']
;'x_wisprIO.512.CR2081.UnifLong.SciOrb24.bf4_hlaplac_l1e-6_LATEST']

if keyword_set(CR2082) then begin
 files11[5]='x_wisprIO.512.CR2082.UnifLong.SciOrb24.bf4_r3_l1e-6'
 files11[5]='x_wisprIO.512.CR2082.UnifLong.SciOrb24.bf4_hlaplac_l1e-6'

 files11[4]='x_wisprIO.512.CR2082.UnifLong.SciOrb12.bf4_r3_l1e-6'
 files11[4]='x_wisprIO.512.CR2082.UnifLong.SciOrb12.bf4_hlaplac_l1e-6'

 files11[3]='x_wisprIO.512.CR2082.UnifLong.SciOrb01.bf4_r3_l1e-6'
 files11[3]='x_wisprIO.512.CR2082.UnifLong.SciOrb01.bf4_hlaplac_l1e-6_LATEST'

;files11[3]='x_wisprIO.512.CR2082.UnifLong.SciOrb01.bf4_hlaplac_l1e-6'
;files11[3]='x_wisprIO.512.CR2082.UnifLong.SciOrb01.bf4_hlaplac_l1e-6_LATEST_NSUBIT1000'  
;files11[3]='x_wisprIO.512.CR2082.UnifLong.SciOrb01.bf4_r3_l1e-6_NSUBIT1000'
endif

readtom_sph,input_dir,files11[0],nr,nt,rmin,rmax,Ne_wIO_UnifLong_ExtOrb01_bf4_hlaplac_l1e6_2
readtom_sph,input_dir,files11[1],nr,nt,rmin,rmax,Ne_wIO_UnifLong_ExtOrb12_bf4_hlaplac_l1e6_2
readtom_sph,input_dir,files11[2],nr,nt,rmin,rmax,Ne_wIO_UnifLong_ExtOrb24_bf4_hlaplac_l1e6_2
readtom_sph,input_dir,files11[3],nr,nt,rmin,rmax,Ne_wIO_UnifLong_SciOrb01_bf4_hlaplac_l1e6_2
readtom_sph,input_dir,files11[4],nr,nt,rmin,rmax,Ne_wIO_UnifLong_SciOrb12_bf4_hlaplac_l1e6_2
readtom_sph,input_dir,files11[5],nr,nt,rmin,rmax,Ne_wIO_UnifLong_SciOrb24_bf4_hlaplac_l1e6_2

map42= reform(Ne_wIO_UnifLong_ExtOrb01_bf4_hlaplac_l1e6_2(ir,*,*))
map43= reform(Ne_wIO_UnifLong_ExtOrb12_bf4_hlaplac_l1e6_2(ir,*,*))
map44= reform(Ne_wIO_UnifLong_ExtOrb24_bf4_hlaplac_l1e6_2(ir,*,*))
map45= reform(Ne_wIO_UnifLong_SciOrb01_bf4_hlaplac_l1e6_2(ir,*,*))
map46= reform(Ne_wIO_UnifLong_SciOrb12_bf4_hlaplac_l1e6_2(ir,*,*))
map47= reform(Ne_wIO_UnifLong_SciOrb24_bf4_hlaplac_l1e6_2(ir,*,*))

                             files12 = ['x_wisprIO.512.CircularOrbit01.120images_hlaplac_l1e-6']
 if keyword_set(CR2082) then files12 = ['x_wisprIO.512.CircularOrbit01.CR2082.120images_hlaplac_l1e-6']
;if keyword_set(CR2082) then files12 = ['x_wisprIO.512.CircularOrbit01.CR2082.120images_r3_l1e-6']
readtom_sph,input_dir,files12[0],nr,nt,rmin,rmax,Ne_wIO_CO01_120imgs_hlaplac_1e6
map48= reform(Ne_wIO_CO01_120imgs_hlaplac_1e6(ir,*,*))

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

;map1 = saturate(map1,mini,maxi)
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

 map36= saturate(map36,mini,maxi)
 map37= saturate(map37,mini,maxi)
 map38= saturate(map38,mini,maxi)
 map39= saturate(map39,mini,maxi)
 map40= saturate(map40,mini,maxi)
 map41= saturate(map41,mini,maxi)
 
 map42= saturate(map42,mini,maxi)
 map43= saturate(map43,mini,maxi)
 map44= saturate(map44,mini,maxi)
 map45= saturate(map45,mini,maxi)
 map46= saturate(map46,mini,maxi)
 map47= saturate(map47,mini,maxi)

 map48= saturate(map48,mini,maxi)

 device, retain     =  2
 device, true_color = 24
 device, decomposed =  0

 rot         = 4
 scalefactor = 4
 Npanels     = 2
 if keyword_set(circular_eq) OR keyword_set(circular_offeq) then Npanels = 2

 ;---create over-sized window with white background----------------
  xsimage = np*scalefactor
  ysimage = nt*scalefactor
  DX      = xsimage/2
  DY      = ysimage/2
  x0      = DX/2.5
  y0      = (ysimage+DY)*(Npanels-1)
  factor=1.2
  window,0,xs=xsimage+DX,ys=(ysimage+factor*DY)*Npanels
  loadct,27
  tvscl,fltarr(xsimage+DX,(ysimage+factor*DY)*Npanels)

 ;window,0,xs=np*scalefactor, ys=nt*scalefactor*Npanels

   loadct,39
   height_string = strmid(sufijo,0,4)
   x = x0
   frac=0.8
   y = y0+DY*frac
   map = alog10(rotate(congrid(map1 ,nt*scalefactor,np*scalefactor),rot))
  ;map =       (rotate(congrid(map1 ,nt*scalefactor,np*scalefactor),rot))
   mapref = map

  ;ShiftLon = 0.
   ShiftLon = np*scalefactor/2.
   map = shift(map,ShiftLon,ShiftLon)
   carrmap, map=map,xi=x,yi=y,np=np,nt=nt,scalefactor=scalefactor,$
            xtitle_status=0,ytitle_status=1,titulo_status=1,$
            title='Log(Ne [cm!U-3!N]) of Model at '+height_string+' R!DSUN!N',$
            /color_scale,DX=DX,DY=DY,mini=mini,maxi=maxi,xsimage=xsimage,ysimage=ysimage,ShiftLon=ShiftLon
   
if keyword_set(UniformLong) then begin

if orbit eq  1 then begin

    y = (ysimage+DY)*(Npanels-2)+DY*2./3
    goto,skip_extended_01
    map=alog10(rotate(congrid(map36,nt*scalefactor,np*scalefactor),rot))
   ;map=alog10(rotate(congrid(map42,nt*scalefactor,np*scalefactor),rot))
    carrmap,map=map,xi=x,yi=y,np=np,nt=nt,scalefactor=scalefactor,xtitle_status=0,ytitle_status=1,titulo_status=1,title='Reconstruction with Extended Orbit 01'
;map36= reform(Ne_wIO_UnifLong_ExtOrb01_bf4_hlaplac_l1e6(ir,*,*))
;map42= reform(Ne_wIO_UnifLong_ExtOrb01_bf4_hlaplac_l1e6_2(ir,*,*))
    
    y = (ysimage+DY)*(Npanels-3)+DY*2./3
    skip_extended_01:
   ;map=alog10(rotate(congrid(map39,nt*scalefactor,np*scalefactor),rot))
    map=alog10(rotate(congrid(map45,nt*scalefactor,np*scalefactor),rot))
    map=mask(map,mapref,mini,maxi,tol,fraction=fraction)
    carrmap,map=map,xi=x,yi=y,np=np,nt=nt,scalefactor=scalefactor,xtitle_status=1,ytitle_status=1,titulo_status=1,title='Reconstruction for PSP Orbit-01',ShiftLon=ShiftLon
;map39= reform(Ne_wIO_UnifLong_SciOrb01_bf4_hlaplac_l1e6(ir,*,*))
;map45= reform(Ne_wIO_UnifLong_SciOrb01_bf4_hlaplac_l1e6_2(ir,*,*))
 endif
 
 if orbit eq 12 then begin
    y = (ysimage+DY)*(Npanels-2)+DY*2./3
    goto,skip_extended_12
    map=alog10(rotate(congrid(map37,nt*scalefactor,np*scalefactor),rot))
;   map=alog10(rotate(congrid(map43,nt*scalefactor,np*scalefactor),rot))
    carrmap,map=map,xi=x,yi=y,np=np,nt=nt,scalefactor=scalefactor,xtitle_status=0,ytitle_status=1,titulo_status=1,title='Reconstruction with Extended Orbit 12'
;map37= reform(Ne_wIO_UnifLong_ExtOrb12_bf4_hlaplac_l1e6(ir,*,*))
;map43= reform(Ne_wIO_UnifLong_ExtOrb12_bf4_hlaplac_l1e6_2(ir,*,*))

    skip_extended_12:
    y = (ysimage+DY)*(Npanels-2)+DY*4./5
;   map=alog10(rotate(congrid(map40,nt*scalefactor,np*scalefactor),rot))
    map=alog10(rotate(congrid(map46,nt*scalefactor,np*scalefactor),rot))
    map=mask(map,mapref,mini,maxi,tol,fraction=fraction)
    map = shift(map,ShiftLon,ShiftLon)
    carrmap,map=map,xi=x,yi=y,np=np,nt=nt,scalefactor=scalefactor,xtitle_status=1,ytitle_status=1,titulo_status=1,title='Reconstruction for PSP Orbit 12',ShiftLon=ShiftLon
    print,'Fraction:',fraction
;map40= reform(Ne_wIO_UnifLong_SciOrb12_bf4_hlaplac_l1e6(ir,*,*))
;map46= reform(Ne_wIO_UnifLong_SciOrb12_bf4_hlaplac_l1e6_2(ir,*,*))
 endif
 
 if orbit eq 24 then begin
    y = (ysimage+DY)*(Npanels-2)+DY*frac

    goto,skip_extended_24
    goto,include_circular

    map=alog10(rotate(congrid(map38,nt*scalefactor,np*scalefactor),rot))
    map=alog10(rotate(congrid(map44,nt*scalefactor,np*scalefactor),rot))
    carrmap,map=map,xi=x,yi=y,np=np,nt=nt,scalefactor=scalefactor,xtitle_status=0,ytitle_status=1,titulo_status=1,title='Reconstruction with Extended Orbit 24'

  include_circular:
  map=alog10(rotate(congrid(map48,nt*scalefactor,np*scalefactor),rot))
  map=mask(map,mapref,mini,maxi,tol,fraction=fraction)
  map = shift(map,18,ShiftLon)
  carrmap,map=map,xi=x,yi=y,np=np,nt=nt,scalefactor=scalefactor,xtitle_status=0,ytitle_status=1,titulo_status=1,title='Reconstruction for Circular Orbit',ShiftLon=ShiftLon
;map38= reform(Ne_wIO_UnifLong_ExtOrb24_bf4_hlaplac_l1e6(ir,*,*))
;map44= reform(Ne_wIO_UnifLong_ExtOrb24_bf4_hlaplac_l1e6_2(ir,*,*))

    include_12:
    y = (ysimage+DY)*(Npanels-3)+DY*frac
    map=alog10(rotate(congrid(map46,nt*scalefactor,np*scalefactor),rot))
    map=mask(map,mapref,mini,maxi,tol,fraction=fraction)
    carrmap,map=map,xi=x,yi=y,np=np,nt=nt,scalefactor=scalefactor,xtitle_status=0,ytitle_status=1,titulo_status=1,title='Reconstruction for PSP Orbit 12'

    y = (ysimage+DY)*(Npanels-4)+DY*frac

    skip_extended_24:
    y = (ysimage+DY)*(Npanels-2)+DY*4./5
   ;map=alog10(rotate(congrid(map41,nt*scalefactor,np*scalefactor),rot))
    map=alog10(rotate(congrid(map47,nt*scalefactor,np*scalefactor),rot))
    map=mask(map,mapref,mini,maxi,tol,fraction=fraction)
    map = shift(map,ShiftLon,ShiftLon)
    carrmap,map=map,xi=x,yi=y,np=np,nt=nt,scalefactor=scalefactor,xtitle_status=1,ytitle_status=1,titulo_status=1,title='Reconstruction for PSP Orbit 24',ShiftLon=ShiftLon
;map41= reform(Ne_wIO_UnifLong_SciOrb24_bf4_hlaplac_l1e6(ir,*,*))
;map47= reform(Ne_wIO_UnifLong_SciOrb24_bf4_hlaplac_l1e6_2(ir,*,*))
 endif
;stop
endif
 
 if not keyword_set(circular_eq) AND not keyword_set(circular_offeq) AND not keyword_set(UniformLong) then begin
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

  y = (ysimage+DY)*(Npanels-2)+DY*4./5
 ;map=alog10(rotate(congrid(map25,nt*scalefactor,np*scalefactor),rot))
 ;carrmap,map=map,xi=x,yi=y,np=np,nt=nt,scalefactor=scalefactor,xtitle_status=1,ytitle_status=1,titulo_status=1,title='Reconstruction with CircOrb /  60 Images'

  map=alog10(rotate(congrid(map48,nt*scalefactor,np*scalefactor),rot))
 ;map=      (rotate(congrid(map48,nt*scalefactor,np*scalefactor),rot))
  map=mask(map,mapref,mini,maxi,tol,fraction=fraction)
  map = shift(map,ShiftLon,ShiftLon)
  carrmap,map=map,xi=x,yi=y,np=np,nt=nt,scalefactor=scalefactor,xtitle_status=1,ytitle_status=1,titulo_status=1,title='Reconstruction for Circular Orbit',ShiftLon=ShiftLon
;tvscl,alog10(rotate(congrid(map25,nt*scalefactor,np*scalefactor),rot)),1
 
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

function correct,map,correction
  map = map * correction
  return,map
end

function saturate,map,mini,maxi
  common adjust,correction_2
  if finite(min(map)) eq 0 then goto,do_not_saturate
  map = correct(map,correction_2)
  p=median(where(map eq min(map)))
  map(p)=mini
  p=median(where(map eq max(map)))
  map(p)=maxi
  map = map > mini < maxi
  do_not_saturate:
  return,map
end

function mask,map,mapref,mini,maxi,tol,fraction=fraction
  x    = 10.^map
  xref = 10.^mapref
  p = where( (abs(x-xref)/xref) le tol AND x gt 0.)
  Nph   = (size(x))(1)
  Nth   = (size(x))(2)
  dph   = 2.*!pi/float(Nph)
  dth   =    !pi/float(Nth)
  Theta = !pi - dth/2. - dth*findgen(Nth)
  Phi   =       dph/2. + dph*findgen(Nph)
  The2D = fltarr(Nph,Nth)
  for iph=0,Nph-1 do The2D(iph,*)=Theta/!dtor
  Lat2D = 90.-The2D
  Phi2D = fltarr(Nph,Nth)
  for ith=0,Nth-1 do Phi2D(*,ith)=Phi  /!dtor
  A_map = fltarr(Nph,Nth)
  for iph = 0,Nph-1 do A_map(iph,*) = sin(Theta)*dth*dph 
 ;fraction = 1.-float(n_elements(p))/float(n_elements(x))
  fraction = total(A_map(p)) / (4.*!pi)

  p = where( (abs(x-xref)/xref) gt tol AND x gt 0.)
  if p(0) ne -1 then map(p) = alog10(mini)

; p = where(Phi2D ge 100. and Phi2D le 290.)
  p = where(Lat2D lt -60. or  Lat2D gt +60.)
  if p(0) ne -1 then map(p) = alog10(mini)
  
  map(0:1,0) = alog10([mini,maxi])
  map = map > alog10(mini) < alog10(maxi)
  return,map
end

 
pro carrmap,map=map,xi=xi,yi=yi,np=np,nt=nt,scalefactor=scalefactor,$
            xtitle_status=xtitle_status,ytitle_status=ytitle_status,$
            titulo_status=titulo_status,title=title,toptitle=toptitle,$
            color_scale=color_scale,DX=DX,DY=DY,mini=mini,maxi=maxi,$
            xsimage=xsimage,ysimage=ysimage,ShiftLon=ShiftLon

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
    dLon = (LonMAX-LonMIN)/Nlon
    dLat = (LatMAX-LatMIN)/Nlat
    LAT  = LatMIN + dLat/2. + dLat * findgen(NLat) 
    LON  = LonMIN + dLon/2. + dLon * findgen(NLon)
    LON  = shift(LON,ShiftLon)

    extlon = 60.*findgen(7)
    extlonlab = ['180','240','300','360','60','120','180']
    Nextlon = n_elements(extlon)
  
    loadct,40
    xtitle=''
    ytitle=''
    titulo=''
    if xtitle_status eq 1 then xtitle='Carrington Longitude [deg]'
    if ytitle_status eq 1 then ytitle='Latitude [deg]'
    if titulo_status eq 1 then titulo=title
    contour,map,lon,lat,pos=[X,Y,X+nlon,Y+nlat],/noerase,/nodata,$
        /device,color=255,xstyle=1,ystyle=1,charsize=scalefactor*1.2,$
        xtitle=xtitle,$
        ytitle=ytitle,$
        title=titulo,$
        yticklen=.02,xticklen=.03,ythick=2,xthick=2,charthick=1,font=1,$
        xticks=Nextlon-1,xtickname = extlonlab,xtickv=extlon

   if keyword_set(color_scale) then begin
      nsy = ysimage
      nsx = Dx/5

      frame=1
      black = fltarr(Nsx+frame,Nsy+frame)
      scale = fltarr(nsx,nsy)
      logmini = alog10(mini)
      logmaxi = alog10(maxi)
      for ix=0,nsx-1 do scale(ix,*)=logmini+(logmaxi-logmini)*findgen(nsy)/float(nsy-1)
      xs0 = x + xsimage + DX/3
      ys0 = y
      tvscl,black,xs0-frame/2,ys0-frame/2    
      tvscl,scale,xs0,ys0

      loadct,0
      contour,scale,findgen(nsx),reform(scale(0,*)),$
              pos=[xs0,ys0,xs0+nsx,ys0+nsy],/device,color=0,/noerase,$
              yticklen=.2,/nodata,ythick=2,xthick=2,charthick=1,$
              xstyle=5,ystyle=1,charsize=scalefactor,font=1

;       xyouts,[xs0-Dx/10],[ys0+ysimage+DY/10],['Log!d10!N(N!De!N [cm!U-3!N])'],$
;         color=0,charsize=5,charthick=4,font=1,/device
       loadct,39
       
endif
   

    
    return
 end
