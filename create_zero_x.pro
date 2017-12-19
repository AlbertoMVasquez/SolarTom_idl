; create_zero_x,dir='/data1/tomography/bindata/',file='x_zero_100_90_180',nrad=100,ntheta=90,nphi=180

pro create_zero_x,dir=dir,file=file,nrad=nrad,ntheta=ntheta,nphi=nphi

x=fltarr(nrad,ntheta,nphi)
openw,1,dir+file
writeu,1,x
close,1

return
end
