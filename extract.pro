filename = 'CR2208.hf5'
dir      = '/data1/DATA/LAM_Tomography/'
number   = 8

xlam_extract_tom,filename=filename,dir=dir,number=number,$
                 map=map,nr=nr,nt=nt,np=np,rmin=rmin,rmax=rmax

ysize_factor = 1.1
xdisplay,dir=dir,file=filename,nr=nr,nt=nt,np=np,rmin=rmin,rmax=rmax,r0A=[4.0,5.0],map=map/1.e4,win=0,scalefactor=4,minA=[1.,1.],maxA=[25.,25.],clrtbl=34,ysize_factor=ysize_factor
