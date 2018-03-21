#Input layer nodes
I = 5;
#Hidden layer nodes
H = 7;
#Output layer nodes
O = 1;
#Learning rate
n = 0.01;
#Learning attempts
N = 10000;


#Weights Input -> Hidden
Wih = rand(I+1,H);
#Weights Hidden -> Output
Who = rand(H+1,O);


#Activation function
function ans = act(x)
  ans = 1./(1+exp(-x));
endfunction

#Expected output function
function ans = output(x)
  ans = parity_function(x);
endfunction

#Error function
function ans = error(output, expected)
  e = ((expected - output)**2)/2;
  ans = sum(e);
endfunction

#Delta function
function ans = delta(output, difference)
  ans = difference .* (output - output.**2);
endfunction


#Saved Errors from learning tests will be called SE
SE = zeros(1,N);


for (x = 1:N)

Iout = rand(1,I) > 0.5;
# 1xI+1
Iout(I+1) = 1;

# 1xO
Oexpected = output(Iout(1:I));


# 1xI+1 * I+1xH = 1xH 
Hnet = Iout * Wih;


Hout = act(Hnet);
# 1xH+1
Hout(H+1) = 1;


# 1xH+1 * H+1xO = 1xO
Onet = Hout * Who;
# 1xO
Oout = act(Onet);

#Errors
#Calculate error with error function
Etotal = error(Oout, Oexpected);
#Save total error from trial
SE(x) = Etotal;


#Calculate deltaO (1xO)
difference = Oout - Oexpected;
dO = delta(Oout, difference);

#Calculate deltaHO (Represents the change on weights) H+1xO
dHO = transpose(Hout) * dO;

#We update the weights from Hidden to Output
Who = Who - n * dHO;


#Calculate deltaH (1xH+1)
dH = delta(Hout, dO*transpose(Who));

#Calculate deltaHO (Represents the change on weights) I+1xH
dIH = transpose(Iout) * dH(1:H);

#We update the weights from Hidden to Output
Wih = Wih - n * dIH;

endfor