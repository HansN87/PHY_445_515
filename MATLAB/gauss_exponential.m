% define model parameters (gaussian + exponential)
a = 1000;
b = 0.2;
c = 100;
mu = 8;
sigma = 1;
pars=[a b c mu sigma];

% generate model points
x=(0:0.01:20);
y=model(x, pars);

% generate random data points
% and plot them

global x_pts;
x_pts=(1:1:19);
y_exp=model(x_pts, pars);
global y_obs;
y_obs=poissrnd(y_exp);

y_std=sqrt(y_obs);
p1=plot(x,y);
hold all;
errorbar(x_pts,y_obs,y_std, '.k');
xlabel('energy [keV]');
ylabel('counts');

% lets perform a minimization using the generated data points
f = @model;

seed=[a b c mu sigma];
pars_fit=fminsearch(@(pars) chi2(f, pars, x_pts, y_obs), seed);
fprintf('best fit values are %1.10e\n', pars_fit);
global chi2val;
chi2val=chi2(f, pars_fit, x_pts, y_obs);
p2=plot(x,f(x,pars_fit), 'red');
legend([p1 p2],{'true model','fit result'})
saveas(gcf,'fit.png')
hold off;

% need to calculate uncertainties (use mean as example)
mean_fit = pars_fit(4)
% define "scan" range
means = (mean_fit-0.3:0.01:mean_fit+0.3);
y=arrayfun(@uncertainties, means);

plot(means, y);
ylabel('Chisquare Difference');
xlabel('Mean [keV]');
saveas(gcf,'chisq.png')