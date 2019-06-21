pro xcompare_wrapper

;------------freswed ratios
r0A=[1.105]
lat_range = [-40.,40.]
suff  = '_cr2082_ratio_streamer'
dirB='/data1/work/dem/'
fileA = 'Ne_awsom_2082_1.85_short'
fileB = 'Ne_CR2082_DEMT-EUVI_behind_H1-L.35.2.3_r3d'
fileC = 'R_CR2082_DEMT-EUVI_behind_H1-L.35.2.3_r3d'
xcompare,fileA=fileA,fileB=fileB,nrA=26,ntA=90,rminA=1.0,rmaxA=1.26,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=lat_range,lon_range=[0,360],$
           comp_suffix='Ne_awsom_vs_demt_H'+suff,x_tit='awsom Ne [cm!U-3!N]',y_tit='demt Ne [cm!U-3!N]',$
           histo_x_tit=' Ne (awsom) / Ne (demt)',tit='',rad_y_tit='Ne [cm!U-3!N]',$
           rad_range_A=[1.025,1.25],rad_range_B=[1.025,1.25],r0A=r0A,radd_range=[1.025,1.25],LabelA='awsom',LabelB='demt',dirB=dirB,$
           fileC=fileC,r_crit=0.25,max_ratio=1.5,min_diff=05,max_diff=1.5,scalefactor=2,/ratio_graf

r0A=[1.105]
suff  = '_cr2208_ratio_streamer'
lat_range = [-40.,40.]
dirB='/data1/work/dem/'
fileA = 'Ne_awsom_2208_1.85'
fileB = 'Ne_CR2208_DEMT-AIA_H1_L.5.2.2_r3d'
fileC = 'R_CR2208_DEMT-AIA_H1_L.5.2.2_r3d'
xcompare,fileA=fileA,fileB=fileB,nrA=26,ntA=90,rminA=1.0,rmaxA=1.26,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=lat_range,lon_range=[0,360],$
           comp_suffix='Ne_awsom_vs_demt_H'+suff,x_tit='awsom Ne [cm!U-3!N]',y_tit='demt Ne [cm!U-3!N]',$
           histo_x_tit=' Ne (awsom) / Ne (demt)',tit='',rad_y_tit='Ne [cm!U-3!N]',$
           rad_range_A=[1.025,1.25],rad_range_B=[1.025,1.25],r0A=r0A,radd_range=[1.025,1.25],LabelA='awsom',LabelB='demt',dirB=dirB,$
           fileC=fileC,r_crit=0.25,max_ratio=1.5,min_diff=0.5,max_diff=1.5,scalefactor=2,/ratio_graf


r0A=[1.105]
suff  = '_cr2082_ratio_streamer'
lat_range = [-40.,40.]
dirB='/data1/work/dem/'
fileA = 'Te_awsom_2082_1.85_short'
fileB = 'Tm_CR2082_DEMT-EUVI_behind_H1-L.35.2.3_r3d'
fileC = 'R_CR2082_DEMT-EUVI_behind_H1-L.35.2.3_r3d'
xcompare,fileA=fileA,fileB=fileB,nrA=26,ntA=90,rminA=1.0,rmaxA=1.26,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=lat_range,lon_range=[0,360],$
           comp_suffix='Te_awsom_vs_demt_H'+suff,x_tit='awsom Te [K]',y_tit='demt Te [K]',$
           histo_x_tit='Te (awsom) / Te (demt)',tit='',rad_y_tit='Te [K]',$
           rad_range_A=[1.025,1.25],rad_range_B=[1.025,1.25],r0A=r0A,radd_range=[1.025,1.25],LabelA='awsom',LabelB='demt',dirB=dirB,$
           fileC=fileC,r_crit=0.25,max_ratio=1.5,min_diff=.5,max_diff=1.5,scalefactor=2,/ratio_graf

r0A=[1.105]
suff  = '_cr2208_ratio_streamer'
lat_range = [-40.,40.]
dirB='/data1/work/dem/'
fileA = 'Te_awsom_2208_1.85'
fileB = 'Tm_CR2208_DEMT-AIA_H1_L.5.2.2_r3d'
fileC = 'R_CR2208_DEMT-AIA_H1_L.5.2.2_r3d'
xcompare,fileA=fileA,fileB=fileB,nrA=26,ntA=90,rminA=1.0,rmaxA=1.26,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=lat_range,lon_range=[0,360],$
           comp_suffix='Te_awsom_vs_demt_H'+suff,x_tit='awsom Te [K]',y_tit='demt Te [K]',$
           histo_x_tit='Te (awsom) / Te (demt)',tit='',rad_y_tit='Te [K]',$
           rad_range_A=[1.025,1.25],rad_range_B=[1.025,1.25],r0A=r0A,radd_range=[1.025,1.25],LabelA='awsom',LabelB='demt',dirB=dirB,$
           fileC=fileC,r_crit=0.25,max_ratio=1.5,min_diff=0.5,max_diff=1.5,scalefactor=2,/ratio_graf



