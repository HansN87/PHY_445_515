function y = model(x, pars)
  A=pars(1); 
  B=pars(2); 
  C=pars(3); 
  D=pars(4); 
  E=pars(5);
  y=A*exp(-B*x)+C*exp(-1/2*((x-D)/E).^2); 
end