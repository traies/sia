W = rand(6,1);

n = 0.5;
N = 512;
S = ones(1,N);
T = ones(N,6);
T(:, 1) = -1;
for x = 16:N
  for y = 2:6
    T(x, y) = rand() < 0.5;
    if(T(x,y) == 0)
      S(x) = 0;
    endif
  endfor
endfor


for x = 1:N
  O = T(x, :)*W >= 0;
  delta = n*(S(x)-O)*T(x,:);
  W += delta';
endfor


