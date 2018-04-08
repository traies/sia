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

function [W E seed min_err min_iter] = train_batch_variable(T, S, h, H, out, act_func='tanh', eta=0.01, momentum=0.9, batch_size=60, error_epsilon = .001, max_iters = 10000, lo_rand_interv=-.5, hi_rand_interv=.5, plot_interval = 10)
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
 iter = 0;
 hold off;
 while 1
  proc = 0;
  while proc < samples
    Delta_W = {};
    prev = T_size + 1;
    for i = 1:h
     Delta_W{i} = zeros(prev, H(i));
     prev = H(i) + 1;
    endfor
    Delta_W{h+1} = zeros(prev, out);
    # Current batch size (either batch_size or the last bit to complete all samples)
    bsize = min(batch_size, samples - proc);
    V = {};
    # g'(h_i)
    V_1 = {};  
    # Add bias
    V{1} = [(ones(bsize, 1) * -1) T(proc+1:proc+bsize, :)];
    # Feed forward, add bias to each layer
    for i = 1:h
      [V{i+1}, V_1{i+1}] = activation(act_func, V{i} * W{i}, bsize, true);
    endfor
    # Feed forward last layer
    [V{h+2}, V_1{h+2}] = activation(act_func, V{h+1} * W{h+1}, bsize, false);
    Delta = {};
    # Find last delta (list indexes are backwards)
    
    Delta{h+1} =  V_1{h+2} .* (S(proc+1:proc+bsize) - V{h+2});
    # Backpropagation
    for i = h:-1:1
      Delta{i} = V_1{i+1} .* (Delta{i+1} * W{i+1}(2:end, :)');
    endfor
    
    # Save deltas for weights
    for i = 1:h+1
      oldWDelta{i} = eta * V{i}' * Delta{i} + momentum * oldWDelta{i};
      Delta_W{i} += oldWDelta{i};
    endfor
    
    # Update weights
    for i = 1:h+1
      W{i} += Delta_W{i};
    endfor 
    
    # Update proc
    proc += batch_size;
  endwhile
  err = 0;
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
    ylabel ("log10(Error cuadratico medio)");
    pause(0.01);
  endif;
  
  if (err < min_err)
    W_min = W;
    min_err = err;
    min_iter = iter;
  endif
  
  
  printf("Iter %g, Error: %f \n",iter, err);
  
  
  fflush(stdout);

  #break conditions: if reached local minimum
  if(iter >= max_iters || abs(prev_err-err) < 1e-20 || err < error_epsilon)
    break;
  endif
  
  iter += 1;
  prev_err = err;
  
 endwhile
 W = W_min;
  
 endfunction