function ans = check_valid(S, proy)
  ans = 0;
  for s = 1:length(S)
    if(!(S(s)>= 0 && proy(s) >= 0 || S(s)<0 && proy(s)<0))
      return;
    endif
  endfor
  ans = 1;  
endfunction
  