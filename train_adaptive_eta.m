# T training set (bias not included)
# S expected output
# h number of hidden layers
# H hidden layer dimensions (bias not included)
# out nodes in the outer layer
# eta 
# alfa
# beta decrease factor for adaptive eta
# k number of steps of a "consistent" decrease in the error

# W neural network weights
# E mean quadratic error over time
# state the state of the random number generator

function [W E seed min_err min_iter] = train_adaptive_eta(T, S, h, H, out, eta=0.01, momentum=0.9, alfa=0.2, beta=.1, k=5, epsilon = 0.00001, error_epsilon = .001)
 W = {};
 E = [];
 seed = rand("seed");
 
 T_size = size(T)(2);
 samples = size(S)(1);
 
 #  Consider bias in first layer size
 prev = T_size + 1;
 
 #for momentum
 oldWDelta = {};
 
 min_err = Inf;
 W_min = {};
 min_iter = 0;
 min_iter = 0;
 
 # Weights initialization (consider bias in each hidden layer)
 for i = 1:h
   W{i} = rand(prev,H(i));
   oldWDelta{i} = zeros(prev, H(i));
   prev = H(i) + 1;
 endfor
 
 #  Initialize last layer
 W{h+1} = rand(prev, out);
 oldWDelta{h+1} = zeros(prev, 1);
 
 #for adaptive eta
 prev_err = Inf;
 prev_W = W;
 consistent_decrease_iters = k;
 
 
 
 iter = 0;
 while 1
  
  prev_W = W;
  err = 0;
  
  # Samples are permutated on each iteration
  for x = randperm(samples)
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
    
    Delta{h+1} =  V_1{h+2} .* (S(x) - V{h+2});
    # Backpropagation
    for i = h:-1:1
      Delta{i} = V_1{i+1} .* (Delta{i+1} * W{i+1}(2:end, :)');
    endfor
    
    # Update Weights
    for i = 1:h+1
      WDelta = eta * V{i}' * Delta{i} + momentum * oldWDelta{i};
      W{i} += WDelta;
      oldWDelta{i} = WDelta;
    endfor
    
  endfor
  
  # Compute global error
  for s = 1:samples
    proy = evaluate(T(s, :), W);
    v = (S(s) - proy);
    err += v*v';
  endfor
  err /= 2*samples;
  E(end+1) = err;
  
  if (err < min_err)
    W_min = W;
    min_err = err;
    min_iter = iter;
  endif
  

  printf("Iter %g, Error: %f \n",iter, err);
  printf("Eta: %f \n", eta);
  fflush(stdout);
  
  if err < error_epsilon
    break;
  endif
  
  #adaptive eta
  delta_err = err-prev_err;
  
  if(delta_err < 0)
    if(consistent_decrease_iters <= 0)
      eta += alfa;
      #consistent_decrease_iters = k;
    else 
     consistent_decrease_iters -= 1;
    endif 
  elseif (delta_err > 0)
    #reset conditions
    consistent_decrease_iters = k;
    eta -= eta*beta;
    W = prev_W;
    if(eta < epsilon)
      break;
    endif
  endif
    
  
  prev_err = err;
  iter += 1;
 endwhile
 W = W_min;
  
 endfunction
 