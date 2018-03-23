H = [30]
[W E seed min_err min_iter] = train_batch_momentum(Tt, St, length(H), H, 1, eta=0.001, momentum=.9, error_epsilon = .0009);

##########################

ERROR RATES

##########################

>> test_comparison_data(Tc, Sc, W,0.05)
ans =  0.777777777777778
>> test_comparison_data(Tc, Sc, W,0.06)
ans =  0.844444444444444
>> test_comparison_data(Tc, Sc, W,0.07)
ans =  0.888888888888889
>> test_comparison_data(Tc, Sc, W,0.08)
ans =  0.955555555555556
>> test_comparison_data(Tc, Sc, W,0.09)
ans =  0.977777777777778
>> test_comparison_data(Tc, Sc, W,0.1)
ans =  0.977777777777778
>> test_comparison_data(Tc, Sc, W,0.11)
ans =  1


##########################

GREATEST ERRORS

##########################


>> Tc(5,:)
ans =

   1.000000000000000  -0.507477820025349

>> Tc(19,:)
ans =

  -0.256837570012926  -0.709433279015028

>> Tc(36,:)
ans =

  -1.000000000000000  -0.352670650009053

>> Tc(12,:)
ans =

   0.0612322274881516   0.6740177439797213

>> Tc(27,:)
ans =

  -1.0000000000000000   0.0986420423682781
