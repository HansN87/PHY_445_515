% define model parameters
a = 1000;
b = 0.2;
c = 100;
mu = 8;
sigma = 1;
pars=[a b c mu sigma]

% generate model points
x=(0:0.01:20);
y=model(x, pars)

% generate random data points
x_pts=(1:1:19);
y_exp=model(x_pts, pars)
y_obs=poissrnd(y_exp)
y_std=sqrt(y_obs)
plot(x,y);
hold all;
errorbar(x_pts,y_obs,y_std, '.k')
%scatter(x_pts, y_obs, 'filled');