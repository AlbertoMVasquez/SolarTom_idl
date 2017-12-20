function lindex3d,row,col,block,nrows,ncols
;function index = lindex3D(row,col,block,nrows,ncols)
;  this gives the 1D index of the (row,col,block) element
;    of a 3D matrix with nrows and ncols
;
;   see also vecdex3D.m
; index = (block - 1)*nrows*ncols + (col - 1)*nrows + row   MATLAB

    row_matlab =   row + 1
    col_matlab =   col +1
  block_matlab = block + 1

  index_matlab = (block_matlab - 1)*nrows*ncols + (col_matlab - 1)*nrows + row_matlab ;  MATLAB
  
 ;index = block*nrows*ncols + col*nrows + row             ; IDL

  return,index_matlab
end