r0A=[1.105]
suff  = '_cr2208_ratio_streamer'
lat_range = [-40.,40.]
dirB='/data1/work/dem/'
fileA = 'qrad_awsom_2208_1.85'
fileB = 'Er_CR2208_DEMT-EUVI_behind_H1-L.50.20.20_r3d'
fileC = 'R_CR2208_DEMT-AIA_H1_L.5.2.2_r3d'
xcompare,fileA=fileA,fileB=fileB,nrA=26,ntA=90,rminA=1.0,rmaxA=1.26,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=lat_range,lon_range=[0,360],$
           comp_suffix='Er_awsom_vs_demt_H'+suff,x_tit='awsom Er [Erg cm!U-3!N s!U-1!N]',y_tit='demt Er [Erg cm!U-3!N s!U-1!N]',$
           histo_x_tit='Er (awsom) / Er (demt)',tit='',rad_y_tit='Er [Erg cm!U-3!N s!U-1!N]',$
           rad_range_A=[1.055,1.25],rad_range_B=[1.055,1.25],r0A=r0A,radd_range=[1.055,1.25],LabelA='awsom',LabelB='demt',dirB=dirB,$
           fileC=fileC,r_crit=0.25,min_ratio=-0.5,max_ratio=2.5,min_diff=-0.5,max_diff=2.5,scalefactor=2,histotit='Er at 1.055-1.255 Rsun',/ratio_graf


r0A=[1.105]
suff  = '_cr2082_ratio_streamer'
lat_range = [-40.,40.]
dirB='/data1/work/dem/'
fileA = 'qrad_awsom_2082_1.85_short'
fileB = 'Er_CR2082_DEMT-EUVI_behind_H1-L.35.2.3_r3d'
fileC = 'R_CR2082_DEMT-EUVI_behind_H1-L.35.2.3_r3d'
xcompare,fileA=fileA,fileB=fileB,nrA=26,ntA=90,rminA=1.0,rmaxA=1.26,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=lat_range,lon_range=[0,360],$
           comp_suffix='Er_awsom_vs_demt_H'+suff,x_tit='awsom Er [Erg cm!U-3!N s!U-1!N]',y_tit='demt Er [Erg cm!U-3!N s!U-1!N]',$
           histo_x_tit='Er (awsom) / Er (demt)',tit='',rad_y_tit='Er [Erg cm!U-3!N s!U-1!N]',$
           rad_range_A=[1.055,1.25],rad_range_B=[1.055,1.25],r0A=r0A,radd_range=[1.055,1.25],LabelA='awsom',LabelB='demt',dirB=dirB,$
           fileC=fileC,r_crit=0.25,min_ratio=-0.5,max_ratio=2.5,min_diff=-0.5,max_diff=2.5,scalefactor=2,histotit='Er at 1.055-1.255 Rsun',/ratio_graf






  
;----- para poster freswed 2019
r0A=[1.025,1.035,1.055,1.105,1.155]
suff  = '_cr2082_streamer'
lat_range = [-40.,40.]
dirB='/data1/work/dem/'
fileA = 'Ne_awsom_2082_1.85_short'
fileB = 'Ne_CR2082_DEMT-EUVI_behind_H1-L.35.2.3_r3d'
fileC = 'R_CR2082_DEMT-EUVI_behind_H1-L.35.2.3_r3d'
xcompare,fileA=fileA,fileB=fileB,nrA=26,ntA=90,rminA=1.0,rmaxA=1.26,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=lat_range,lon_range=[0,360],$
           comp_suffix='Ne_awsom_vs_demt_H'+suff,x_tit='awsom Ne [cm!U-3!N]',y_tit='demt Ne [cm!U-3!N]',$
           histo_x_tit=' Ne (awsom) / Ne (demt)',tit='',rad_y_tit='Ne [cm!U-3!N]',$
           rad_range_A=[1.025,1.25],rad_range_B=[1.025,1.25],r0A=r0A,radd_range=[1.025,1.25],LabelA='awsom',LabelB='demt',/diff,dirB=dirB,$
           fileC=fileC,r_crit=0.25,max_ratio=[10,5,5,5,5],min_diff=[1.2,1.2,1.2,1.1,1.1]*(-1),max_diff=[4,1.5,1,0.5,0.5],scalefactor=2


r0A=[1.025,1.035,1.055,1.105,1.155]
suff  = '_cr2208_streamer'
lat_range = [-40.,40.]
dirB='/data1/work/dem/'
fileA = 'Ne_awsom_2208_1.85'
fileB = 'Ne_CR2208_DEMT-AIA_H1_L.5.2.2_r3d'
fileC = 'R_CR2208_DEMT-AIA_H1_L.5.2.2_r3d'
xcompare,fileA=fileA,fileB=fileB,nrA=26,ntA=90,rminA=1.0,rmaxA=1.26,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=lat_range,lon_range=[0,360],$
           comp_suffix='Ne_awsom_vs_demt_H'+suff,x_tit='awsom Ne [cm!U-3!N]',y_tit='demt Ne [cm!U-3!N]',$
           histo_x_tit=' Ne (awsom) / Ne (demt)',tit='',rad_y_tit='Ne [cm!U-3!N]',$
           rad_range_A=[1.025,1.25],rad_range_B=[1.025,1.25],r0A=r0A,radd_range=[1.025,1.25],LabelA='awsom',LabelB='demt',/diff,dirB=dirB,$
           fileC=fileC,r_crit=0.25,max_ratio=[10,5,5,5,5],min_diff=[1.2,1.2,1.2,1.1,1.1]*(-1),max_diff=[4,1.5,1,0.5,0.5],scalefactor=2


