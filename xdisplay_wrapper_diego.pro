;=========================================================
;Se llevò a cabo una corrida con AIA 2208 usando multistartpoints de
;temperatura para la minimizacion en aquellas celdas donde el R > 0.01
;y Tm <0.6MK. Estas son las celdas usualmente polares donde suele
;encontrarse un minimo local en el borde de la grilla de temperatura (0.5MK).
;
r0A=[1.025,1.065,1.105,1.145,1.185,1.225]

xdisplay,dir='/data1/work/dem/',file='R171_CR2208_DEMT-EUVI_behind_H1-L.50.20.20_r3d',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2208 DEMT: Ne [cm!U-3!N]',maxA=[1,1,1,1,1,1]*0.25,clrtbl=12

xdisplay,dir='/data1/work/dem/',file='R193_CR2208_DEMT-EUVI_behind_H1-L.50.20.20_r3d',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2208 DEMT: Ne [cm!U-3!N]',maxA=[1,1,1,1,1,1]*0.25,clrtbl=12

xdisplay,dir='/data1/work/dem/',file='R211_CR2208_DEMT-EUVI_behind_H1-L.50.20.20_r3d',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2208 DEMT: Ne [cm!U-3!N]',maxA=[1,1,1,1,1,1]*0.25,clrtbl=12


xdisplay,dir='/data1/work/dem/',file='Ne_CR2208_DEMT-AIA_H1_L.5.2.2_r3d',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2208 DEMT: Ne [cm!U-3!N]',clrtbl=4,minA=[0,0,0,0,0,0],maxA=[2.2,1.6,1,.8,.5,.4]*1.e8,/mmap_oc,prefijo_mapoc='2208'

xdisplay,dir='/data1/work/dem/',file='Ne_CR2208_DEMT-AIA_H1_L.5.2.2_r3d_multistart',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2208 DEMT: Ne [cm!U-3!N]',clrtbl=4,minA=[0,0,0,0,0,0],maxA=[2.2,1.6,1,.8,.5,.4]*1.e8,/mmap_oc,prefijo_mapoc='2208'


xdisplay,dir='/data1/work/dem/',file='Tm_CR2208_DEMT-AIA_H1_L.5.2.2_r3d',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2208 DEMT: Te [K]',minA=[0,0,0,0,0,0],maxA=[2.5,2.5,2.5,2.5,2.5,2.5]*1.e6,clrtbl=5,/mmap_oc,prefijo_mapoc='2208'

xdisplay,dir='/data1/work/dem/',file='Tm_CR2208_DEMT-AIA_H1_L.5.2.2_r3d_multistart',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2208 DEMT: Te [K]',minA=[0,0,0,0,0,0],maxA=[2.5,2.5,2.5,2.5,2.5,2.5]*1.e6,clrtbl=5,/mmap_oc,prefijo_mapoc='2208'



xdisplay,dir='/data1/work/dem/',file='Tm_CR2208_DEMT-AIA_H1_L.5.2.2_r3d_multistart2',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2208 DEMT: Te [K]',minA=[0,0,0,0,0,0],maxA=[2.5,2.5,2.5,2.5,2.5,2.5],clrtbl=5,/mmap_oc,prefijo_mapoc='2208',units=1.e6

xdisplay,dir='/data1/work/dem/',file='Ne_CR2208_DEMT-AIA_H1_L.5.2.2_r3d_multistart2',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2208 DEMT: Ne [cm!U-3!N]',clrtbl=4,minA=[0,0,0,0,0,0],maxA=[2.2,1.6,1,.8,.5,.4],/mmap_oc,prefijo_mapoc='2208',units=1.e8

