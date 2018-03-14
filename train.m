function W = train(T, S, h, H)
 W = {};
 T_size = size(T)(2);
 
 prev = T_size;
 for i = 1:h
   W(end+1) = rand(prev,H(i));
   prev = H(i);
 endfor
 
 exit = 0;
 while(!exit) 
  for x = randperm(T_size)
    V = {};
    V_1 = {}; #derivatives g'(h_i) 
    V(1) = T(x, :);
    for i = 1:h
      V(i+1) = tanh(V{i}*W{i});
      V_1(i) = 1- V(i+1) .** 2;
    endfor
    Delta = {};
    Delta(1) = 1 - (V{h-1} * W) .** 2
  endfor
  
 endwhile
 
 endfunction
 