r0A=[1.025,1.035,1.055,1.105,1.155]
suff  = '_cr2082_streamer'
lat_range = [-40.,40.]
dirB='/data1/work/dem/'
fileA = 'Te_awsom_2082_1.85_short'
fileB = 'Tm_CR2082_DEMT-EUVI_behind_H1-L.35.2.3_r3d'
fileC = 'R_CR2082_DEMT-EUVI_behind_H1-L.35.2.3_r3d'
xcompare,fileA=fileA,fileB=fileB,nrA=26,ntA=90,rminA=1.0,rmaxA=1.26,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=lat_range,lon_range=[0,360],$
           comp_suffix='Te_awsom_vs_demt_H'+suff,x_tit='awsom Te [K]',y_tit='demt Te [K]',$
           histo_x_tit=' Te (awsom) / Te (demt)',tit='',rad_y_tit='Te [K]',$
           rad_range_A=[1.025,1.25],rad_range_B=[1.025,1.25],r0A=r0A,radd_range=[1.025,1.25],LabelA='awsom',LabelB='demt',/diff,dirB=dirB,$
           fileC=fileC,r_crit=0.25,max_ratio=[5,5,5,5,5],min_diff=[-1,-1,-1,-1,-1]*1.5,max_diff=[.5,.5,1,1,1]*1,scalefactor=2

r0A=[1.025,1.035,1.055,1.105,1.155]
suff  = '_cr2208_streamer'
lat_range = [-40.,40.]
dirB='/data1/work/dem/'
fileA = 'Te_awsom_2208_1.85'
fileB = 'Tm_CR2208_DEMT-AIA_H1_L.5.2.2_r3d'
fileC = 'R_CR2208_DEMT-AIA_H1_L.5.2.2_r3d'
xcompare,fileA=fileA,fileB=fileB,nrA=26,ntA=90,rminA=1.0,rmaxA=1.26,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=lat_range,lon_range=[0,360],$
           comp_suffix='Te_awsom_vs_demt_H'+suff,x_tit='awsom Te [K]',y_tit='demt Te [K]',$
           histo_x_tit=' Te (awsom) / Te (demt)',tit='',rad_y_tit='Te [K]',$
           rad_range_A=[1.025,1.25],rad_range_B=[1.025,1.25],r0A=r0A,radd_range=[1.025,1.25],LabelA='awsom',LabelB='demt',/diff,dirB=dirB,$
           fileC=fileC,r_crit=0.25,max_ratio=[5,5,5,5,5],min_diff=[-1,-1,-1,-1,-1]*1.5,max_diff=[.5,.5,1,1,1]*1,scalefactor=2

;average de CHs
r0A=[1.025,1.035,1.055,1.105,1.155]
suff  = '_cr2082_CHN'
lat_range = [70.,90.]
dirB='/data1/work/dem/'
fileA = 'Ne_awsom_2082_1.85_short'
fileB = 'Ne_CR2082_DEMT-EUVI_behind_H1-L.35.2.3_r3d'
fileC = 'R_CR2082_DEMT-EUVI_behind_H1-L.35.2.3_r3d'
xcompare,fileA=fileA,fileB=fileB,nrA=26,ntA=90,rminA=1.0,rmaxA=1.26,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=lat_range,lon_range=[0,360],$
           comp_suffix='Ne_awsom_vs_demt_H'+suff,x_tit='awsom Ne [cm!U-3!N]',y_tit='demt Ne [cm!U-3!N]',$
           histo_x_tit=' Ne (awsom) / Ne (demt)',tit='',rad_y_tit='Ne [cm!U-3!N]',$
           rad_range_A=[1.025,1.155],rad_range_B=[1.025,1.155],r0A=r0A,radd_range=[1.025,1.155],LabelA='awsom',LabelB='demt',dirB=dirB,$
           fileC=fileC,r_crit=0.25,max_ratio=[10,5,5,5,5],min_diff=[1.2,1.2,1.2,1.1,1.1]*(-1),max_diff=[4,1.5,1,0.5,0.5],scalefactor=2


r0A=[1.025,1.035,1.055,1.105,1.155]
suff  = '_cr2208_CHN'
lat_range = [70.,90.]
dirB='/data1/work/dem/'
fileA = 'Ne_awsom_2208_1.85'
fileB = 'Ne_CR2208_DEMT-AIA_H1_L.5.2.2_r3d'
fileC = 'R_CR2208_DEMT-AIA_H1_L.5.2.2_r3d'
xcompare,fileA=fileA,fileB=fileB,nrA=26,ntA=90,rminA=1.0,rmaxA=1.26,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=lat_range,lon_range=[0,360],$
           comp_suffix='Ne_awsom_vs_demt_H'+suff,x_tit='awsom Ne [cm!U-3!N]',y_tit='demt Ne [cm!U-3!N]',$
           histo_x_tit=' Ne (awsom) / Ne (demt)',tit='',rad_y_tit='Ne [cm!U-3!N]',$
           rad_range_A=[1.025,1.155],rad_range_B=[1.025,1.155],r0A=r0A,radd_range=[1.025,1.155],LabelA='awsom',LabelB='demt',dirB=dirB,$
           fileC=fileC,r_crit=0.25,max_ratio=[10,5,5,5,5],min_diff=[1.2,1.2,1.2,1.1,1.1]*(-1),max_diff=[4,1.5,1,0.5,0.5],scalefactor=2


