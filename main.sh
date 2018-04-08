#!/usr/bin/octave -qf

Config = readconf("default.conf");

terrain_name = load_config_variable(Config, "TERRAIN_NAME", false);
adjust_terrain = load_config_variable(Config, "ADJUST_TERRAIN", true);
adjust_low = load_config_variable(Config, "TERRAIN_LOW_ADJUST", true);
adjust_high = load_config_variable(Config, "TERRAIN_HIGH_ADJUST", true);

from_image = load_config_variable(Config, "READ_HEIGHT_MAP", true);
samples = load_config_variable(Config, "HEIGHT_MAP_SAMPLES", true);
if (from_image)
  [T, S] = load_height_map_training(terrain_name, samples, adjust_low, adjust_high);
  else
  [T, S] = load_data(
    terrain_name, 
    adjust_terrain, 
    adjust_low, 
    adjust_high);
endif

[Tt St Tc Sc] = select_for_training(T, S, str2num(Config.("TEST_TO_TRAIN_RATIO")));
H = load_config_variable(Config, "HIDDEN_LAYER_SIZES", true);
activation_func = load_config_variable(Config, "ACTIVATION_FUNCTION", false);
eta = load_config_variable(Config, "LEARNING_RATE_INIT", true);
momentum = load_config_variable(Config, "MOMENTUM", true); 
algorithm = load_config_variable(Config, "LEARNING_ALGORITHM", false);
error_epsilon = load_config_variable(Config, "ERROR_EPSILON", true);
max_iters = load_config_variable(Config, "MAX_ITERS", true);
lo_rand_interv = load_config_variable(Config, "W_RANDOM_INTERVAL_LOW", true);
hi_rand_interv = load_config_variable(Config, "W_RANDOM_INTERVAL_HIGH", true);
batch_size = load_config_variable(Config, "BATCH_SIZE", true);
alfa = load_config_variable(Config, "ADAPTIVE_ETA_ALFA", true);
beta = load_config_variable(Config, "ADAPTIVE_ETA_BETA", true);
epsilon = load_config_variable(Config, "ADAPTIVE_ETA_EPSILON", true);
k = load_config_variable(Config, "ADAPTIVE_ETA_K", true);
error_output = load_config_variable(Config, "OUTPUT_ERROR_FILE", false);
weights_output = load_config_variable(Config, "OUTPUT_WEIGHTS_FILE", false);
plot_interval = load_config_variable(Config, "PLOT_INTERVAL", true);
switch(algorithm)
case "CONSTANT"
  [W E seed min_err min_iter] = train_batch_variable(
        T,
        S, 
        length(H), 
        H,
        1,
        activation_func, 
        eta, 
        momentum,
        1,
        error_epsilon,
        max_iters,
        lo_rand_interv,
        hi_rand_interv,
        plot_interval);
case "BATCH"
  [W E seed min_err min_iter] = train_batch_momentum(
        T,
        S, 
        length(H), 
        H, 
        1, 
        activation_func, 
        eta, 
        momentum,
        error_epsilon,
        max_iters, 
        lo_rand_interv, 
        hi_rand_interv,
        plot_interval);
case "BATCH_VARIABLE"
  [W E seed min_err min_iter] = train_batch_variable(
        T,
        S, 
        length(H), 
        H, 
        1, 
        activation_func, 
        eta, 
        momentum, 
        batch_size,
        error_epsilon,
        max_iters, 
        lo_rand_interv, 
        hi_rand_interv,
        plot_interval);
case "BATCH_ADAPTIVE"
  [W E seed min_err min_iter] = train_adaptive_batch(
        T,
        S, 
        length(H), 
        H, 
        1, 
        activation_func, 
        eta, 
        momentum, 
        alfa, 
        beta, 
        k, 
        epsilon, 
        error_epsilon, 
        max_iters,
        lo_rand_interv,
        hi_rand_interv);
case "ADAPTIVE_ETA"
  [W E seed min_err min_iter] = train_adaptive_eta(
        T,
        S, 
        length(H), 
        H, 
        1, 
        activation_func, 
        eta, 
        momentum, 
        alfa, 
        beta, 
        k, 
        epsilon, 
        error_epsilon, 
        max_iters,
        lo_rand_interv, 
        hi_rand_interv,
        plot_interval);
endswitch
csvwrite(error_output, E);
for i = 1:size(W)(2)
  csvwrite(["layer_" num2str(i) "_" weights_output], W{i});
endfor


