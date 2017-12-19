;;
;
; Regularization Matrix Generator in IDL.
; by Alberto M. Vásquez. CLaSP, Fall-2017.
;
; /hlaplac:  Angular derivatives. Output in one matrix.
; /laplac3:  3D derivatives. Output in three matrices.
;
; /Identity: Identity Matrix as regularization operator. Output in one matrix.
;            Not yet implemented.
;
; Examples of calling sequence:
;
; derivs_hollowsph,nrad=100,ntheta=90,nphi=180,directory='/data1/tomography/bindata/',fname_ext='100_90_180',/hlaplac
;
; derivs_hollowsph,nrad= 26,ntheta=90,nphi=180,directory='/data1/tomography/bindata/',fname_ext= '26_90_180',/hlaplac
;
;;

pro derivs_hollowsph,nrad=nrad,ntheta=ntheta,nphi=nphi,directory=directory,fname_ext=fname_ext,hlaplac=hlaplac,laplac3=laplac3,indentity=identity

  nrad        = long(nrad)
  ntheta      = long(ntheta)
  nphi        = long(nphi)

  nbins       = nrad*ntheta*nphi

  row_d2r     = lonarr(3*nbins)
  col_d2r     = lonarr(3*nbins)
  val_d2r     = fltarr(3*nbins)

  row_d2phi   = lonarr(3*nbins)
  col_d2phi   = lonarr(3*nbins)
  val_d2phi   = fltarr(3*nbins)

  row_d2theta = lonarr(3*nbins)
  col_d2theta = lonarr(3*nbins)
  val_d2theta = fltarr(3*nbins)

; vectors of starting indices for each row
  nd2r     = lonarr(nbins+1)
  nd2phi   = nd2r
  nd2theta = nd2r               

; calculate d2r
count       = -1L;
r_row_count = -1L;
for k = 0L,nphi-1 do begin;
   for i = 0L,ntheta-1 do begin;
      for j = 1L,nrad-2 do begin;

            r_row_count = r_row_count + 1 ;            

            count = count + 1                 
            n = lindex3D(j-1,i,k,nrad,ntheta) ; get column of element
            row_d2r(count) = r_row_count      ; store row of element
            col_d2r(count) = n                ; store col of element
            val_d2r(count) = 1.0              ; store val of element

            count = count + 1
            n = lindex3D(j,i,k,nrad,ntheta)   ; get column of element
            row_d2r(count) = r_row_count      ; store row of element
            col_d2r(count) = n                ; store col of element
            val_d2r(count) = -2.0             ; store val of element

            count = count + 1
            n = lindex3D(j+1,i,k,nrad,ntheta) ; get column of element
            row_d2r(count) = r_row_count      ; store row of element
            col_d2r(count) = n                ; store col of element
            val_d2r(count) = 1.0              ; store val of element
            
            nd2r(r_row_count+1) = count       ; store starting index of next row 

      endfor
   endfor
endfor

print,'Done with d2r.'

;calculate d2theta

count       = -1L;
t_row_count = -1L;
for k = 0L,nphi-1 do begin
   for i = 1L,ntheta-2 do begin
     for j = 0L,nrad-1 do begin

        t_row_count = t_row_count + 1    ;

; The order of the next two blocks should be swapped for clarity.
; The output would differ in order, but not in content, and
; the tom codes objective function will not be modified.
;----------------------------------------------------------------
        count = count + 1                ;
        n = lindex3D(j,i,k,nrad,ntheta); 
        row_d2theta(count) = t_row_count; 
        col_d2theta(count) = n;
        val_d2theta(count) = -2.0;

        count = count + 1;
        n = lindex3D(j,i-1,k,nrad,ntheta);
        row_d2theta(count) = t_row_count;
        col_d2theta(count) = n;
        val_d2theta(count) = 1.0;
;----------------------------------------------------------------
        count = count + 1;
        n = lindex3D(j,i+1,k,nrad,ntheta);
        row_d2theta(count) = t_row_count;
        col_d2theta(count) = n;
        val_d2theta(count) = 1.0;

        nd2theta(t_row_count+1) = count;

      endfor
   endfor
endfor

val_hlaplac = val_d2theta(0:count-1);
col_hlaplac = col_d2theta(0:count-1);

print,'Done with d2theta.';

; calculate d2phi

count = -1L;
p_row_count = -1L;
for k = 1L,nphi-2 do begin
   for i = 0L,ntheta-1 do begin
      for j = 0L,nrad-1 do begin

            p_row_count = p_row_count + 1;

            count = count + 1;
            m = p_row_count;
            n = lindex3D(j,i,k-1,nrad,ntheta);
	    row_d2phi(count) = m;
            col_d2phi(count) = n;
            val_d2phi(count) = 1.0;

            count = count + 1;
            n = lindex3D(j,i,k,nrad,ntheta);
	    row_d2phi(count) = m;
            col_d2phi(count) = n;
            val_d2phi(count) = -2.0;

            count = count + 1;
            n = lindex3D(j,i,k+1,nrad,ntheta);
	    row_d2phi(count) = m;
            col_d2phi(count) = n;
            val_d2phi(count) = 1.0;      

            nd2phi(p_row_count+1) = count;    
      endfor
   endfor
endfor

