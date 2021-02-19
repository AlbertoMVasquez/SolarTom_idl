r0A=[2.4,2.7,3.0,3.2]
dir = '/data1/tomography/bindata/'
file = 'x_METIS-VL-Perihelion_04-2023_12DegStep_Rmin2.2_Rmax4.0_IRmin2.4_IRmax3.2_18x60x120_BF4_L8.e-6'
rmin = 2.2
rmax = 4.0
nr=18
nt=60
np=2*nt
xread,dir=dir,file=file,nr=nr,nt=nt,np=np,map=map
scalefactor=5
units=1.e5
clrtbl=34
xdisplay,map=map,units=units,clrtbl=clrtbl,scalefactor=scalefactor,dir=dir,file=file,nr=nr,nt=nt,rmin=rmin,rmax=rmax,r0A=r0A,win=2,titulo='Metis Ne [10!U5!Ncm!U-3!N]'
