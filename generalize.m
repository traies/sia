function [XY, Z] = generalize(W, lo=-2, incr=.1, hi=2)
  XY = [];
  Z = [];
  for x=lo:incr:hi
    for y=lo:incr:hi
      XY(end+1, :) = [x y];
    endfor
  endfor
  
  XY(:,1) = feature_scaling(XY(:,1),-1,1);
  XY(:,2) = feature_scaling(XY(:,2),-1,1);
  
  for i=1:size(XY)(1)
    Z(i) = evaluate(XY(i,:), W);
  endfor  
  
endfunction
