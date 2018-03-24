H = [10 10]

[W E seed min_err min_iter] = train_adaptive_eta(T, S, length(H), H, 1, eta=0.1, momentum=0, alfa=0.05, beta=.1, k=5, epsilon = 0.00001, error_epsilon = .001)

UTILIZANDO W INICIAL ENTRE -.5 y .5


##########################

ERROR RATES

##########################


>> test_comparison_data(Tc, Sc, W, .05)
ans =  0.82222
>> test_comparison_data(Tc, Sc, W, .06)
ans =  0.84444
>> test_comparison_data(Tc, Sc, W, .07)
ans =  0.93333
>> test_comparison_data(Tc, Sc, W, .08)
ans =  0.97778
>> test_comparison_data(Tc, Sc, W, .09)
ans =  0.97778
>> test_comparison_data(Tc, Sc, W, .1)
ans =  0.97778
>> test_comparison_data(Tc, Sc, W, .11)
ans =  0.97778
>> test_comparison_data(Tc, Sc, W, .12)

##########################

GREATEST ERRORS

##########################

>> max(diff)
ans =  0.11943
>> min(diff)
ans =   5.9109e-005
>> mean(diff)
ans =  0.027833


>> T(22,:)
ans =

  -0.44813   0.22593

>> T(18,:)
ans =

   0.532994   0.098642

>> T(24,:)
ans =

  -0.44813  -0.46982

>> T(33,:)
ans =

   0.38458   0.82133
