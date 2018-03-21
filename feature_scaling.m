function S = feature_scaling(X, lo = 0, hi = 1)
  
  if(lo >= hi)
    return;
  endif
  
  
  min = min(X);
  max = max(X);
  
  #to [0,1]
  S = (X - min)/(max-min);
  #adjust in [lo,hi]
  S  = S * (hi-lo) + lo;
  
endfunction
