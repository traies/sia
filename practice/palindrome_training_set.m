function [T, S] = palindrome_training_set(dim, samples, p = 0.5)
  T = ones(samples,dim);
  S = ones(samples,1);
  for x = 1:samples
    if (rand() < p)
      for i = 1:(dim/2)
        v = (rand() > 0.5) * 2 - 1;
        T(x,i) = v;
        T(x,dim-i+1) = v;
      endfor
    else
      T(x, :) = (rand(1, dim) > 0.5) * 2 - 1 ;
    endif
    S(x) = palindrome(dim, T(x,:))*2-1;
  endfor
endfunction
