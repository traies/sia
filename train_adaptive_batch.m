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

function [W E seed min_err min_iter] = train_adaptive_batch(T, S, h, H, out, act_func='tanh', eta=0.01, momentum=0.9, alfa=0.2, beta=.1, k=5, epsilon = 0.00001, error_epsilon = .001,  max_iters = 10000, lo_rand_interv, hi_rand_interv, plot_interval = 10)
W = {};
 E = [];
 seed = rand("seed");
 
 T_size = size(T)(2);
 samples = size(S)(1);
 
 #  Consider bias in first layer size
 prev = T_size + 1;
 
 oldWDelta = {};

 min_err = min_iter = prev_err = Inf;
 W_min = {};
 
 # Weights initialization (consider bias in each hidden layer)
 for i = 1:h
   W{i} = randinterv(prev,H(i),lo_rand_interv,hi_rand_interv);
   oldWDelta{i} = zeros(prev, H(i));
   prev = H(i) + 1;
 endfor
 #  Initialize last layer
 W{h+1} = randinterv(prev, out,lo_rand_interv,hi_rand_interv);
 oldWDelta{h+1} = zeros(prev, 1);
 
 
 #for adaptive eta
 prev_err = Inf;
 prev_W = W;
 consistent_decrease_iters = k;
 iter = 0;
 hold off;

 while 1
  
  Delta_W = {};
  prev = T_size + 1;
  for i = 1:h
   Delta_W{i} = zeros(prev, H(i));
   prev = H(i) + 1;
  endfor
  Delta_W{h+1} = zeros(prev, out);
  
  err = 0;
  # Samples are permutated on each iteration
  #for x = randperm(samples)
    V = {};
    # g'(h_i)
    V_1 = {};  
    # Add bias
    V{1} = [(ones(samples, 1) * -1) T(:, :)];
    # Feed forward, add bias to each layer
    for i = 1:h
      [V{i+1}, V_1{i+1}] = activation(act_func, V{i} * W{i}, samples, true);
    endfor
    # Feed forward last layer
    [V{h+2}, V_1{h+2}] = activation(act_func, V{h+1} * W{h+1}, samples, false);
    Delta = {};
    # Find last delta (list indexes are backwards)
    
    Delta{h+1} =  V_1{h+2} .* (S - V{h+2});
    # Backpropagation
    for i = h:-1:1
      Delta{i} = V_1{i+1} .* (Delta{i+1} * W{i+1}(2:end, :)');
    endfor
    
    # Save deltas for weights
    for i = 1:h+1
      oldWDelta{i} = eta * V{i}' * Delta{i} + momentum * oldWDelta{i};
      Delta_W{i} += oldWDelta{i};
    endfor
  #endfor
  
  # Update weights
  for i = 1:h+1
    W{i} += Delta_W{i} / samples;
  endfor 
  
  # Compute global error
  for s = 1:samples
    proy = evaluate(T(s, :), W);
    v = (S(s) - proy);
    err += v*v';
  endfor
  err /= 2*samples;
  E(end+1) = err;
  
  if (mod(iter, plot_interval) == 0)
    subplot (2, 1, 1)
    plot(1:iter+1, E, '-b');
    xlabel ("Iteraciones");
    ylabel ("Error cuadratico medio")
    subplot (2, 1, 2)
    plot(1:iter+1, log10(E), '-b');
    xlabel ("Iteraciones");
    ylabel ("log10(Error cuadratico medio)")
    pause(0.01);
  endif;
  
  if (err < min_err)
    W_min = W;
    min_err = err;
  endif
  

  printf("Iter %g, Error: %f \n",iter, err);
  printf("Eta: %f \n", eta);
  
  fflush(stdout);
  
  # Break if all samples passed
  if err < error_epsilon
    break;
  endif
  
  #adaptive eta
  delta_err = err-prev_err;
  
  if(delta_err < 0)
    if(consistent_decrease_iters <= 0)
      eta += alfa;
      consistent_decrease_iters = k;
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
  else
    break;  
  endif
  
  if(iter >= max_iters)
    break;  
  endif
  
  prev_err = err;
  iter += 1;
 endwhile
 W = W_min;
  
 endfunction