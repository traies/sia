function var = load_config_variable(config, field, isnumber)
  if (isfield(config, field))
    if (isnumber)
      var = str2num(config.(field));
    else
      var = config.(field);
    endif
  else
    if (isnumber)
      var = 0;
    else
      var = "";
    endif
  endif
endfunction