;---------------------
r0A=[1.005]
xdisplay,dir='/data1/work/MHD/',file='Br_awsom_2082_1.85_extend',nr=500,nt=90,rmin=1.,rmax=6.,r0A=r0A,win=0,titulo='Br [G] CR-2082' ,minA=-1*[10],maxA =[10]
xdisplay,dir='/data1/work/MHD/',file='Br_awsom_2208_1.85_extend',nr=500,nt=90,rmin=1.,rmax=6.,r0A=r0A,win=0,titulo='Br [G] CR-2208' ,minA=-1*[10],maxA =[10]
;-----------------------
r0A=[1.065]
xdisplay,dir='/data1/work/dem/',file='Tmfede_multistart_',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2208 R171 2A',minA=[0],maxA=[2.5]*1.e6,clrtbl=5

xdisplay,dir='/data1/work/dem/github_dem/dem/',file='R284fede_multistart_',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2208',minA=[0],maxA=[1.]*0.25,clrtbl=12

;mapas testeo con AIA para Fede
r0A=[1.025,1.065,1.105]

;temp
xdisplay,dir='/data1/work/dem/',file='Tmtest_fede_2a',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2208 R171 2A',minA=[0,0,0],maxA=[1,2.5,2.5]*1.e6,clrtbl=5

xdisplay,dir='/data1/work/dem/',file='TmTest_fede_aia3_g3_temp',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2208 R171 2A',minA=[0,0,0],maxA=[1,2.5,2.5]*1.e6,clrtbl=5

xdisplay,dir='/data1/work/dem/github_dem/dem/',file='R171Test_fede_aia2a_g1',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2208 R171 2A',maxA=[1,1,1]*0.25,clrtbl=12

xdisplay,dir='/data1/work/dem/github_dem/dem/',file='R195Test_fede_aia2a_g1',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2208 R193 2A',maxA=[1,1,1]*0.25,clrtbl=12



xdisplay,dir='/data1/work/dem/github_dem/dem/',file='R171Test_fede_aia2b_g1',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2208 R171 2A',maxA=[1,1,1]*0.25,clrtbl=12

xdisplay,dir='/data1/work/dem/github_dem/dem/',file='R195Test_fede_aia2b_g1',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2208 R193 2B',maxA=[1,1,1]*0.25,clrtbl=12



xdisplay,dir='/data1/work/dem/github_dem/dem/',file='R171Test_fede_aia3_g3',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2208 R171 EQ',maxA=[1,1,1]*0.25,clrtbl=12

xdisplay,dir='/data1/work/dem/github_dem/dem/',file='R195Test_fede_aia3_g3',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2208 R193 EQ',maxA=[1,1,1]*0.25,clrtbl=12

xdisplay,dir='/data1/work/dem/github_dem/dem/',file='R284Test_fede_aia3_g3',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2208 R211 EQ',maxA=[1,1,1]*0.25,clrtbl=12


;-------------------Mppas R_k para ver los problemas en zona abierta
;con AIA

r0A=[1.025,1.065,1.105,1.145,1.185,1.225]
xdisplay,dir='/data1/work/dem/',file='R171_CR2208_DEMT-EUVI_behind_H1-L.50.20.20_r3d',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2208 DEMT: Ne [cm!U-3!N]',maxA=[1,1,1,1,1,1]*0.25,clrtbl=12

xdisplay,dir='/data1/work/dem/',file='R193_CR2208_DEMT-EUVI_behind_H1-L.50.20.20_r3d',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2208 DEMT: Ne [cm!U-3!N]',maxA=[1,1,1,1,1,1]*0.25,clrtbl=12

xdisplay,dir='/data1/work/dem/',file='R211_CR2208_DEMT-EUVI_behind_H1-L.50.20.20_r3d',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2208 DEMT: Ne [cm!U-3!N]',maxA=[1,1,1,1,1,1]*0.25,clrtbl=12




;..................... Treshhold                                                                                                                        
;esta parte es para encontrar treshold en Ne_DEMT con la intencion de recortar las regiones activas                                                   
r0A=[1.065]

