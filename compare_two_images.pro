pro compare_two_images,data_dir=data_dir,img1_filename=img1_filename,img2_filename=img2_filename,ImageSize=ImageSize,r0=r0,instrument=instrument
  if not keyword_set(r0) then r0=1.06
  mreadfits,data_dir+img1_filename,hdr1,img1
  mreadfits,data_dir+img2_filename,hdr2,img2
  ind1 = where(img1 gt 0.)
  min1 = min(img1(ind1))
  max1 = max(img1(ind1))
  ind2 = where(img2 gt 0.)
  min2 = min(img2(ind2))
  max2 = max(img2(ind2))
  mini   = min([min1,min2])
  maxi   = max([max1,max2])
  img1[0:1,0] = [mini,maxi]
  img2[0:1,0] = [mini,maxi]
  img1 = img1 > mini < maxi
  img2 = img2 > mini < maxi
  dr=.005
  compute_image_grid,hdr=hdr1,ra=ra,pa=pa,x=x,y=y,instrument=instrument
  p=where(ra ge r0-dr/2. and ra le r0+dr/2.)
  img1(p) = mini
  compute_image_grid,hdr=hdr2,ra=ra,pa=pa,x=x,y=y,instrument=instrument
  p=where(ra ge r0-dr/2. and ra le r0+dr/2.)
  img2(p) = mini
  window,xs=2*ImageSize,ys=ImageSize
  loadct,39
  tvscl,alog10(img1>mini),0
  tvscl,alog10(img2>mini),1
  close,/all
  return
end
