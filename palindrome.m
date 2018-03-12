function ans = palindrome(N, W)
    ans = 1;
    for i = 1:N/2
      if(W(i) != W(N-i+1))
        ans = 0;
        return;
      endif 
    endfor
    return;
endfunction
