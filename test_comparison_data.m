function p = test_comparison_data(Tc, Sc, W, epsilon = 0.05)
  
  samples = length(Sc);
  
  count = 0;
  for i = 1:samples
    v = evaluate(Tc(i,:),W);
    e = Sc(i);
    if(v >= e-epsilon && v < e+epsilon)
      count += 1;
    endif
  endfor
 
  p = count/samples;
  
endfunction
