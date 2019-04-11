pro xcompare_wrapper_albert

   dir = '/data1/tomography_dev/bindata/'
   r0A = [1.09,1.155,1.195]

   fileA = 'x_KCOR.CR2198.13imgs.bf2.ri1.05.ro2.00_Inst_1.09_2.00_95_90_180_dropneg_r3D_l1e-4'
   fileB = 'x_KCOR.CR2198.13imgs.bf2.ri1.05.ro4.00_Inst_1.09_2.00_295_90_180_dropneg_r3D_l1e-4'

   suff=''
   
  xcompare,fileA=fileA,fileB=fileB,nrA=95,ntA=90,rminA=1.05,rmaxA=2.0,nrB=295,rminB=1.05,rmaxB=4.0,r0A=r0A,$
           comp_suffix='KCOR-Tom_095_vs_295_CR2198_'+suff+'-All-Latitudes',x_tit='KCOR-095 Ne [cm!U-3!N]',y_tit='KCOR-295 Ne [cm!U-3!N]',$
           histo_x_tit='Ratio: Ne (KCOR-295) / Ne (LCOR-095)',tit='All Latitudes',rad_y_tit='Ne [cm!U-3!N]',$
           rad_range_A=[1.09,2.0],rad_range_B=[1.09,4.0],LabelA='KCOR-095',LabelB='KCOR-295'

  stop
  
   dir = '/data1/tomography_dev/bindata/'
   r0A = [1.025,1.105,1.155,1.205]

