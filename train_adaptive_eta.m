# T training set (bias not included)
# S expected output
# h number of hidden layers
# H hidden layer dimensions (bias not included)
# W neural network weights
# eta 
# alfa
# beta decrease factor for adaptive eta
# k number of steps of a "consistent" decrease in the error

function W = train_adaptive_eta(T, S, h, H, eta=0.001, alfa=0.2, beta=.2, k=5, epsilon = 0.0001)
 W = {};
 T_size = size(T)(2);
 samples = length(S);
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
 W{h+1} = rand(prev, 1);
 Delta_W{h+1} = zeros(prev, 1);
 
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
    err += (S(x) - V{h+2}) ** 2;
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
    proy = evaluate(T(x, :), W);
    # Check if proyection is OK. Add to counter.
    if( (S(s) > 0 && proy > 0) || (S(s) < 0 && proy <= 0))
      count = count + 1;
    endif
  endfor
  
  # Break if all samples passed
  if count == samples
    break
  endif
  
  #adaptive eta
  delta_err = err-prev_err;
  if(delta_err < 0)
    consistent_decrease_iters -= 1;
    if(consistent_decrease_iters <= 0)
      alfa = initial_alfa;
      eta += alfa;
    endif
  elseif (delta_err > 0)
    #reset conditions
    consistent_decrease_iters = k;
    eta -= eta*beta;
    alfa = 0;
    #reset weights
    for o = 1:h+1
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
 