# t the sample to evaluate
# w weights of the network

function proy = evaluate(t, W)
    h = size(W)(2)-1;
    # add bias
    proy = [-1 t];
    # Feed forward, adding bias to each layer
    for i = 1:h
      proy = [-1 tanh(proy*W{i})];
    endfor
    proy = tanh(proy*W{h+1});
endfunction
  
  