xdisplay,dir='/data1/work/dem/',file='Ne_CR2208_DEMT-AIA_H1_L.5.2.2_r3d',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2208 DEMT: Ne [cm!U-3!N]',minA=[0],maxA=[1.6]*1.e8,clrtbl=4

xdisplay,dir='/data1/work/MHD/',file='Ne_awsom_2208_1.85_short'         ,nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2208 AWSOM:Ne [cm!U-3!N]',minA=[0],maxA=[1.6]*1.e8,clrtbl=4


xdisplay,dir='/data1/work/MHD/',file='Ne_awsom_2082_1.85_short',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2082 AWSOM:Ne [cm!U-3!N]',minA=[0],maxA=[1.6]*1.e8,clrtbl=4

xdisplay,dir='/data1/work/dem/',file='Ne_CR2082_DEMT-EUVI_behind_H1-L.35.2.3_r3d',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2082 DEMT: Ne [cm!U-3!N]',minA=[0],maxA=[1.6]*1.e8,clrtbl=4

;hacer un stop en el xdisplay y poner en negro todo aquello mayor a un
;treshold de 1.4 aprox.
;..................................con mapoc - proceeding + topical collectiozn
;awsom
r0A=[1.025,1.065,1.105,1.145,1.185,1.225]
xdisplay,dir='/data1/work/MHD/',file='Ne_awsom_2082_1.85_short',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2082 AWSOM:Ne [10!U8!Ncm!U-3!N]',minA=[0,0,0,0,0,0],maxA=[6,1.6,1,.8,.5,.4],clrtbl=4,/mmap_oc,prefijo_mapoc='2082',units=1.e8

xdisplay,dir='/data1/work/MHD/',file='Ne_awsom_2208_1.85_short',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2208 AWSOM:Ne [10!U8!Ncm!U-3!N]',minA=[0,0,0,0,0,0],maxA=[6,1.6,1,.8,.5,.4],clrtbl=4,/mmap_oc,prefijo_mapoc='2208',units=1.e8

xdisplay,dir='/data1/work/MHD/',file='Te_awsom_2082_1.85_short',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2082 AWSOM: Te [MK]',minA=[0,0,0,0,0,0],maxA=[1,2.5,2.5,2.5,2.5,2.5],clrtbl=5,/mmap_oc,prefijo_mapoc='2082',units=1.e6

xdisplay,dir='/data1/work/MHD/',file='Te_awsom_2208_1.85_short',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2208 AWSOM: Te [MK]',minA=[0,0,0,0,0,0],maxA=[1,2.5,2.5,2.5,2.5,2.5],clrtbl=5,/mmap_oc,prefijo_mapoc='2208',units=1.e6


;demt
r0A=[1.025,1.065,1.105,1.145,1.185,1.225]

xdisplay,dir='/data1/work/dem/',file='Ne_CR2208_DEMT-AIA_H1_L.5.2.2_r3d_multistart2',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2208 DEMT: Ne [10!U8!Ncm!U-3!N]',clrtbl=4,minA=[0,0,0,0,0,0],maxA=[2.2,1.6,1,.8,.5,.4],/mmap_oc,prefijo_mapoc='2208',units=1.e8

;xdisplay,dir='/data1/work/dem/',file='Ne_CR2208_DEMT-AIA_H1_L.5.2.2_r3d',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
;         r0A=r0A,win=0,titulo='CR-2208 DEMT: Ne [cm!U-3!N]',clrtbl=4,minA=[0,0,0,0,0,0],maxA=[2.2,1.6,1,.8,.5,.4]*1.e8,/mmap_oc,prefijo_mapoc='2208'

xdisplay,dir='/data1/work/dem/',file='Ne_CR2082_DEMT-EUVI_behind_H1-L.35.2.3_r3d',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2082 DEMT: Ne [10!U8!Ncm!U-3!N]',minA=[0,0,0,0,0,0],maxA=[2.2,1.6,1,.8,.5,.4],clrtbl=4,/mmap_oc,prefijo_mapoc='2082',units=1.e8


