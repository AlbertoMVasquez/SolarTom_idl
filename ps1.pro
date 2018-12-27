PRO ps1,archivo,ctbl

set_plot,'ps'

loadct,ctbl
device,filename=archivo,bits_per_pixel=8,/color,/encapsulated

return
end