r0A=[1.025,1.035,1.055,1.105,1.155]
suff  = '_cr2082_CHN'
lat_range = [70.,90.]
dirB='/data1/work/dem/'
fileA = 'Te_awsom_2082_1.85_short'
fileB = 'Tm_CR2082_DEMT-EUVI_behind_H1-L.35.2.3_r3d'
fileC = 'R_CR2082_DEMT-EUVI_behind_H1-L.35.2.3_r3d'
xcompare,fileA=fileA,fileB=fileB,nrA=26,ntA=90,rminA=1.0,rmaxA=1.26,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=lat_range,lon_range=[0,360],$
           comp_suffix='Te_awsom_vs_demt_H'+suff,x_tit='awsom Te [K]',y_tit='demt Te [K]',$
           histo_x_tit=' Te (awsom) / Te (demt)',tit='',rad_y_tit='Te [K]',$
           rad_range_A=[1.025,1.155],rad_range_B=[1.025,1.155],r0A=r0A,radd_range=[1.025,1.155],LabelA='awsom',LabelB='demt',dirB=dirB,$
           fileC=fileC,r_crit=0.25,max_ratio=[5,5,5,5,5],min_diff=[-1,-1,-1,-1,-1]*1.5,max_diff=[.5,.5,1,1,1]*1,scalefactor=2


r0A=[1.025,1.035,1.055,1.105,1.155]
suff  = '_cr2208_CHN'
lat_range = [70.,90.]
dirB='/data1/work/dem/'
fileA = 'Te_awsom_2208_1.85'
fileB = 'Tm_CR2208_DEMT-AIA_H1_L.5.2.2_r3d'
fileC = 'R_CR2208_DEMT-AIA_H1_L.5.2.2_r3d'
xcompare,fileA=fileA,fileB=fileB,nrA=26,ntA=90,rminA=1.0,rmaxA=1.26,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=lat_range,lon_range=[0,360],$
           comp_suffix='Te_awsom_vs_demt_H'+suff,x_tit='awsom Te [K]',y_tit='demt Te [K]',$
           histo_x_tit=' Te (awsom) / Te (demt)',tit='',rad_y_tit='Te [K]',$
           rad_range_A=[1.025,1.155],rad_range_B=[1.025,1.155],r0A=r0A,radd_range=[1.025,1.155],LabelA='awsom',LabelB='demt',dirB=dirB,$
           fileC=fileC,r_crit=0.25,max_ratio=[5,5,5,5,5],min_diff=[-1,-1,-1,-1,-1]*1.5,max_diff=[.5,.5,1,1,1]*1,scalefactor=2










;===============================================================
;---Abajo chequeo para reobtener los mapas del poster de nishtha
r0A=[1.025,1.055,1.105,1.205]
;suff  = '_cr2082_open_N'
;lat_range = [65,90]
suff  = '_cr2082_streamer'
lat_range = [-40.,40.]

dir='/data1/work/dem/'
fileA = 'Ne_awsom_2082_1.85'
fileB = 'Ne_CR2082_DEMT-EUVI_behind_H1-L.35.2.3_r3d'
fileC = 'R_CR2082_DEMT-EUVI_behind_H1-L.35.2.3_r3d'
xcompare,fileA=fileA,fileB=fileB,nrA=26,ntA=90,rminA=1.0,rmaxA=1.26,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=lat_range,lon_range=[0,360],$
           comp_suffix='Ne_awsom_vs_demt_H'+suff,x_tit='awsom Ne [cm!U-3!N]',y_tit='demt Ne [cm!U-3!N]',$
           histo_x_tit='Ratio: Ne (awsom) / Ne (demt)',tit='',rad_y_tit='Ne [cm!U-3!N]',$
           rad_range_A=[1.025,1.25],rad_range_B=[1.025,1.25],r0A=r0A,radd_range=[1.025,1.25],LabelA='awsom',LabelB='demt',/diff,dir=dir,$
           fileC=fileC,r_crit=0.25,max_ratio=[10,5,5,5],min_diff=[-1.5,-1,-1,-1],max_diff=[.5,1,1.5,1.5],scalefactor=2


fileA = 'Te_awsom_2082_1.85'
fileB = 'Tm_CR2082_DEMT-EUVI_behind_H1-L.35.2.3_r3d'
fileC = 'R_CR2082_DEMT-EUVI_behind_H1-L.35.2.3_r3d'

xcompare,fileA=fileA,fileB=fileB,nrA=26,ntA=90,rminA=1.0,rmaxA=1.26,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=lat_range,lon_range=[0,360],$
           comp_suffix='Te_awsom_vs_demt_H'+suff,x_tit='awsom Te [cm!U-3!N]',y_tit='demt Te [K]',$
           histo_x_tit='Ratio: Te (awsom) / Te (demt)',tit='',rad_y_tit='Te [K]',$
           rad_range_A=[1.025,1.25],rad_range_B=[1.025,1.25],r0A=r0A,radd_range=[1.025,1.25],LabelA='awsom',LabelB='demt',/diff,dir=dir,$
           fileC=fileC,r_crit=0.25,max_ratio=[5,5,5,5],min_diff=[-1.2,-1,-1,-1],max_diff=[10,1,1,1],scalefactor=2

