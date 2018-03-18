function [T, S] = load_data(file)
  M = dlmread(file)(2:end,:);  
  T = M(:,1:end-1);
  S = M(:,end);
endfunction
  