#Tt training values
#St training expected results
#Tc comparison values
#Sc comparison expected results

function [Tt, St, Tc, Sc] = select_for_training(T, S, p = 0.1)
  
  if(p > 0.5)
    p = 0.5;
  endif
  
  N = length(S);
  Nc = ceil(N*p);
  perm = randperm(N);
  
  Tc = T(perm(1:Nc),:);
  Sc = S(perm(1:Nc));
  Tt = T(perm((Nc+1):end),:);
  St = S(perm((Nc+1):end));
  
endfunction