;--------------------------------------------------------------------------------
;FD
dir='/data1/work/dem/'
r0A=[1.025,1.055,1.105,1.205]
suff  = '_cr2082_open_N'
lat_range = [65,90]
;suff  = '_cr2082_streamer'
;lat_range = [-40.,40.]
fileA = 'Ne_awsom_2082_1.85'
fileB = 'Ne_CR2082_DEMT-EUVI_behind_FD-L.25.75.5_r3d'
fileC = 'R_CR2082_DEMT-EUVI_behind_FD-L.25.75.5_r3d'

xcompare,fileA=fileA,fileB=fileB,nrA=26,ntA=90,rminA=1.0,rmaxA=1.26,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=lat_range,lon_range=[0,360],$
           comp_suffix='Ne_awsom_vs_demt_FD'+suff,x_tit='awsom Ne [cm!U-3!N]',y_tit='demt Ne [cm!U-3!N]',$
           histo_x_tit='Ratio: Ne (awsom) / Ne (demt)',tit='',rad_y_tit='Ne [cm!U-3!N]',$
           rad_range_A=[1.025,1.25],rad_range_B=[1.025,1.25],r0A=r0A,radd_range=[1.025,1.25],LabelA='awsom',LabelB='demt',/diff,dir=dir,$
           fileC=fileC,r_crit=0.25,max_ratio=[10,5,5,5],min_diff=[-1.5,-1,-1,-1],max_diff=[.5,1,1.5,1.5],scalefactor=2


fileA = 'Te_awsom_2082_1.85'
fileB = 'Tm_CR2082_DEMT-EUVI_behind_FD-L.25.75.5_r3d'
fileC = 'R_CR2082_DEMT-EUVI_behind_FD-L.25.75.5_r3d'

xcompare,fileA=fileA,fileB=fileB,nrA=26,ntA=90,rminA=1.0,rmaxA=1.26,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=lat_range,lon_range=[0,360],$
           comp_suffix='Te_awsom_vs_demt_FD'+suff,x_tit='awsom Te [K]',y_tit='demt Te [K]',$
           histo_x_tit='Ratio: Te (awsom) / Te (demt)',tit='',rad_y_tit='Te [K]',$
           rad_range_A=[1.025,1.25],rad_range_B=[1.025,1.25],r0A=r0A,radd_range=[1.025,1.25],LabelA='awsom',LabelB='demt',/diff,dir=dir,$
           fileC=fileC,r_crit=0.25,max_ratio=[5,5,5,5],min_diff=[-1.2,-1,-1,-1],max_diff=[10,1,1,1],scalefactor=2




  return

  r0A=[1.105,1.155,1.205,1.125,1.165]
;  fileA='x_KCOR.CR2198.13imgs.bf2.ri1.05.ro4.00_Inst_1.09_2.00_295_90_180_dropneg_r3D_l1e-4'
  fileA='x_KCOR.CR2198.13imgs.bf2.ri1.05.ro4.00_Inst_1.09_2.00_295_90_180_dropneg_r3D_l1e-5'
;  fileB='Ne_CR2198_DEMT-AIA_FD-L0.75_r3D'
;  suff='FD'
;fileB='Ne_CR2198_DEMT-AIA_H1-L0.225_r3D'
suff='Hh_redl.2_kcor_subreg'
suff='Hh_l.45_kcor_subreg'
;fileB='Ne_CR2198_DEMT-AIA_H1_reduced-L.1_r3D'
;fileB='Ne_CR2198_DEMT-AIA_H1-L.2_r3D_reduced'
fileB='Ne_CR2198_DEMT-AIA_H1-L.45_r3D'
;...................... Nuevas corridas..................
r0A=[1.105,1.155,1.205,1.125,1.165]
fileA = 'x_KCOR.CR2198.13imgs-reduced.bf2.ri1.05.ro2.25_Inst_1.09_2.00_120_90_180_dropneg_r3D_l1e-4'
fileB = 'Ne_CR2198_DEMT-AIA_H1-L.45_r3D'
suff='Hh_l.45_kcor_1e4_subreg'

fileA = 'x_KCOR.CR2208.13imgs.bf2.ri1.05.ro2.25_Inst_1.09_2.00_120_90_180_dropneg_r3D_l6.e-5'


