dir = '/data1/tomography_dev/DATA/wisprO/Circular_CR2082/'
file = 'WISPR_O_2018-10-30T09:59:59_squareFOV_binfac4_Blank.CircularOrbits3degUnifSynth.BK.fts'
mreadfits,dir+file,hdr,img
window,xs=512,ys=512
loadct,39
tvscl,alog10(img>10.^(-0.4)<10.^0.6)
loadct,0

rsun =  6.957e5 * 1.e3
print,[hdr.J2kX_OBS,hdr.J2kY_OBS,hdr.J2kZ_OBS]/rsun,hdr.CRLN_OBS,hdr.CRLT_OBS