;xdisplay,dir='/data1/work/dem/',file='Tm_CR2208_DEMT-AIA_H1_L.5.2.2_r3d',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
;         r0A=r0A,win=0,titulo='CR-2208 DEMT: Te [K]',minA=[0,0,0,0,0,0],maxA=[2.5,2.5,2.5,2.5,2.5,2.5]*1.e6,clrtbl=5,/mmap_oc,prefijo_mapoc='2208'

xdisplay,dir='/data1/work/dem/',file='Tm_CR2082_DEMT-EUVI_behind_H1-L.35.2.3_r3d',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2082 DEMT: Te [MK]',minA=[0,0,0,0,0,0]*1.e6,maxA=[2.5,2.5,2.5,2.5,2.5,2.5],clrtbl=5,/mmap_oc,prefijo_mapoc='2082',units=1.e6

xdisplay,dir='/data1/work/dem/',file='Tm_CR2208_DEMT-AIA_H1_L.5.2.2_r3d_multistart2',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2208 DEMT: Te [MK]',minA=[0,0,0,0,0,0],maxA=[2.5,2.5,2.5,2.5,2.5,2.5],clrtbl=5,/mmap_oc,prefijo_mapoc='2208',units=1.e6


;mapas de R
r0A=[1.025,1.035,1.045,1.055,1.065,1.085,1.105,1.145,1.225]
xdisplay,dir='/data1/work/dem/',file='R_CR2208_DEMT-AIA_H1_L.5.2.2_r3d',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2208 DEMT: R',maxA=[1,1,1,1,1,1,1,1,1]*0.25,clrtbl=12;,/mmap_oc,prefijo_mapoc='2208'

xdisplay,dir='/data1/work/dem/',file='R_CR2082_DEMT-EUVI_behind_H1-L.35.2.3_r3d',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2082 DEMT: R',maxA=[1,1,1,1,1,1,1,1,1]*0.25,clrtbl=12;,/mmap_oc,prefijo_mapoc='2082'


;---------------------
r0A=[2.,3.,4.,5.,6.]
xdisplay,dir='/data1/work/MHD/',file='Vr_awsom_2082_1.85_extend',nr=500,nt=90,rmin=1.,rmax=6.,r0A=r0A,win=0,titulo='Vr [km/s]'
r0A=[3,4.,5,6]
xdisplay,dir='/data1/work/MHD/',file='Br_awsom_2082_1.85_extend',nr=500,nt=90,rmin=1.,rmax=6.,r0A=r0A,win=0,titulo='Br [G]',minA=-1*[.2,.1,.05,.03],maxA =[.2,.1,.05,.03]

;---------------------------
xdisplay,dir='/data1/tomography/bindata/',file='Ne_CR2198_DEMT-AIA_H1-L0.225_r3D',nr= 26,nt=90,rmin=1.00,rmax=1.26,r0A=r0A,win=0,titulo='DEMT-AIA-FD-r3D: Ne [cm!U-3!N]',minA=minima,maxA=maxima,$
         box_lat=[-25.,05.,-30.,30.,70.,80.,-80.,-70.],box_lon=[180.,210.,0.,60.,200.,360.,190.,290.]
r0A=[1.105,1.155,1.205]
xdisplay,dir='/data1/tomography/bindata/',file='x_KCOR.CR2198.13imgs.bf2.ri1.05.ro4.00_Inst_1.09_2.00_295_90_180_dropneg_r3D_l1e-4',nr=295,nt=90,rmin=1.05,rmax=4.00,r0A=r0A,win=0,titulo=    'KCOR-r3D: Ne [cm!U-3!N]',minima=minima,maxima=maxima, box_lat=[-25.,05.,-30.,30.,70.,80.,-80.,-70.],box_lon=[180.,210.,0.,60.,200.,360.,190.,290.]


