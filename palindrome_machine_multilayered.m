H = 10;
I = 6;
N = 32;
p = .35;
eta = .1;
n = 0.5;

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
  S(x) = palindrome(I-1, T(x,2:I));
endfor


for x = randperm(N)
  
  #Hidden layer forward
  O = ones(1,H+1);
  O(1) = -1;
  O(2:H+1) = tanh(T(x, :)*W);
  Oder = 1 - O .** 2;
  #Output layer forward
  o = tanh(O*W2); 
  
  oder = 1 - o ** 2;
  
  #Backpropagation o -> Hidden
  delta1 = (S(x) - o) * oder;
  
  #Backpropagation Hidden -> Start
  delta2 = Oder .* (delta1 * W2');
  
  #Update weights
  
  Delta = eta*delta2'*T(x,:);
 
  delta = eta*delta1*O; 
  
  W += Delta';
  
  W2 += delta';
  
endfor

