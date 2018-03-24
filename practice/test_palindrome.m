function ans = test_palindrome(ent,H,W,W2)
  ent1 = ones(1, H+1)*-1;
  ent1(:, 2:(H+1)) = tanh(ent*W);
  ans = tanh(ent1*W2);
endfunction
