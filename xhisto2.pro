pro xhisto2,vector,comp_suffix=comp_suffix,sufijo=sufijo,tit=tit,histo_x_tit=histo_x_tit,Nvals=Nvals

  histo_vector = histogram(vector,binsize=(max(vector)-min(vector))/Nvals,locations=xval)
  histo_vector = float(histo_vector) / float(n_elements(vector))

  avg        =   mean(vector)
  med        = median(vector)
  stdev_frac =  stdev(vector)/abs(avg)
  cant       = long(n_elements(vector))

  ps1,'/data1/tomography/SolarTom_idl/Figures/'+'comparison_'+comp_suffix+'_'+sufijo+'.eps',0
  device,/inches,xsize=12,ysize=5
  plot,xval,histo_vector ,font=0,xtitle=histo_x_tit,ytitle='Freq. Histogram',title=tit,linestyle=8,psym=10,thick=4,charsize=2.2
  xyouts,0.8*[1,1,1,1],0.98-[0.18,0.25,0.32,0.38],['m='+strmid(string(med),4,6),'!9m!3='+strmid(string(avg),4,6),'!9s!3/!9m!3='+strmid(string(stdev_frac),4,6),'N='+strmid(string(cant),7,7)],/normal,charthick=1,Font=0,charsize=2.2
  !p.multi = 0
  return
end
