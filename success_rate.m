function p = success_rate(T,S,W,W2,H)
  count = 0;
  for i = 1:size(S)(2)
    v = test_palindrome(T(i,:),H,W,W2);
    if(S(i) == 1 && v >= 0 || S(i) == -1 && v < 0)
      count += 1;
    endif
  endfor
  p = count/size(S)(2);
endfunction
