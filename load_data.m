function [T, S] = load_data(file, adjust = true, lo = 0, hi = 1)
  
  M = dlmread(file)(2:end,:);  
  T = M(:,1:end-1);
  S = M(:,end);
  
  if(adjust)
    T(:,1) = feature_scaling(T(:,1), lo, hi);
    T(:,2) = feature_scaling(T(:,2), lo, hi);
    S = feature_scaling(S, lo, hi);
  endif
  
endfunction
  