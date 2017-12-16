pro derivs_hollowsph,nrad=nrad,ntheta=ntheta,nphi=nphi,directory=directory,fname_ext=fname_ext

  nrad        = long(nrad)
  ntheta      = long(ntheta)
  nphi        = long(nphi)

  nbins       = nrad*ntheta*nphi
  row_d2r     = fltarr(3*nbins)
  col_d2r     = row_d2r
  val_d2r     = row_d2r             
  row_d2phi   = fltarr(3*nbins)
  col_d2phi   = row_d2phi
  val_d2phi   = row_d2phi         
  row_d2theta = fltarr(3*nbins)
  col_d2theta = row_d2theta
  val_d2theta = row_d2theta     

; vectors of starting indecies for each row

  nd2r     = fltarr(nbins+1)
  nd2phi   = nd2r
  nd2theta = nd2r               

; calculate d2r
count       = -1L;
r_row_count = -1L                               ;
for k = 0,nphi-1 do begin ; block
   for i = 0,ntheta-1 do begin ;col
      for j = 1,nrad-2 do begin ; row

            r_row_count = r_row_count + 1 ;            
            count = count + 1;

            n = lindex3D(j-1,i,k,nrad,ntheta) ; %column
            row_d2r(count) = r_row_count;
            col_d2r(count) = n;
            val_d2r(count) = 1.0;

            count = count + 1;
            n = lindex3D(j,i,k,nrad,ntheta); %column
            row_d2r(count) = r_row_count;
            col_d2r(count) = n;
            val_d2r(count) = -2.0;

            count = count + 1;
            n = lindex3D(j+1,i,k,nrad,ntheta); %column
            row_d2r(count) = r_row_count;
            col_d2r(count) = n;
            val_d2r(count) = 1.0;
      
            nd2r(r_row_count+1) = count;

         
      endfor
   endfor
endfor

stop
;d2r = sprsin(row_d2r(1:count), col_d2r(1:count), val_d2r(1:count), r_row_count, nbins) ;

;d2r  = sparse(row_d2r(1:count), col_d2r(1:count), val_d2r(1:count), r_row_count, nbins);
;disp('done with d2r')

stop
end

