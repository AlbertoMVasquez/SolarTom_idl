
pro average_images,array=array,Nimages=Nimages,ImageSize=ImageSize,average_image=average_image
  average_image = fltarr(ImageSize,ImageSize) - 666.
  for ix=0,ImageSize-1 do begin
     for iy=0,ImageSize-1 do begin
        pixel_data_vector = reform(array(*,ix,iy))
        ipos = where(pixel_data_vector gt 0.)
        if ipos(0) eq -1 then goto,next_pixel
        if n_elements(ipos) lt Nimages/2. then goto,next_pixel
        average_image(ix,iy) = mean(pixel_data_vector(ipos))
        next_pixel:
     endfor
  endfor
  return
end
