# T training set (bias not included)
# S expected output
# h number of hidden layers
# H hidden layer dimensions (bias not included)
# out nodes in the outer layer
# W neural network weights
# eta 
# alfa
# beta decrease factor for adaptive eta
# k number of steps of a "consistent" decrease in the error

function W = train_adaptive_eta(T, S, h, H, out, eta=0.001, alfa=0.2, beta=.2, k=5, epsilon = 0.0001)
 W = {};
 T_size = size(T)(2);
 samples = size(S)(1);
 #  Consider bias in first layer size
 prev = T_size + 1;
 
 #for adaptive eta
 prev_err = Inf;
 consistent_decrease_iters = k;
 Delta_W = {};
 initial_eta = eta;
 initial_alfa = alfa;
 
 # Weights initialization (consider bias in each hidden layer)
 for i = 1:h
   W{i} = rand(prev,H(i));
   Delta_W{i} = zeros(prev, H(i));
   prev = H(i) + 1;
 endfor
 #  Initialize last layer
 W{h+1} = rand(prev, out);
 Delta_W{h+1} = zeros(prev, out);
 
 exit = 0;
 iter = 0;
 
 while 1
  
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
      WDelta = eta * V{i}' * Delta{i};
      W{i} += WDelta;
      Delta_W{i} += WDelta;
    endfor
    
  endfor
  
  # Check accuracy
  count = 0;
  for s = 1:samples
    proy = evaluate(T(s, :), W);
    err += (S(s) - proy) .** 2;
    # Check if proyection is OK. Add to counter.
    if (check_valid(S(s),proy))
      count = count + 1;
    endif
  endfor
  
  # Break if all samples passed
  if count == samples || err < 15
    break
  endif
  
  #adaptive eta
  delta_err = err-prev_err;
  
  if(delta_err < 0)
    if(consistent_decrease_iters <= 0)
      eta += alfa;
    else 
     consistent_decrease_iters -= 1;
    endif 
  elseif (delta_err > 0)
    #reset conditions
    consistent_decrease_iters = k;
    eta -= eta*beta;
    for o = 1:h+1
      #reset weights
      W{i} -= Delta_W{i};
    endfor
    if(eta < epsilon)
      eta = initial_eta;
    endif
  endif
    
  
  prev_err = err;
  #reset deltas for next epoch
  for o = 1:h+1
    Delta_W{i} *= 0;
  endfor
  
  printf("Iter %g, Success rate: %f\n", iter, count);
  printf("Error: %f \n", err);
  printf("Eta: %f \n", eta);
  fflush(stdout);
  
  iter += 1;
  endwhile
  
 endfunction
 