goto,salt
  xcompare,fileA=fileA,fileB=fileB,nrA=295,ntA=90,rminA=1.05,rmaxA=4.0,nrB=26,rminB=1.0,rmaxB=1.26,$
           comp_suffix='KCOR-Tom_vs_DEMT_CR2198_'+suff+'-All-Latitudes',x_tit='KCOR-Tom Ne [cm!U-3!N]',y_tit='AIA DEMT Ne [cm!U-3!N]',$
           histo_x_tit='Ratio: Ne (KCOR) / Ne (DEMT)',tit='All Latitudes',rad_y_tit='Ne [cm!U-3!N]',$
           rad_range_A=[1.09,2.0],rad_range_B=[1.02,1.23]
  
  xcompare,fileA=fileA,fileB=fileB,nrA=295,ntA=90,rminA=1.05,rmaxA=4.0,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=[-30.,+30.],$
           comp_suffix='KCOR-Tom_vs_DEMT_CR2198_'+suff+'-Low-Latitudes',x_tit='KCOR-Tom Ne [cm!U-3!N]',y_tit='AIA DEMT Ne [cm!U-3!N]',$
           histo_x_tit='Ratio: Ne (KCOR) / Ne (DEMT)',tit='Latitudinal range: [-30!Uo!N,+30!Uo!N]',rad_y_tit='Ne [cm!U-3!N]',$
           rad_range_A=[1.09,2.0],rad_range_B=[1.02,1.23]
  
  xcompare,fileA=fileA,fileB=fileB,nrA=295,ntA=90,rminA=1.05,rmaxA=4.0,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=[+50.,+80.],$
           comp_suffix='KCOR-Tom_vs_DEMT_CR2198_'+suff+'-High-Latitudes_N',x_tit='KCOR-Tom Ne [cm!U-3!N]',y_tit='AIA DEMT Ne [cm!U-3!N]',$
           histo_x_tit='Ratio: Ne (KCOR) / Ne (DEMT)',tit='Latitudinal range: [+50!Uo!N,+80!Uo!N]',rad_y_tit='Ne [cm!U-3!N]',$
           rad_range_A=[1.09,2.0],rad_range_B=[1.02,1.23]
  
  xcompare,fileA=fileA,fileB=fileB,nrA=295,ntA=90,rminA=1.05,rmaxA=4.0,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=[-80.,-50.],$
           comp_suffix='KCOR-Tom_vs_DEMT_CR2198_'+suff+'-High-Latitudes_S',x_tit='KCOR-Tom Ne [cm!U-3!N]',y_tit='AIA DEMT Ne [cm!U-3!N]',$
           histo_x_tit='Ratio: Ne (KCOR) / Ne (DEMT)',tit='Latitudinal range: [-80!Uo!N,-50!Uo!N]',rad_y_tit='Ne [cm!U-3!N]',$
           rad_range_A=[1.09,2.0],rad_range_B=[1.02,1.23]
  
  xcompare,fileA=fileA,fileB=fileB,nrA=295,ntA=90,rminA=1.05,rmaxA=4.0,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=[-30.,10.],lon_range=[100,200],$
           comp_suffix='KCOR-Tom_vs_DEMT_CR2198_'+suff+'-High-density-area',x_tit='KCOR-Tom Ne [cm!U-3!N]',y_tit='AIA DEMT Ne [cm!U-3!N]',$
           histo_x_tit='Ratio: Ne (KCOR) / Ne (DEMT)',tit='Lat: [-30!Uo!N,+10!Uo!N] Lon: [100!Uo!N,200!Uo!N]',rad_y_tit='Ne [cm!U-3!N]',$
           rad_range_A=[1.09,2.0],rad_range_B=[1.02,1.23]
  
  xcompare,fileA=fileA,fileB=fileB,nrA=295,ntA=90,rminA=1.05,rmaxA=4.0,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=[-30.,10.],lon_range=[250,300],$
           comp_suffix='KCOR-Tom_vs_DEMT_CR2198_'+suff+'-Low-density-area',x_tit='KCOR-Tom Ne [cm!U-3!N]',y_tit='AIA DEMT Ne [cm!U-3!N]',$
           histo_x_tit='Ratio: Ne (KCOR) / Ne (DEMT)',tit='Lat: [-30!Uo!N,+10!Uo!N] Lon: [250!Uo!N,300!Uo!N]',rad_y_tit='Ne [cm!U-3!N]',$
           rad_range_A=[1.09,2.0],rad_range_B=[1.02,1.23]
  ;----
  xcompare,fileA=fileA,fileB=fileB,nrA=295,ntA=90,rminA=1.05,rmaxA=4.0,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=[-40.,0.],lon_range=[230,310],$
           comp_suffix='KCOR-Tom_vs_DEMT_CR2198_'+suff+'-Quiet-region1',x_tit='KCOR-Tom Ne [cm!U-3!N]',y_tit='AIA DEMT Ne [cm!U-3!N]',$
           histo_x_tit='Ratio: Ne (KCOR) / Ne (DEMT)',tit='Lat: [-40!Uo!N,0!Uo!N] Lon: [230!Uo!N,310!Uo!N]',rad_y_tit='Ne [cm!U-3!N]',$
           rad_range_A=[1.09,2.0],rad_range_B=[1.02,1.2],r0A=r0A,radd_range=[1.105,1.195]
  
  xcompare,fileA=fileA,fileB=fileB,nrA=295,ntA=90,rminA=1.05,rmaxA=4.0,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=[-30.,30.],lon_range=[0,60],$
           comp_suffix='KCOR-Tom_vs_DEMT_CR2198_'+suff+'-Quiet-region2',x_tit='KCOR-Tom Ne [cm!U-3!N]',y_tit='AIA DEMT Ne [cm!U-3!N]',$
           histo_x_tit='Ratio: Ne (KCOR) / Ne (DEMT)',tit='Lat: [-30!Uo!N,+30!Uo!N] Lon: [0!Uo!N,60!Uo!N]',rad_y_tit='Ne [cm!U-3!N]',$
           rad_range_A=[1.09,2.0],rad_range_B=[1.02,1.2],r0A=r0A,radd_range=[1.105,1.195]

  xcompare,fileA=fileA,fileB=fileB,nrA=295,ntA=90,rminA=1.05,rmaxA=4.0,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=[60.,80.],lon_range=[200,360],$
           comp_suffix='KCOR-Tom_vs_DEMT_CR2198_'+suff+'-Open-region',x_tit='KCOR-Tom Ne [cm!U-3!N]',y_tit='AIA DEMT Ne [cm!U-3!N]',$
           histo_x_tit='Ratio: Ne (KCOR) / Ne (DEMT)',tit='Lat: [60!Uo!N,80!Uo!N] Lon: [200!Uo!N,360!Uo!N]',rad_y_tit='Ne [cm!U-3!N]',$
           rad_range_A=[1.09,2.0],rad_range_B=[1.02,1.2],r0A=r0A,radd_range=[1.105,1.155]

  xcompare,fileA=fileA,fileB=fileB,nrA=295,ntA=90,rminA=1.05,rmaxA=4.0,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=[-30.,10.],lon_range=[160,210],$
           comp_suffix='KCOR-Tom_vs_DEMT_CR2198_'+suff+'-Ative-region',x_tit='KCOR-Tom Ne [cm!U-3!N]',y_tit='AIA DEMT Ne [cm!U-3!N]',$
           histo_x_tit='Ratio: Ne (KCOR) / Ne (DEMT)',tit='Lat: [-30!Uo!N,10!Uo!N] Lon: [160!Uo!N,210!Uo!N]',rad_y_tit='Ne [cm!U-3!N]',$
           rad_range_A=[1.09,2.0],rad_range_B=[1.02,1.2],r0A=r0A,radd_range=[1.105,1.195],Nvals=25

  xcompare,fileA=fileA,fileB=fileB,nrA=295,ntA=90,rminA=1.05,rmaxA=4.0,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=[-25.,0.5],lon_range=[180,210],$
           comp_suffix='KCOR-Tom_vs_DEMT_CR2198_'+suff+'-Ative-region2',x_tit='KCOR-Tom Ne [cm!U-3!N]',y_tit='AIA DEMT Ne [cm!U-3!N]',$
           histo_x_tit='Ratio: Ne (KCOR) / Ne (DEMT)',tit='Lat: [-25!Uo!N,05!Uo!N] Lon: [180!Uo!N,210!Uo!N]',rad_y_tit='Ne [cm!U-3!N]',$
           rad_range_A=[1.09,2.0],rad_range_B=[1.02,1.2],r0A=r0A,radd_range=[1.105,1.195],Nvals=25

  xcompare,fileA=fileA,fileB=fileB,nrA=295,ntA=90,rminA=1.05,rmaxA=4.0,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=[-30.,30.],lon_range=[0,60],$
           comp_suffix='KCOR-Tom_vs_DEMT_CR2198_'+suff+'-Quiet-region2',x_tit='KCOR-Tom Ne [cm!U-3!N]',y_tit='AIA DEMT Ne [cm!U-3!N]',$
           histo_x_tit='Ratio: Ne (KCOR) / Ne (DEMT)',tit='Lat: [-30!Uo!N,+30!Uo!N] Lon: [0!Uo!N,60!Uo!N]',rad_y_tit='Ne [cm!U-3!N]',$
           rad_range_A=[1.09,2.0],rad_range_B=[1.02,1.2],r0A=r0A,radd_range=[1.105,1.195]

  xcompare,fileA=fileA,fileB=fileB,nrA=295,ntA=90,rminA=1.05,rmaxA=4.0,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=[70.,80.],lon_range=[200,360],$
           comp_suffix='KCOR-Tom_vs_DEMT_CR2198_'+suff+'-Open-region_N',x_tit='KCOR-Tom Ne [cm!U-3!N]',y_tit='AIA DEMT Ne [cm!U-3!N]',$
           histo_x_tit='Ratio: Ne (KCOR) / Ne (DEMT)',tit='Lat: [70!Uo!N,80!Uo!N] Lon: [200!Uo!N,360!Uo!N]',rad_y_tit='Ne [cm!U-3!N]',$
           rad_range_A=[1.09,2.0],rad_range_B=[1.02,1.2],r0A=r0A,radd_range=[1.105,1.155]

  xcompare,fileA=fileA,fileB=fileB,nrA=295,ntA=90,rminA=1.05,rmaxA=4.0,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=[-80.,-70.],lon_range=[190,290],$
           comp_suffix='KCOR-Tom_vs_DEMT_CR2198_'+suff+'-Open-region_S',x_tit='KCOR-Tom Ne [cm!U-3!N]',y_tit='AIA DEMT Ne [cm!U-3!N]',$
           histo_x_tit='Ratio: Ne (KCOR) / Ne (DEMT)',tit='Lat: [-80!Uo!N,-70!Uo!N] Lon: [190!Uo!N,290!Uo!N]',rad_y_tit='Ne [cm!U-3!N]',$
           rad_range_A=[1.09,2.0],rad_range_B=[1.02,1.2],r0A=r0A,radd_range=[1.105,1.155]
