H = [10 10]

[W E seed min_err min_iter] = train_adaptive_eta(T, S, length(H), H, 1, eta=0.1, momentum=0, alfa=0.05, beta=.1, k=5, epsilon = 0.00001, error_epsilon = .001)

UTILIZANDO W INICIAL ENTRE -.5 y .5

min_err =   9.8479e-004

min_iter =  5989


##########################

ERROR RATES

##########################

>> test_comparison_data(Tc, Sc, W, 0.05)
ans =  0.84444
>> test_comparison_data(Tc, Sc, W, 0.06)
ans =  0.93333
>> test_comparison_data(Tc, Sc, W, 0.07)
ans =  0.95556
>> test_comparison_data(Tc, Sc, W, 0.08)
ans =  0.95556
>> test_comparison_data(Tc, Sc, W, 0.09)
ans =  1
>> test_comparison_data(Tc, Sc, W, 0.1)
ans =  1

##########################

GREATEST ERRORS

##########################

>> max(diff)
ans =  0.083535
>> min(diff)
ans =  0.0016803

>> mean(diff)
ans =  0.028712


>> Tc(3,:)
ans =

   1.00000   0.87405

>> Tc(7,:)
ans =

  -0.35731   0.42213

>> Tc(22,:)
ans =

   0.25346  -0.24045

>> Tc(34,:)
ans =

  -0.44813   0.31066