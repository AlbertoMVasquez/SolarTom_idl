;;
;
; Brief Description: Provided an image header and instrument
; specification this routine returns 2D arrays of the radii and polar
; angle of each pixel of the image, and 1D arrays with the x and y
; cartesian position vectors with origin in the disk-center.
;
; INPUTS:
; header:     header structure of the image
; instrument: string specifying the instrument, valid values are:
;             'comp', 'kcor', 'cor1', 'lascoc2', 'euvi', 'aia'.
;             TBI: 'eit'.
;
; OUTPUTS:
; ra, pa: 2D float arrays of the image size containing the projected
; radii ra [Rsun] and polar angle pa [deg] of each pixel.
; x, y: 1D float arrays with the cartesian coordinates [Rsun] with
; origin in the disk center.
;
; History:  V1.0, Alberto M. Vasquez, CLaSP, Spring-2018.
;
;;

pro compute_image_grid,header=header,instrument=instrument,ra=ra,pa=pa,x=x,y=y

  instrument_detected_flag = 0
  
  if instrument eq 'comp' or instrument eq 'kcor' or instrument eq 'cor1' or instrument eq 'euvi' or instrument eq 'aia' then begin
       instrument_detected_flag = 1
       if instrument eq 'aia' then Rs=hdr.rsun_obs ; Sun radius in arcsec
       if instrument ne 'aia' then Rs=hdr.rsun     ; Sun radius in arcsec
       px  = hdr.cdelt1                            ; Pixel size in arcsec
       Rs  = Rs/px                                 ; Sun radius in pixels
       px  = 1./Rs                                 ; Pixel size in Rsun units
       ix0 = hdr.crpix1-1                          ; Disk center x-pixel, changed to IDL convention (FITS convention starts with index=1, IDL starts with index=0).
       iy0 = hdr.crpix2-1                          ; Disk center y-pixel, changed to IDL convention
  endif
  
  if instrument eq 'lascoc2' then begin
       instrument_detected_flag = 1     
       Rs  = hdr.rsun_pix         ; Sun radius in pixels
       px  = 1./Rs                ; Pixel size in Rsun units
       ix0 = hdr.xsun-1           ; Disk center x-pixel, changed to IDL convention
       iy0 = hdr.ysun-1           ; Disk center y-pixel, changed to IDL convention
  endif

  if instrument_detected_flag eq 0 then begin
     print,'compute_image_grid.pro: invalid value for instrument.'
     stop
  endif
  
  x  = px*(findgen(hdr.naxis1) - ix0)
  y  = px*(findgen(hdr.naxis1) - iy0)
  u  = 1. + fltarr(hdr.naxis1)
  xa = x#u
  ya = u#y
  ra = sqrt(xa^2 + ya^2)

  ta    = fltarr(hdr.naxis1,hdr.naxis1)
  p     = where(xa gt 0.)
  ta(p) = Acos( ya(p) / ra(p) )
  p     = where(xa lt 0.)
  ta(p) = 2.*!pi - Acos( ya(p) / ra(p) )
  p     = where(xa eq 0. AND ya gt 0.)
  if p(0) ne -1 then ta(p) = 0.
  p     = where(xa eq 0. AND ya lt 0.)
  if p(0) ne -1 then ta(p) = !pi
  ta    = 2.*!pi - ta
  PA    = ta/!dtor

return
end
