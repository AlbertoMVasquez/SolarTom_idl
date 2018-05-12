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
; synthetic_line_intensity,impact_los=1.2
;
; synthetic_line_intensity,impact_los = 1.1
; The synthetic intensity of the fexiii-10747 line is:   4.76395e-10 erg cm^-2 sec^-1
;
; synthetic_line_intensity,impact_los = 1.2
; The synthetic intensity of the fexiii-10747 line is:   1.41171e-10 erg cm^-2 sec^-1
;---------------------------------------------------------------------

; Main routine:
pro Synthetic_line_intensity,ion_label=ion_label,line_wavelength=line_wavelength,$
                             fip_factor=fip_factor,impact_los=impact_los,N_T_model_ID=N_T_model_ID

  common G_table,G,T_e,N_e,r,photT
  common los_grid,s,r_s,Ns,s_step,s_max,los_length
  common los_quantities,emissivity_s,Ne_s,Te_s
  common intensity,I_synth
  
  if not keyword_set(ion_label)       then ion_label       = 'fexiii' ; always use lowercase
  if not keyword_set(line_wavelength) then line_wavelength =  '10747' ; string with wavelength in A
  if not keyword_set(fip_factor)      then fip_factor      =     1.0  ; 1 means Feldmand's Adundance Set value
  if not keyword_set(impact_los)      then impact_los      =     1.1  ; Rsun
  if not keyword_set(N_T_model_ID)    then N_T_model_ID    =     1    ; Default model ID

  load_G,ion_label=ion_label,line_wavelength=line_wavelength
  create_LOS_grid,impact_los=impact_los
  compute_LOS_emissivity,N_T_model_ID=N_T_model_ID,fip_factor=fip_factor
  compute_synthetic_intensity

  print
  print,'The synthetic intensity of the '+ion_label+'-'+line_wavelength+' line is: '+string(I_synth)+' erg cm^-2 sec^-1'
  print
  
  return
end

; Sub-routines:
pro load_G,ion_label=ion_label,line_wavelength=line_wavelength
  common G_table,G,T_e,N_e,r,photT

  data_dir  = '/data1/tomography_dev/SolarTom_idl/DATA/'
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

  ; All s-related uantitites in Rsun units:
  s_max      = 5.*impact_los       ; LOS integration will be over segment [-s_max,+s_max] around nearest point to Sun.
  los_length = 2.*s_max            ; Length of integration segment.
  s_step     = impact_los / 100.   ; Make step in s = imact_parameter / 100.
  Ns         = los_length / s_step ; Number of points in LOS grid.

 ; Cell-centered positions s along LOS:
  s   = -s_max + s_step/2. + s_step*findgen(Ns)
; Heliocentric heights of positions s along LOS:
  r_s = sqrt(impact_los^2+s^2)

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
     emissivity_s[is] = fip_factor * Ne0^2 * G_s[is]
    ;Test:
    ;print, is, s[is], r0, Te0, Ne0, G_s[is] 
  endfor

  return
end

pro compute_synthetic_intensity
  common los_grid,s,r_s,Ns,s_step,s_max,los_length
  common los_quantities,emissivity_s,Ne_s,Te_s
  common intensity,I_synth  
  I_synth = 0.
  for is=0,Ns-1 do I_synth = I_synth + s_step * emissivity_s[is]
  return
end

function G_function, Te0, Ne0, r0 ; this is the ordering of the indexes in G table.
  common G_table,G,T_e,N_e,r,photT
  ; For now simply assign closest value, I will next implement a 3-linear interpolator
  fTe = abs(Te0-T_e) & iTe = where(fTe eq min(fTe))
  fNe = abs(Ne0-N_e) & iNe = where(fNe eq min(fNe))
  fr  = abs(r0 -r  ) & ir  = where(fr  eq min(fr ))
  if iTe eq -1 or iNe eq -1 or ir eq -1 then begin
     print,'Can not assign value to G_function'
     stop
  endif
  G_value = G(iTe,iNe,ir)  
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
