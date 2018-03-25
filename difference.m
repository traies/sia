function diff = difference(Tc, Sc, W)
  
  eval = [];
  for i=1:length(Sc)
    eval(i) = evaluate(Tc(i,:),W);  
  endfor
  diff = abs(Sc'-eval);
  
endfunction
  