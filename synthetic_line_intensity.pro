;---------------------------------------------------------------------
;
; Brief description:
;
; Tool to compute synthetic intensities of selected coronal lines.
; CHIANTI contribution functions computed by Enrico Landi.
; User provides: coronal model for electron density and temperature,
; FIP effect factor, and LOS impact parameter.
;
; History:  V1.0, Alberto M. Vasquez, CLaSP, Spring-2018.
;
; Calling sequence and output example:
;
; synthetic_line_intensity,impact_los = 1.1
; The synthetic specific intensity of the fexiii-10747A line is: 2.74780 erg cm^-2 sec^-1 sr^-1 
;
;---------------------------------------------------------------------

; Main routine:
pro Synthetic_line_intensity,ion_label=ion_label,line_wavelength=line_wavelength,$
                             fip_factor=fip_factor,impact_los=impact_los,N_T_model_ID=N_T_model_ID

  common constants,Rsun,kB,h,c
  common G_table,G,T_e,N_e,r,photT
  common los_grid,s,r_s,Ns,s_step,s_max,los_length
  common los_quantities,emissivity_s,Ne_s,Te_s
  common intensity,J_synth
  
  if not keyword_set(ion_label)       then ion_label       = 'fexiii' ; always use lowercase
  if not keyword_set(line_wavelength) then line_wavelength =  '10747' ; string with wavelength in A
  if not keyword_set(fip_factor)      then fip_factor      =     1.0  ; Feldmand's Adundance Set value
  if not keyword_set(impact_los)      then impact_los      =     1.1  ; Rsun
  if not keyword_set(N_T_model_ID)    then N_T_model_ID    =     1    ; Default model ID

  load_constants
  load_G,ion_label=ion_label,line_wavelength=line_wavelength
  create_LOS_grid,impact_los=impact_los
  compute_LOS_emissivity,N_T_model_ID=N_T_model_ID,fip_factor=fip_factor
  compute_synthetic_specific_intensity

  print
  print,'The synthetic specific intensity of the '+ion_label+'-'+line_wavelength+'A line is: '+string(J_synth)+' erg cm^-2 sec^-1 sr^-1'
  print
  
  return
end

; Sub-routines:
pro load_G,ion_label=ion_label,line_wavelength=line_wavelength
  common G_table,G,T_e,N_e,r,photT

  data_dir  = '/data1/tomography/SolarTom_idl/DATA/'
  file_name = 'G_function_'+ion_label+'_'+line_wavelength+'.save'

  restore,data_dir+file_name

  G     = emissivity ; erg cm^+3 sec^-1 ; Note: G(Te, Ne, r)
  N_e   = 10.^dens   ; cm^-3
  T_e   = 10.^temp   ; K
  r     = rphot      ; Rsun
  photT = radtemp    ; K

  return
end

pro create_LOS_grid,impact_los=impact_los
  common los_grid,s,r_s,Ns,s_step,s_max,los_length
  ; "s" and "r" in [Rsun] units:
  s_max      = 2.0                 ; LOS integration will extend over segment
                                   ; [-s_max,+s_max] around nearest point to Sun.
  los_length = 2.0*s_max           ; Length of integration segment.
  s_step     = los_length / 100.   ; Make step in s = los_length / 100.
  Ns         = los_length / s_step ; Number of points in LOS grid.
  s   = -s_max + s_step/2. + s_step*findgen(Ns) ; Cell-centered positions s along LOS
  r_s = sqrt(impact_los^2+s^2)                  ; Heliocentric heights of positions s along LOS
  return
end

pro compute_LOS_emissivity,N_T_model_ID=N_T_model_ID,fip_factor=fip_factor
  common los_grid,s,r_s,Ns,s_step,s_max,los_length
  common G_table,G,T_e,N_e,r,photT
  common los_quantities,emissivity_s,Ne_s,Te_s  
           G_s = fltarr(Ns)
  emissivity_s = fltarr(Ns)
          Ne_s = fltarr(Ns)
          Te_s = fltarr(Ns)
  for is=0,Ns-1 do begin
     r0       = r_s[is]
     Te0      = Te_model(r0,N_T_model_ID)
     Ne0      = Ne_model(r0,N_T_model_ID)
     Te_s[is] = Te0
     Ne_s[is] = Ne0
     G_s[is]  = G_function(Te0,Ne0,r0) ; Function 3-linearly interpolates G_table onto point (Te0,Ne0,r0)
     emissivity_s[is] = fip_factor * Ne0^2 * G_s[is] / (4.*!pi) ; [erg cm-3 sec-1 sr-1], ASSUMING ISOTROPIC EMISSION
    ;Test:
    ;print, is, s[is], r0, Te0, Ne0, G_s[is] 
  endfor

  return
end

pro compute_synthetic_specific_intensity
  common constants
  common los_grid,s,r_s,Ns,s_step,s_max,los_length
  common los_quantities,emissivity_s,Ne_s,Te_s
  common intensity,J_synth  
  J_synth = int_tabulated(s,emissivity_s) ; [erg cm-3 sec-1 sr-1 Rsun]
  J_synth = J_synth * Rsun                ; [erg cm-2 sec-1 sr-1]
  return
