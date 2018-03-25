H = [10 10]
[W E seed min_err min_iter] = train_batch_momentum(Tt, St, length(H), H, 1, eta=0.001, momentum=.9, error_epsilon = .0001, max_iters = 100000);

UTILIZANDO W INICIAL ENTRE -.5 Y .5

min_err == iter

##########################

ERROR RATES

##########################

>> test_comparison_data(Tc, Sc, W, .05)
ans =  0.77778
>> test_comparison_data(Tc, Sc, W, .06)
ans =  0.88889
>> test_comparison_data(Tc, Sc, W, .07)
ans =  0.95556
>> test_comparison_data(Tc, Sc, W, .08)
ans =  0.97778
>> test_comparison_data(Tc, Sc, W, .09)
ans =  1
>> test_comparison_data(Tc, Sc, W, .1)
ans =  1


##########################

GREATEST ERRORS

##########################


>> max(diff)
ans =  0.084863
>> min(diff)
ans =  0.0011897
>> mean(diff)
ans =  0.028660


>> T(7,:)
ans =

   0.50852   0.82133

>> T(5,:)
ans =

   0.942749  -0.012095

>> T(3,:)
ans =

  -1.00000  -0.93007

>> T(22,:)
ans =

  -0.44813   0.22593