xdisplay,dir='/data1/tomography/bindata/',file='Ne_CR2198_DEMT-AIA_H1-L0.225_r3D',nr= 26,nt=90,rmin=1.00,rmax=1.26,r0A=r0A,win=0,titulo='DEMT-AIA-FD-r3D: Ne [cm!U-3!N]',minA=minima,maxA=maxima,$
         box_lat=[-25.,05.,-30.,30.,70.,80.,-80.,-70.],box_lon=[180.,210.,0.,60.,200.,360.,190.,290.]


xdisplay,dir='/data1/tomography/bindata/',file='Ne_CR2198_DEMT-AIA_FD-L0.75_r3D',nr= 26,nt=90,rmin=1.00,rmax=1.26,r0A=r0A,win=0,titulo='DEMT-AIA-FD-r3D: Ne [cm!U-3!N]',minA=minima,maxA=maxima,$
         box_lat=[-25.,05.,-30.,30.,70.,80.,-80.,-70.],box_lon=[180.,210.,0.,60.,200.,360.,190.,290.]


r0A=[1.105]
xdisplay,dir='/data1/work/dem/',file='Ne_CR2198_DEMT-AIA_H1-L.7.9.9_r3D_reduced',nr= 26,nt=90,rmin=1.00,rmax=1.26,r0A=r0A,win=0,titulo='CR-2198 EUV:Ne [cm!U-3!N]',minA=1.,maxA=1.8e8,$
         box_lat=[-40.,0.,70.,80.],box_lon=[230.,320.,180.,360.]

xdisplay,dir='/media/Data1/data1/tomography/bindata/',file='x_KCOR.CR2198.13imgs-reduced.bf2.ri1.05.ro2.25_Inst_1.09_2.00_120_90_180_dropneg_r3D_l1e-4',nr= 120,nt=90,rmin=1.05,rmax=2.25,$
         r0A=r0A,win=0,titulo='CR-2198 WL:Ne [cm!U-3!N]',minA=minima,maxA=2.45e8,box_lat=[-40.,0.,70.,80.],box_lon=[230.,320.,180.,360.]


r0A=[1.105]
xdisplay,dir='/data1/work/dem/',file='Ne_CR2208_l1.0.60.90_h1_r3D_reduced',nr= 30,nt=90,rmin=1.0,rmax=1.30,$
         r0A=r0A,win=0,titulo='CR-2208 EUV:Ne [cm!U-3!N]',minA=1.,maxA=1.8e8,box_lat=[-40.,0.,70.,80.],box_lon=[200.,300.,180.,360.]

xdisplay,dir='/media/Data1/data1/tomography/bindata/',file='x_KCOR.CR2208.13imgs.bf2.ri1.05.ro2.25_Inst_1.09_2.00_120_90_180_dropneg_r3D_l6.e-5',nr= 120,nt=90,rmin=1.05,rmax=2.25,$
         r0A=r0A,win=0,titulo='CR-2208 WL:Ne [cm!U-3!N]',minA=1.,maxA=2.45e8,box_lat=[-40.,0.,70.,80.],box_lon=[200.,300.,180.,360.]

r0A=[1.105]
xdisplay,dir='/data1/DATA/ldem_files/',file='R_CR2208_DEMT-AIA_H1-L1.0.6.9_r3D_reduced',nr= 30,nt=90,rmin=1.0,rmax=1.30,$
         r0A=r0A,win=0,titulo='CR-2208 R',clrtbl=12,maxA=0.25


;poster - freswed2019
r0A=[1.025,1.035,1.105]
xdisplay,dir='/data1/work/MHD/',file='Ne_awsom_2082_1.85_short',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2082 AWSOM:Ne [cm!U-3!N]',maxA=[6,2.5,1]*1.e8,clrtbl=4
r0A=[1.025,1.035,1.105]
xdisplay,dir='/data1/work/MHD/',file='Ne_awsom_2208_1.85',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2208 AWSOM:Ne [cm!U-3!N]',maxA=[6,2.5,1]*1.e8,clrtbl=4


