pro xcompare_wrapper_albert

  r0A=[1.025,1.105,1.205,1.255]
  fileA='x_AIA_CR2209_171b_fd_Rmin1.00_Rmax1.26_Nr26_InstRmax1.26_bf4_r3d_B_L0.85'
  fileB='x_AIA_CR2209_171b_fd_Rmin1.00_Rmax1.30_Nr30_InstRmax1.26_bf4_r3d_B_L0.85'
  dir = '/media/Data1/tomography/bindata/'

   xcompare,dir=dir,fileA=fileA,fileB=fileB,nrA=26,ntA=90,rminA=1.0,rmaxA=1.26,nrB=30,rminB=1.0,rmaxB=1.30,lat_range=[-40.,+40.],lon_range=[160.,240.],$
            comp_suffix='AIA171_CR2209_FD_Quiet-Streamer_OS-NS',x_tit='FBE171-OS',y_tit='FBE171-NS',$
            histo_x_tit='Ratio: FBE171-NS/OS',tit='',rad_y_tit='FBE171',$
            rad_range_A=[1.02,1.26],rad_range_B=[1.02,1.30],r0A=r0A,radd_range=[1.02,1.30],LabelA='OldSet',LabelB='NewSet'
     return


  
   fileA='x_AIA_CR2209_171b_fd_Rmin1.00_Rmax1.30_Nr30_InstRmax1.26_bf4_r3d_B_L0.85'
   fileB='x_AIA_CR2209_171b_fd_Rmin1.00_Rmax1.30_Nr30_InstRmax1.26_bf4_r3d_B_L0.85_B'
   dir = '/media/Data1/tomography/bindata/'

   xcompare,dir=dir,fileA=fileA,fileB=fileB,nrA=30,ntA=90,rminA=1.0,rmaxA=1.30,nrB=30,rminB=1.0,rmaxB=1.30,lat_range=[-40.,+40.],lon_range=[160.,260.],$
            comp_suffix='AIA171_CR2209_FD_Quiet-Streamer',x_tit='FBE171-A',y_tit='FBE171-B',$
            histo_x_tit='Ratio: FBE171-A/B',tit='',rad_y_tit='FBE171',$
            rad_range_A=[1.02,1.30],rad_range_B=[1.02,1.30],r0A=r0A,radd_range=[1.02,1.30]
     return



     
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
