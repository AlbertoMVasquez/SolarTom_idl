;--------------------------------------CR2208/CR2209 with LASCO-C2

; Grid Specs:
nr   = 60
nt   = 60
np   = 120
rmin = 2.5
rmax = 8.5

; Miscelaneous sizes:
scalefactor  = 2
ysize_factor = 1.1

; Data dir:
dir = '/media/Data1/data1/tomography/bindata/'

; Selected Heights:
r0A=[3.0,4.0,5.0,6.0]

; Units
units = 1.e4

; MARSEILLE SOLUTION:
file = 'x_LASCO-C2_MARS_CR2208.hf5_N8'
titulo = 'MARS'
xread,dir=dir,file=file,nr=nr,nt=nt,np=np,map=map
xdisplay,dir=dir,file=file,nr=nr,nt=nt,np=np,rmin=rmin,rmax=rmax,r0A=r0A,map=map/units,win=0,scalefactor=scalefactor,minS=minS,maxS=maxS,clrtbl=34,ysize_factor=ysize_factor,titulo=titulo

; TOM SOLUTION:
file = 'x_C2_CR2208_14Imgs_Rmin2.5_Rmax8.5_Ri2.5_Ro6.3_60x60x120_BINFAC1_L1.0E-4'
titulo = 'TOM-BF1-L1e-4'
xread,dir=dir,file=file,nr=nr,nt=nt,np=np,map=map
xdisplay,dir=dir,file=file,nr=nr,nt=nt,np=np,rmin=rmin,rmax=rmax,r0A=r0A,map=map/units,win=5,scalefactor=scalefactor,minA=minS,maxA=maxS,clrtbl=34,ysize_factor=ysize_factor,titulo=titulo

; TOM SOLUTION:
file = 'x_C2_CR2208_14Imgs_Rmin2.5_Rmax8.5_Ri2.5_Ro6.3_60x60x120_BINFAC1_L5.0E-5'
titulo = 'TOM-BF1-L5e-5'
xread,dir=dir,file=file,nr=nr,nt=nt,np=np,map=map
xdisplay,dir=dir,file=file,nr=nr,nt=nt,np=np,rmin=rmin,rmax=rmax,r0A=r0A,map=map/units,win=10,scalefactor=scalefactor,minA=minS,maxA=maxS,clrtbl=34,ysize_factor=ysize_factor,titulo=titulo