;x_aia.171.cr2198.26x90_bf4_ri.00_ro1.09_l0.65_h1_Oldset_r3d
;x_aia.171.cr2198.26x90_bf4_ri.00_ro1.09_l0.65_h1_Oldset_r3d_NSUBIT1000
;x_aia.171.cr2198.26x90_bf4_ri.00_ro1.09_l0.65_h1_Oldset_r3d_NSUBIT1000_BTOL0.001
 
   fileA='x_aia.171.cr2198.26x90_bf4_ri.00_ro1.09_l0.65_h1_Oldset_r3d'
   fileB='x_aia.171.cr2198.26x90_bf4_ri.00_ro1.09_l0.65_h1_Oldset_r3d_NSUBIT1000_BTOL0.001'
   xcompare,dir=dir,fileA=fileA,fileB=fileB,nrA=26,ntA=90,rminA=1.0,rmaxA=1.26,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=[-90.,+90.],lon_range=[0.,360.],$
            comp_suffix='COMP2',$
            histo_x_tit='Ratio',tit='',rad_y_tit='FBE171',$
            rad_range_A=[1.0,1.5],rad_range_B=[1.0,1.3],r0A=r0A,LabelA='Default',LabelB='BTOL0.001'
   return

   dir = '/data1/tomography_dev/bindata/'
   r0A = [1.095,1.155,1.205,1.255,1.295]
   
   fileA='x.comp1074.dynamics.Dt2_CR2198.bf2.ri1.00.ro1.50_50_90_180_r3D_2.65_IRMIN_1.09'    
   fileB='x.comp1074.dynamics.Dt2_CR2198.bf2.ri1.00.ro1.30_30_90_180_IRad1.09-1.26_L2.65'
   xcompare,dir=dir,fileA=fileA,fileB=fileB,nrA=50,ntA=90,rminA=1.0,rmaxA=1.5,nrB=30,rminB=1.0,rmaxB=1.3,lat_range=[-90.,+90.],lon_range=[0.,360.],$
            comp_suffix='COMP1074_CR2198_NB_50-30',$
            histo_x_tit='Ratio: E1074-NB-50/30',tit='',rad_y_tit='E1074',$
            rad_range_A=[1.0,1.5],rad_range_B=[1.0,1.3],r0A=r0A,LabelA='B1.09-Nr50',LabelB='B1.09-Nr30'
   return

   
   fileA='x.comp1074.dynamics.Dt2_CR2198.bf2.ri1.00.ro1.50_50_90_180_r3D_2.65'
   fileB='x.comp1074.dynamics.Dt2_CR2198.bf2.ri1.00.ro1.50_50_90_180_r3D_2.65_IRMIN_1.09'    
   xcompare,dir=dir,fileA=fileA,fileB=fileB,nrA=50,ntA=90,rminA=1.0,rmaxA=1.5,nrB=50,rminB=1.0,rmaxB=1.5,lat_range=[-90.,+90.],lon_range=[0.,360.],$
            comp_suffix='COMP1074_CR2198_NG_OB-NB',$
            histo_x_tit='Ratio: E1074-NG-OB/NB',tit='',rad_y_tit='E1074',$
            rad_range_A=[1.0,1.5],rad_range_B=[1.0,1.5],r0A=r0A,LabelA='NG-B1.05',LabelB='NG-B1.09'

   fileA='x.comp1074.dynamics.Dt2_CR2198.bf2.ri1.00.ro1.26_26_90_180_r3D_2.65'
   fileB='x.comp1074.dynamics.Dt2_CR2198.bf2.ri1.00.ro1.26_26_90_180_r3D_2.65_IRMIN_1.09'
   xcompare,dir=dir,fileA=fileA,fileB=fileB,nrA=26,ntA=90,rminA=1.0,rmaxA=1.26,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=[-90.,+90.],lon_range=[0.,360.],$
            comp_suffix='COMP1074_CR2198_OG_OB-NB',$
            histo_x_tit='Ratio: E1074-OG-OB/NB',tit='',rad_y_tit='E1074',$
            rad_range_A=[1.0,1.26],rad_range_B=[1.0,1.26],r0A=r0A,LabelA='OG-B1.05',LabelB='OG-B1.09'

   fileA='x.comp1074.dynamics.Dt2_CR2198.bf2.ri1.00.ro1.26_26_90_180_r3D_2.65'
   fileB='x.comp1074.dynamics.Dt2_CR2198.bf2.ri1.00.ro1.50_50_90_180_r3D_2.65'
   xcompare,dir=dir,fileA=fileA,fileB=fileB,nrA=26,ntA=90,rminA=1.0,rmaxA=1.26,nrB=50,rminB=1.0,rmaxB=1.5,lat_range=[-90.,+90.],lon_range=[0.,360.],$
            comp_suffix='COMP1074_CR2198_OB_OG-NG',$
            histo_x_tit='Ratio: E1074-OB-NG/OG',tit='',rad_y_tit='E1074',$
            rad_range_A=[1.0,1.26],rad_range_B=[1.0,1.50],r0A=r0A,LabelA='B1.05-OG',LabelB='B1.05-NG'

    fileA='x.comp1074.dynamics.Dt2_CR2198.bf2.ri1.00.ro1.26_26_90_180_r3D_2.65_IRMIN_1.09'
    fileB='x.comp1074.dynamics.Dt2_CR2198.bf2.ri1.00.ro1.50_50_90_180_r3D_2.65_IRMIN_1.09'
   xcompare,dir=dir,fileA=fileA,fileB=fileB,nrA=26,ntA=90,rminA=1.0,rmaxA=1.26,nrB=50,rminB=1.0,rmaxB=1.5,lat_range=[-90.,+90.],lon_range=[0.,360.],$
            comp_suffix='COMP1074_CR2198_NB_OG-NG',$
            histo_x_tit='Ratio: E1074-OB-NG/OG',tit='',rad_y_tit='E1074',$
            rad_range_A=[1.0,1.26],rad_range_B=[1.0,1.50],r0A=r0A,LabelA='B1.09-OG',LabelB='B1.09-NG'

   return
   
   fileA='x.comp1074.dynamics.Dt2_CR2198.bf2.ri1.00.ro1.50_50_90_180_r3D_2.60_IRMIN_1.09'
   fileB='x.comp1074.dynamics.Dt2_CR2198.bf2.ri1.00.ro1.50_50_90_180_r3D_2.65_IRMIN_1.09'
   xcompare,dir=dir,fileA=fileA,fileB=fileB,nrA=50,ntA=90,rminA=1.0,rmaxA=1.5,nrB=50,rminB=1.0,rmaxB=1.5,lat_range=[-90.,+90.],lon_range=[0.,360.],$
            comp_suffix='COMP1074_CR2198_2regs',x_tit='E1074-2regs',y_tit='E1074-2regs',$
            histo_x_tit='Ratio: E1074-NG-OG/OB',tit='',rad_y_tit='E1074',$
            rad_range_A=[1.0,1.5],rad_range_B=[1.0,1.5],r0A=r0A,LabelA='L 2.60',LabelB='L 2.65'
