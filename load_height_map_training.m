function [T, S] = load_height_map_training(name,samples,lo=-1,hi=1)

  A = imread(name);
  length = size(A)(1);
  T = S = [];
  incr = uint16(length/sqrt(samples));
  for x=1:incr:length
    for y=1:incr:length
      T(end+1,:) = [x y];
      S(end+1) = A(x, y);
    endfor
   endfor
   S = S'; 
   
   T(:,1) = feature_scaling(T(:,1),lo,hi);
   T(:,2) = feature_scaling(T(:,2),lo,hi);
   S = feature_scaling(S,lo,hi);
endfunction
  