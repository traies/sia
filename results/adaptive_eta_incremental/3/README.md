H = [10 10]

[W E seed min_err min_iter] = train_adaptive_eta(T, S, length(H), H, 1, eta=0.1, momentum=0, alfa=0.05, beta=.1, k=5, epsilon = 0.00001, error_epsilon = .0001, max_iters = 10000)

UTILIZANDO W INICIAL ENTRE -.5 y .5


##########################

ERROR RATES

##########################

>> test_comparison_data(Tc, Sc, W, 0.05)
ans =  0.75556
>> test_comparison_data(Tc, Sc, W, 0.06)
ans =  0.80000
>> test_comparison_data(Tc, Sc, W, 0.07)
ans =  0.84444
>> test_comparison_data(Tc, Sc, W, 0.08)
ans =  0.91111
>> test_comparison_data(Tc, Sc, W, 0.09)
ans =  0.91111
>> test_comparison_data(Tc, Sc, W, 0.1)
ans =  0.97778
>> test_comparison_data(Tc, Sc, W, 0.11)
ans =  1

##########################

GREATEST ERRORS

##########################

>> max(diff)
ans =  0.10006
>> min(diff)
ans =   1.7035e-004
>> mean(diff)
ans =  0.030684


>> T(3,:)
ans =

  -1.00000  -0.93007

>> T(4,:)
ans =

   0.061232  -0.240449

>> T(23,:)
ans =

   1.00000  -0.11425

>> T(44,:)
ans =

  -0.14806   0.31066


