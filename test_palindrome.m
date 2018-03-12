ent1 = ones(1, 11)*-1;
ent1(:, 2:11) = tanh(ent*W);
tanh(ent1*W2)