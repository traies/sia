function newWDelta = reset_old_w(H, T_size)
  prev = T_size + 1;
  h = length(H);
  # Weights initialization (consider bias in each hidden layer)
  for i = 1:h
   newWDelta{i} = zeros(prev, H(i));
   prev = H(i) + 1;
  endfor
  #  Initialize last layer
  newWDelta{h+1} = zeros(prev, 1);
endfunction