salt:
  xcompare,fileA=fileA,fileB=fileB,nrA=295,ntA=90,rminA=1.05,rmaxA=4.0,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=[-40.,0.],lon_range=[230,320],$
           comp_suffix='KCOR-Tom_vs_DEMT_CR2198_'+suff+'-Quiet-region1',x_tit='WL Ne [cm!U-3!N]',y_tit='EUV Ne [cm!U-3!N]',$
           histo_x_tit='Ratio: Ne (WL) / Ne (EUV)',tit='',rad_y_tit='Ne [cm!U-3!N]',$
           rad_range_A=[1.09,2.0],rad_range_B=[1.02,1.2],r0A=r0A,radd_range=[1.105,1.195]
stop

 xcompare,fileA=fileA,fileB=fileB,nrA=295,ntA=90,rminA=1.05,rmaxA=4.0,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=[70.,80.],lon_range=[180,360],$
           comp_suffix='KCOR-Tom_vs_DEMT_CR2198_'+suff+'-Open-region_N',x_tit='WL Ne [cm!U-3!N]',y_tit='EUV Ne [cm!U-3!N]',$
           histo_x_tit='Ratio: Ne (WL) / Ne (EUV)',tit='',rad_y_tit='Ne [cm!U-3!N]',$
           rad_range_A=[1.09,2.0],rad_range_B=[1.02,1.155],r0A=r0A,radd_range=[1.105,1.155]


  return