end

function G_function, Te0, Ne0, r0 ; this is the ordering of the indexes in G table.
  common G_table,G,T_e,N_e,r,photT

  goto,tri_linear_interpolator
  
  ; Simply assign closest value, I will next implement a 3-linear interpolator
  fTe = abs(Te0-T_e) & iTe = median(where(fTe eq min(fTe)))
  fNe = abs(Ne0-N_e) & iNe = median(where(fNe eq min(fNe)))
  fr  = abs(r0 -r  ) & ir  = median(where(fr  eq min(fr )))
  if iTe eq -1 or iNe eq -1 or ir eq -1 then begin
     print,'Can not assign value to G_function'
     stop
  endif
  G_value = G(iTe,iNe,ir)
  goto,exit
  
  tri_linear_interpolator:
  ; Tri-linear interpolator
  ; Rename dimensions. X is Ne.
  xa = N_e & x0 = Ne0
  ya = T_e & y0 = Te0
  za = r   & z0 = r0
  ; Find the x-planes that surround x0
  ixA = max(where(xa le x0))
  if ixA eq -1 then begin
     print,'Ne value is out of range' ; Let's talk if we need something better here.
     stop
  endif
  ixB=ixA+1
  ; Define two 2D y-z arrays at x-planes that surround x0. 
  DATA_ARRAY_xA = reform(G(*,ixA,*))
  DATA_ARRAY_xB = reform(G(*,ixB,*))
  ; Bi-linearly interpolate in xA and xB planes.   
  G_xA = findval2D( DATA_ARRAY_xA ,ya ,za , y0, z0 )
  G_xB = findval2D( DATA_ARRAY_xB ,ya ,za , y0, z0 )
  ; Linearly interpolate the value og G along x, betwee xA and xB planes.
  G_value = G_xA + (G_xB-G_xA)*(x0-xa(ixA))/(xa(ixB)-xa(ixA))

  exit:
  return,G_value
end

function Ne_model, r0, N_T_model_ID
  if N_T_model_ID eq 1 then begin ; DEMT Streamer Model for Ne from Lloveras et al. (2017)
     r_CB = 1.025                 ; Rsun
     N_CB = 1.73e8                ; Ne [cm-3] at r_CB
     l_N  = 7.80e-2               ; Electron density scale height [Rsun]
     Ne0  = N_CB * exp( ((r_CB-1.)/l_N) / r_CB )
     Ne_value = Ne0 * exp( -((r0-1.)/l_N) / r0)
  endif
  return,Ne_value
end

function Te_model, r0, N_T_model_ID
  if N_T_model_ID eq 1 then begin ; DEMT Streamer Model from Lloveras et al. (2017)
     Te_mean  = 1.18e6 ; K ; Right now an isothermal Streamer
     Te_value = Te_mean
  endif
  return,Te_value
end

function findval2D, DATA_ARRAY ,ya ,za , y0, z0
iyA=max(where(ya le y0))
izA=max(where(za le z0))
Df=0.
if iyA eq -1 or izA eq -1 then begin
   print,'Te and/or r out of range.'
   stop
endif
iyB=iyA+1
izB=izA+1
if iyA eq n_elements(ya)-1 then iyB=iyA
if izA eq n_elements(za)-1 then izB=izA
D1=DATA_ARRAY(iyA,izA) 
D2=DATA_ARRAY(iyB,izA) 
D4=DATA_ARRAY(iyA,izB) 
D5=DATA_ARRAY(iyB,izB)
if iyA lt iyB AND izA lt izB then begin
 D3=D1+(D2-D1)*(y0-yA(iyA))/(ya(iyB)-ya(iyA))
 D6=D4+(D5-D4)*(y0-yA(iyA))/(ya(iyB)-ya(iyA))
 Df=D3+(D6-D3)*(z0-zA(izA))/(za(izB)-za(izA))
endif
if iyA lt iyB AND izA eq izB then Df=D1+(D2-D1)*(y0-ya(iyA))/(ya(iyB)-ya(iyA))
if iyA eq iyB AND izA lt izB then Df=D1+(D4-D1)*(z0-za(izA))/(za(izB)-za(izA))
if iyA eq iyB AND izA eq izB then Df=D1
return,Df
end

pro load_constants
common constants,Rsun,kB,h,c
  Rsun = 6.957e+10        ; cm
  kB   = 1.38064852e-16   ; erg K^-1
  h    = 6.62607004e10-27 ; cm^2 gr sec^-1
  c    = 299792458.e+2    ; cm sec^-1 
end

function photon_energy,line_wavelength=line_wavelength
  common constants,Rsun,kB,h,c
  if wavelength_line eq '10747' then lambda0 = 10747.e-8 ; cm
  E0 = h*c/lambda_0                                      ; erg
  return,E0
end
