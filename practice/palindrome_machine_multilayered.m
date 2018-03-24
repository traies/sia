H = 32;
I = 6;
N = 32;
p = .35;
eta = .01;
P = ones(0,0);

W = rand(I, H);
W2 = rand(H+1, 1);

S = ones(1,N);
T = ones(N,I);

T(:, 1) = -1;
for x = 1:N
  if(rand() < p)
    for i = 1:(I-1)/2
      v = (rand() > 0.5) * 2 - 1;
      T(x,i+1) = v;
      T(x,I-i+1) = v;
    endfor
  else
    T(x, 2:I) = (rand(1, I-1) > 0.5) * 2 - 1 ;
  endif
  S(x) = palindrome(I-1, T(x,2:I))*2-1;
endfor

exit = 0;
count = 0;

while(!exit)
  for x = randperm(N)
    
    #Hidden layer forward
    O = ones(1,H+1);
    O(1) = -1;
    O(2:H+1) = tanh(T(x, :)*W);
    Oder = 1 - O .** 2;
    #Output layer forward
    o = tanh(O*W2); 
    
    oder = 1 - o .** 2;
    
    #Backpropagation o -> Hidden
    delta1 = oder .* (S(x) - o);
    
    #Backpropagation Hidden -> Start
    #removing weight of threshold
    delta2 = Oder(2:end) .* (delta1 * W2(2:end)');
    
    #Update weights
    
    Delta = eta*T(x,:)'*delta2;
   
    delta = eta*delta1*O; 
    
    W += Delta;
    
    W2 += delta';
    
  endfor
  p = success_rate(T,S,W,W2,H);
  P(end+1) = p;
  if(p == 1)
    exit = 1;
  else
    count += 1;
  endif
endwhile



