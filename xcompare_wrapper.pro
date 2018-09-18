pro xcompare_wrapper

r0A=[1.1,1.5,2.0]

fileA='x_KCOR.CR2198.13imgs.bf2.ri1.05.ro4.00_Inst_1.09_2.00_295_90_180_dropneg_r3D_l1e-4'
fileB='Ne_CR2198_DEMT-AIA_FD-L0.75_r3D'

xcompare,fileA=fileA,fileB=fileB,nrA=295,ntA=90,rminA=1.05,rmaxA=4.0,nrB=26,rminB=1.0,rmaxB=1.26,$
         comp_suffix='KCOR-Tom_vs_DEMT_CR2198_All-Latitudes',x_tit='KCOR-Tom Ne [cm!U-3!N]',y_tit='AIA DEMT Ne [cm!U-3!N]',$
         histo_x_tit='Ratio: Ne (KCOR) / Ne (DEMT)',tit='All Latitudes',rad_y_tit='Ne [cm!U-3!N]',$
         rad_range_A=[1.09,2.0],rad_range_B=[1.02,1.23]

xcompare,fileA=fileA,fileB=fileB,nrA=295,ntA=90,rminA=1.05,rmaxA=4.0,nrB=26,rminB=1.0,rmaxB=1.26,lat_range=[-30.,+30.],$
         comp_suffix='KCOR-Tom_vs_DEMT_CR2198_Low-Latitudes',x_tit='KCOR-Tom Ne [cm!U-3!N]',y_tit='AIA DEMT Ne [cm!U-3!N]',$
         histo_x_tit='Ratio: Ne (KCOR) / Ne (DEMT)',tit='Latitudinal range: [-30!Uo!N,+30!Uo!N]',rad_y_tit='Ne [cm!U-3!N]',$
         rad_range_A=[1.09,2.0],rad_range_B=[1.02,1.23]

return
end