;-----------------------------------------------------------------------------------------------------------------------------

  dir = '/media/Data/data1/tomography_NALAI/bindata/'
  r0A=[1.095,1.155,1.205,1.255]

  fileA='x_aia.171.cr2198.26x90_bf4_ri.00_ro1.09_l0.8_h1_Oldset_r3d'
  fileB='x_AIA_CR2198_171_h1_Rmin1.07_Rmax1.27_Nr20_InstRmin-max_1.09-1.26_bf4_r3d_L0.8'
   xcompare,dir=dir,fileA=fileA,fileB=fileB,nrA=26,ntA=90,rminA=1.0,rmaxA=1.26,nrB=20,rminB=1.07,rmaxB=1.27,lat_range=[-90.,+90.],lon_range=[0.,360.],$
            comp_suffix='AIA171_CR2198_OG-NG',x_tit='FBE171-OG',y_tit='FBE171-NG',$
            histo_x_tit='Ratio: FBE171-NG/OG',tit='',rad_y_tit='FBE171',$
            rad_range_A=[1.02,1.26],rad_range_B=[1.07,1.27],r0A=r0A,LabelA='Old Grid',LabelB='New Grid'
  fileA='x_aia.193.cr2198.26x90_bf4_ri.00_ro1.09_l1.0_h1_Oldset_r3d'
  fileB='x_AIA_CR2198_193_h1_Rmin1.07_Rmax1.27_Nr20_InstRmin-max_1.09-1.26_bf4_r3d_L1.0'

   xcompare,dir=dir,fileA=fileA,fileB=fileB,nrA=26,ntA=90,rminA=1.0,rmaxA=1.26,nrB=20,rminB=1.07,rmaxB=1.27,lat_range=[-90.,+90.],lon_range=[0.,360.],$
            comp_suffix='AIA193_CR2198_OG-NG',x_tit='FBE193-OG',y_tit='FBE193-NG',$
            histo_x_tit='Ratio: FBE193-NG/OG',tit='',rad_y_tit='FBE193',$
            rad_range_A=[1.02,1.26],rad_range_B=[1.07,1.27],r0A=r0A,LabelA='Old Grid',LabelB='New Grid'

   fileA='x_aia.211.cr2198.26x90_bf4_ri.00_ro1.09_l0.9_h1_Oldset_r3d'
   fileB='x_AIA_CR2198_211_h1_Rmin1.07_Rmax1.27_Nr20_InstRmin-max_1.09-1.26_bf4_r3d_L0.9'
   xcompare,dir=dir,fileA=fileA,fileB=fileB,nrA=26,ntA=90,rminA=1.0,rmaxA=1.26,nrB=20,rminB=1.07,rmaxB=1.27,lat_range=[-90.,+90.],lon_range=[0.,360.],$
            comp_suffix='AIA211_CR2198_OG-NG',x_tit='FBE211-OG',y_tit='FBE211-NG',$
            histo_x_tit='Ratio: FBE211-NG/OG',tit='',rad_y_tit='FBE211',$
            rad_range_A=[1.02,1.26],rad_range_B=[1.07,1.27],r0A=r0A,LabelA='Old Grid',LabelB='New Grid'
   return

  
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
