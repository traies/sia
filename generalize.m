function [XY, Z] = generalize(W, lo=-2, incr=.1, hi=2)
  XY = [];
  Z = [];
  for x=lo:incr:hi
    for y=lo:incr:hi
      XY(end+1, :) = [tanh(x) tanh(y)];
      Z(end+1) = evaluate(XY(end,:), W);
    endfor
  endfor
endfunction