end


pro nuevas_cosas

;...................... Nuevas corridas..................                                                                   
r0A=[1.105,1.155,1.205]
fileA = 'x_KCOR.CR2198.13imgs-reduced.bf2.ri1.05.ro2.25_Inst_1.09_2.00_120_90_180_dropneg_r3D_l1e-4'
fileB = 'Ne_CR2198_DEMT-AIA_H1-L.7.9.9_r3D_reduced'
suff='h_l.7.9.9_reduced_kcor_1e4_newgrid'

  xcompare,fileA=fileA,fileB=fileB,nrA=120,ntA=90,rminA=1.05,rmaxA=2.25,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=[-40.,0.],lon_range=[230,320],$
           comp_suffix='KCOR-Tom_vs_DEMT_CR2198_'+suff+'-Quiet-region1',x_tit='WL Ne [cm!U-3!N]',y_tit='EUV Ne [cm!U-3!N]',$
           histo_x_tit=' Ne (WL) / Ne (EUV)',tit='',rad_y_tit='Ne [cm!U-3!N]',labelA='Kcor',labelB='DEMT',$
           rad_range_A=[1.09,2.0],rad_range_B=[1.09,1.2],r0A=r0A,radd_range=[1.105,1.195],dirA='/media/Data1/data1/tomography/bindata/',$
           dirB='/data1/work/dem/',histotit='Streamer Quiet Region'

 xcompare,fileA=fileA,fileB=fileB,nrA=120,ntA=90,rminA=1.05,rmaxA=2.25,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=[70.,80.],lon_range=[180,360],$
           comp_suffix='KCOR-Tom_vs_DEMT_CR2198_'+suff+'-Open-region_N',x_tit='WL Ne [cm!U-3!N]',y_tit='EUV Ne [cm!U-3!N]',$
           histo_x_tit=' Ne (WL) / Ne (EUV)',tit='',rad_y_tit='Ne [cm!U-3!N]',labelA='Kcor',labelB='DEMT',$
           rad_range_A=[1.09,2.0],rad_range_B=[1.09,1.155],r0A=r0A,radd_range=[1.105,1.155],dirA='/media/Data1/data1/tomography/bindata/',$
           dirB='/data1/work/dem/',histotit='Subpolar Open  Region'
;-------------------------------corridas 2208

 r0A=[1.105,1.155,1.205]
fileA = 'x_KCOR.CR2208.13imgs.bf2.ri1.05.ro2.25_Inst_1.09_2.00_120_90_180_dropneg_r3D_l6.e-5'
fileB = 'Ne_CR2208_l1.0.60.90_h1_r3D_reduced'
suff='h_l1.0.6.9_reduced_kcor_6e5_newgrid'
 

  xcompare,fileA=fileA,fileB=fileB,nrA=120,ntA=90,rminA=1.05,rmaxA=2.25,nrB=30,rminB=1.0,rmaxB=1.30,lat_range=[-40.,0.],lon_range=[200,300],$
           comp_suffix='KCOR-Tom_vs_DEMT_CR2208_'+suff+'-Quiet-region2',x_tit='WL Ne [cm!U-3!N]',y_tit='EUV Ne [cm!U-3!N]',$
           histo_x_tit=' Ne (WL) / Ne (EUV)',tit='',rad_y_tit='Ne [cm!U-3!N]',labelA='Kcor',labelB='DEMT',$
           rad_range_A=[1.09,2.0],rad_range_B=[1.09,1.2],r0A=r0A,radd_range=[1.105,1.195],dirA='/media/Data1/data1/tomography/bindata/',$
           dirB='/data1/work/dem/',histotit='Streamer Quiet Region'

  
 xcompare,fileA=fileA,fileB=fileB,nrA=120,ntA=90,rminA=1.05,rmaxA=2.25,nrB=30,rminB=1.0,rmaxB=1.30,lat_range=[70.,80.],lon_range=[180,360],$
           comp_suffix='KCOR-Tom_vs_DEMT_CR2208_'+suff+'-Open-region_N',x_tit='WL Ne [cm!U-3!N]',y_tit='EUV Ne [cm!U-3!N]',$
           histo_x_tit=' Ne (WL) / Ne (EUV)',tit='',rad_y_tit='Ne [cm!U-3!N]',labelA='Kcor',labelB='DEMT',$
           rad_range_A=[1.09,2.0],rad_range_B=[1.09,1.155],r0A=r0A,radd_range=[1.105,1.155],dirA='/media/Data1/data1/tomography/bindata/',$
           dirB='/data1/work/dem/',histotit='Subpolar Open  Region'


  return
end
