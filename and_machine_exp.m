W = rand(6,1);

n = .5;
f = 1;
N = 16;
S = ones(1,N);
T = ones(N,6);
T(:, 1) = -1;
for x = 1:N
  for y = 2:6
    if(rand() < 0.5)
      T(x, y) = 0;
      S(x) = 0;
    else
      T(x, y) = 1;
    endif
  endfor
endfor

count = 0;
exit = false;
 
while !exit
  for x = randperm(N)
    O = (1 ./ (1 + exp(-2.*f*(T(x, :)*W))));
    Oder = 2 * O * (1 - O);
    delta = n*(S(x)-O)*Oder*T(x,:);
    W += delta';
  endfor
  
  exit = true;
  for x = 1:N
    res = tanh(T(x,:)*W);
    if(res > 0.5 && S(x) != 1 || res<0.5 && S(x) != 0)     
      exit = false;
      break
    endif 
  endfor
  count += 1;
endwhile
