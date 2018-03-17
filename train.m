# T training set (bias not included)
# S expected output
# h number of hidden layers
# H hidden layer dimensions (bias not included)
# W neural network weights
function W = train(T, S, h, H, eta=0.001, alfa=0.9)
 W = {};
 oldWDelta = {};
 T_size = size(T)(2);
 samples = length(S);
 #  Consider bias in first layer size
 prev = T_size + 1;
 
 # Weights initialization (consider bias in each hidden layer)
 for i = 1:h
   W{i} = rand(prev,H(i));
   oldWDelta{i} = zeros(prev, H(i));
   prev = H(i) + 1;
 endfor
 #  Initialize last layer
 W{h+1} = rand(prev, 1);
 oldWDelta{h+1} = zeros(prev, 1);
 exit = 0;
 iter = 0;
 while 1
  # Samples are permutated on each iteration
  err = 0;
  for x = 1:samples
    V = {};
    # g'(h_i)
    V_1 = {};  
    # Add bias
    V{1} = [-1 T(x, :)];
    # Feed forward, add bias to each layer
    for i = 1:h
      tempV = tanh(V{i}*W{i});
      V{i+1} = [-1 tempV];
      V_1{i+1} = (1- tempV .** 2);
    endfor
    # Feed forward last layer
    tempV = tanh(V{h+1}*W{h+1});
    V{h+2} = tempV;
    V_1{h+2} = 1- tempV .** 2;
    Delta = {};
    # Find last delta (list indexes are backwards)
    err += (S(x) - V{h+2}) ** 2;
    Delta{h+1} =  V_1{h+2} .* (S(x) - V{h+2});
    # Backpropagation
    for i = h:-1:1
      Delta{i} = V_1{i+1} .* (Delta{i+1} * W{i+1}(2:end, :)');
    endfor
    
    # Update Weights
    for i = 1:h+1
      WDelta = eta * V{i}' * Delta{i};
      W{i} += WDelta + alfa * oldWDelta{i} ;
      oldWDelta{i} = WDelta;
    endfor
    
  endfor
  
  # Check accuracy
  count = 0;
  for s = 1:samples
    # Add bias
    proy = [-1 T(s, :)];
    # Feed forward, add bias to each layer
    for i = 1:h
      proy = [-1 tanh(proy*W{i})];
    endfor
    proy = tanh(proy*W{h+1});
    # Check if proyection is OK. Add to counter.
    if( (S(s) > 0 && proy > 0) || (S(s) < 0 && proy <= 0))
      count = count + 1;
    endif
  endfor
  printf("Iter %g, Success rate: %f\n", iter, count);
  printf("Error: %f \n", err);
  fflush(stdout);
  # Check quadratic error.
  if count == samples
    break
  endif
  iter += 1;
  endwhile
  
 endfunction
 