k = nphi-1; Matlab said "k=nphi"
   for i = 0L,ntheta-1 do begin
      for j = 0L,nrad-1 do begin

            p_row_count = p_row_count + 1;

            count = count + 1;
            m = p_row_count;
            n = lindex3D(j,i,k-1,nrad,ntheta);
	    row_d2phi(count) = m;
            col_d2phi(count) = n;
            val_d2phi(count) = 1.0;

            count = count + 1;
            n = lindex3D(j,i,k,nrad,ntheta);
	    row_d2phi(count) = m;
            col_d2phi(count) = n;
            val_d2phi(count) = -2.0;

            count = count + 1;
            n = lindex3D(j,i,0,nrad,ntheta); Matlab said "(j,i,1,nrad,ntheta)"
	    row_d2phi(count) = m;
            col_d2phi(count) = n;
            val_d2phi(count) = 1.0;      

            nd2phi(p_row_count+1) = count;
      endfor
   endfor

k = 0; Matlab said "k=1"
   for i = 0L,ntheta-1 do begin
      for j = 0L,nrad-1 do begin

            p_row_count = p_row_count + 1;

            count = count + 1;
            m = p_row_count;
            n = lindex3D(j,i,nphi-1,nrad,ntheta); Matlab said "(j,i,nphi,nrad,ntheta)"
	    row_d2phi(count) = m;
            col_d2phi(count) = n;
            val_d2phi(count) = 1.0;

            count = count + 1;
            n = lindex3D(j,i,k,nrad,ntheta);
	    row_d2phi(count) = m;
            col_d2phi(count) = n;
            val_d2phi(count) = -2.0;

            count = count + 1;
            n = lindex3D(j,i,k+1,nrad,ntheta);
	    row_d2phi(count) = m;
            col_d2phi(count) = n;
            val_d2phi(count) = 1.0;      

            nd2phi(p_row_count+1) = count;
      endfor
   endfor

print,'Done with d2phi.'

val_hlaplac = [val_hlaplac, val_d2phi(0:count-1)];
col_hlaplac = [col_hlaplac, col_d2phi(0:count-1)];
  n_hlaplac = [nd2theta(0:t_row_count), nd2theta(t_row_count) + nd2phi(1:p_row_count)]; 

if keyword_set(hlaplac) then begin

   fname_hlaplac = 'hlaplac_'+fname_ext;
   print,'The filename extension is '+ fname_hlaplac

   y = fltarr(t_row_count + p_row_count);

   filename_n = directory+'n'     +fname_hlaplac
   filename_i = directory+'i'     +fname_hlaplac
   filename_v = directory+'v'     +fname_hlaplac
   filename_y = directory+'y'     +fname_hlaplac
   filename_d = directory+'delta_'+fname_hlaplac

   openw,1,filename_n
   openw,2,filename_i
   openw,3,filename_v
   openw,4,filename_y
   openw,5,filename_d

   writeu,1,  n_hlaplac
   writeu,2,col_hlaplac ; Matlab said "col_hlaplac-1"
   writeu,3,val_hlaplac
   writeu,4,y
   writeu,5,y

   close,/all
   
endif

if keyword_set(laplac3) then begin

   fname_d2r = 'd2r_'+fname_ext
   print,'The filename extension is '+ fname_d2r
   
   y = fltarr(r_row_count) 

   filename_n = directory+'n'     +fname_d2r
   filename_i = directory+'i'     +fname_d2r
   filename_v = directory+'v'     +fname_d2r
   filename_y = directory+'y'     +fname_d2r
   filename_d = directory+'delta_'+fname_d2r

   openw,1,filename_n
   openw,2,filename_i
   openw,3,filename_v
   openw,4,filename_y
   openw,5,filename_d

   writeu,1,   nd2r
   writeu,2,col_d2r ; Matlab said "col_d2r-1"
   writeu,3,val_d2r
   writeu,4,y
   writeu,5,y

   close,/all

   fname_d2theta = 'd2theta_'+fname_ext

   y = fltarr(t_row_count)

   filename_n = directory+'n'     +fname_d2theta
   filename_i = directory+'i'     +fname_d2theta
   filename_v = directory+'v'     +fname_d2theta
   filename_y = directory+'y'     +fname_d2theta
   filename_d = directory+'delta_'+fname_d2theta

   openw,1,filename_n
   openw,2,filename_i
   openw,3,filename_v
   openw,4,filename_y
   openw,5,filename_d

   writeu,1,   nd2theta
   writeu,2,col_d2theta-1 ; Matlab said "col_d2theta-1"
   writeu,3,val_d2theta
   writeu,4,y
   writeu,5,y

   close,/all

   fname_d2phi = 'd2phi_'+fname_ext

   y = fltarr(p_row_count)

   filename_n = directory+'n'     +fname_d2phi
   filename_i = directory+'i'     +fname_d2phi
   filename_v = directory+'v'     +fname_d2phi
   filename_y = directory+'y'     +fname_d2phi
   filename_d = directory+'delta_'+fname_d2phi

   openw,1,filename_n
   openw,2,filename_i
   openw,3,filename_v
   openw,4,filename_y
   openw,5,filename_d

   writeu,1,   nd2phi
   writeu,2,col_d2phi-1 ; Matlab said "col_d2phi-1"
   writeu,3,val_d2phi
   writeu,4,y
   writeu,5,y

   close,/all

endif ; laplac3

print,'Done'
print,''
print,'RUN row_to_col.c !!!!!'
print,''

stop
end
