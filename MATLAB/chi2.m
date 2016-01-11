function y = chi2(f, pars, x, y_obs)
    y_exp=f(x, pars);
    y=sum((y_exp-y_obs).^2./y_exp);  
end