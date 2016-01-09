function y = uncertainties(mean)
    global x_pts;
    global y_obs;
    global chi2val;
    function z = reduced_model(x, pars)
          A=pars(1); 
          B=pars(2); 
          C=pars(3); 
          D=mean; 
          E=pars(4);
          z=A*exp(-B*x)+C*exp(-1/2*((x-D)/E).^2);
    end
    function w = delta_chi2(pars)
        y_exp = reduced_model(x_pts, pars);
        w = sum((y_exp-y_obs).^2./y_exp)-chi2val;
    end
    seed = [1000, 0.2, 100, 1]; % use the original values
    result = fminsearch(@(pars) delta_chi2(pars), seed);
    y=delta_chi2(result);
end