r0A=[1.025,1.035,1.105]
xdisplay,dir='/data1/work/MHD/',file='Te_awsom_2082_1.85_short',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2082 AWSOM: Te [K]',maxA=[1,2,2.5]*1.e6,clrtbl=5
r0A=[1.025,1.035,1.105]
xdisplay,dir='/data1/work/MHD/',file='Te_awsom_2208_1.85',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2208 AWSOM: Te [K]',maxA=[1,2.,2.5]*1.e6,clrtbl=5



r0A=[1.025,1.035,1.105]
xdisplay,dir='/data1/work/dem/',file='Ne_CR2208_DEMT-AIA_H1_L.5.2.2_r3d',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2208 DEMT: Ne [cm!U-3!N]',clrtbl=4,minA=[0,0,0],maxA=[2.5,2.5,1]*1.e8
r0A=[1.025,1.035,1.105]
xdisplay,dir='/data1/work/dem/',file='Ne_CR2082_DEMT-EUVI_behind_H1-L.35.2.3_r3d',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2082 DEMT: Ne [cm!U-3!N]',minA=[0,0,0],maxA=[2.5,2.5,1]*1.e8,clrtbl=4


r0A=[1.025,1.035,1.105,1.155]
xdisplay,dir='/data1/work/dem/',file='Tm_CR2208_DEMT-AIA_H1_L.5.2.2_r3d',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2208 DEMT: Te [K]',maxA=[2,2,2.5,2.5]*1.e6,clrtbl=5
r0A=[1.025,1.035,1.105,1.155]
xdisplay,dir='/data1/work/dem/',file='Tm_CR2082_DEMT-EUVI_behind_H1-L.35.2.3_r3d',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2082 DEMT: Te [K]',maxA=[2,2,2.5,2.5]*1.e6,clrtbl=5


r0A=[1.025,1.035,1.105,1.155,1.205,1.255]
xdisplay,dir='/data1/work/dem/',file='R_CR2208_DEMT-AIA_H1_L.5.2.2_r3d',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2208 DEMT: R',maxA=[1,1,1,1,1,1,1]*0.25,clrtbl=12
r0A=[1.025,1.035,1.105,1.155,1.205,1.255]
xdisplay,dir='/data1/work/dem/',file='R_CR2082_DEMT-EUVI_behind_H1-L.35.2.3_r3d',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2082 DEMT: R',maxA=[1,1,1,1,1,1,1]*0.25,clrtbl=12



r0A=[1.025,1.035,1.105,1.155]
xdisplay,dir='/data1/work/dem/',file='Er_CR2082_DEMT-EUVI_behind_H1-L.35.2.3_r3d',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2082 DEMT: Er [erg cm!U-3!N s!U-1!N]',clrtbl=5,maxA=[30,20,6,3]*1.e-6
r0A=[1.025,1.035,1.105,1.155]
r0A=[1.105]
xdisplay,dir='/data1/work/MHD/',file='qrad_awsom_2082_1.85_short',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2082 awsom: Er [erg cm!U-3!N s!U-1!N]',clrtbl=5


r0A=[1.025,1.035,1.105,1.155]
xdisplay,dir='/data1/work/dem/',file='Er_CR2208_DEMT-EUVI_behind_H1-L.50.20.20_r3d',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2208 DEMT: Er [erg cm!U-3!N s!U-1!N]',clrtbl=5,maxA=[30,20,6,3]*1.e-6
r0A=[1.105]
xdisplay,dir='/data1/work/MHD/',file='qrad_awsom_2208_1.85',nr= 26,nt=90,rmin=1.0,rmax=1.26,$
         r0A=r0A,win=0,titulo='CR-2028 awsom: Er [erg cm!U-3!N s!U-1!N]',clrtbl=5

