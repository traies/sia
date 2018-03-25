function [T S] = random_terrain(lo = -1, hi = 1, incr = .05, p = 0.2)

  T = S = [];
  
  for x = lo:incr:hi
    for y = lo:incr:hi
      if(rand()>p)
        T(end+1,:) = [x y];
        S(end+1) = rand()*(hi-lo)+lo;
      endif
    endfor
  endfor
  
endfunction
  