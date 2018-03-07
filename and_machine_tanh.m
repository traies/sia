W = rand(6,1);

n = 0.05;
N = 32;
S = ones(1,N);
T = ones(N,6);
T(:, 1) = -1;
for x = 2:N
  for y = 2:6
    if(rand() < 0.5)
      T(x, y) = -1;
      S(x) = -1;
    else
      T(x, y) = 1;
    endif
  endfor
endfor

count = 0;
exit = false;
 
while !exit
  for x = randperm(N)
    O = tanh(T(x, :)*W);
    Oder = 1 - O ** 2;
    delta = n*(S(x)-O)*Oder*T(x,:);
    W += delta';
  endfor
  
  exit = true;
  for x = 1:N
    res = tanh(T(x,:)*W);
    if(res >= 0 && S(x) != 1 || res<0 && S(x) != -1)     
      exit = false;
      break
    endif 
  endfor
  count += 1;
endwhile




