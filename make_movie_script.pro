; Description:
; 
; This code generates a script that can convert all GIF files located
; in 'dir' and listed in 'listfile' into JPG "frames" and then creates
; a movie out of them.
;
; Calling sequence example:
; make_movie_script,dir='/data1/tomography/DATA/c2/CR2219/GIFs/',listfile='list.txt'
;
; HISTORY: V 1.0 Alberto M. Vasquez, IAFE, 07-Sept-2020.
;
;-----------------------------------------------------------------------------
pro make_movie_script,dir=dir,listfile=listfile,movie_filename=movie_filename
  if not keyword_set(movie_filename) then movie_filename = 'movie.mkv'
  N=0
  x='just a string'
  openr,1,dir+listfile
  openw,2,dir+movie_filename+'_movie_script.sh'
  readf,1,N
  for i=0,N-1 do begin
     readf,1,x
     if i le 9             then frame_number_string = '00'+strmid(string(i),7,1)
     if i gt 9 and i le 99 then frame_number_string =  '0'+strmid(string(i),6,2)
     if            i gt 99 then frame_number_string =      strmid(string(i),5,3)
     printf,2,'convert '+x+' frame_'+frame_number_string+'.jpg'
  endfor
     printf,2
     printf,2,'cat frame_???.jpg | ffmpeg -framerate 7 -f image2pipe -i - -c:v copy '+movie_filename
  close,/all
  
  
  return
end

 
