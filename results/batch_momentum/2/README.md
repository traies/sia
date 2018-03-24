H = [10 10]
[W E seed min_err min_iter] = train_batch_momentum(Tt, St, length(H), H, 1, eta=0.001, momentum=.9, error_epsilon = .0001, max_iters = 100000);

UTILIZANDO W INICIAL ENTRE -.5 Y .5

min_err == iter

##########################

ERROR RATES

##########################


>> test_comparison_data(Tc, Sc, W, .05)
ans =  0.88889
>> test_comparison_data(Tc, Sc, W, .06)
ans =  0.93333
>> test_comparison_data(Tc, Sc, W, .07)
ans =  0.95556
>> test_comparison_data(Tc, Sc, W, .08)
ans =  0.97778
>> test_comparison_data(Tc, Sc, W, .09)
ans =  1
>> test_comparison_data(Tc, Sc, W, .01)
ans =  0.40000
>> test_comparison_data(Tc, Sc, W, .1)
ans =  1


##########################

GREATEST ERRORS

##########################


>> max(diff)
ans =  0.085488
>> min(diff)
ans =   9.3254e-004
>> mean(diff)
ans =  0.021261
>>

>> Tc(7,:)
ans =

   1.00000   0.58233

>> Tc(16,:)
ans =

   1.00000   0.82133

>> Tc(14,:)
ans =

  -0.14806  -0.35267

>> Tc(41,:)
ans =

   0.94275  -0.24045

>> Tc(25,:)
ans =

   0.16109   0.31066



