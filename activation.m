function [G, G_1] = activation(actfunc, H, samples, o=true)
  if (strcmp('tanh', actfunc) == 1)
    tempV = tanh(H);
    if (o)
      G = [(ones(samples, 1) * -1) tempV];
    else
      G = tempV;
    endif
    G_1 = (1- tempV .** 2);
  elseif (strcmp('logistic', actfunc) == 1)
    tempV = 1 ./ (1 + exp(-2.*H));
    if (o)
      G = [(ones(samples, 1) * -1) tempV];
    else
      G = tempV;
    endif
    G_1 = 2 .* tempV .* (1 - tempV);
  endif
endfunction
