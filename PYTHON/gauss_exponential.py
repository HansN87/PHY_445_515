#!/usr/bin/env python

# This code illustrates how to fit a model to observations
# using the standard chi^2 minimization technique.
# WARNING: Here we simulate a counting experiment (poisson distribution)
#          and thus the chi^2 technique is only valid asymptotically.
#          For low count data one would use a maximum likelihood technique instead.
#          This code is not optimized for speed and is meant for educational purpose only. 

import numpy
import pylab as plt
from scipy import optimize

def model(x, pars):
	A=pars[0];
	B=pars[1];
	C=pars[2];
	D=pars[3];
	E=pars[4];
	return A*numpy.exp(-B*x)+C*numpy.exp(-1./2.*((x-D)/E)**2)

# parameters
a=1000 # exp. norm.
b=0.2 # exp. slope
c=100 # gauss norm
mu=8 # peak location
sigma=1 # width
seed = [a, b, c, mu, sigma]

x = numpy.arange(0, 20, 0.01)
y = model(x, seed)

x_pts = numpy.arange(1., 20., 1.0)
y_exp = model(x_pts, seed)
y_obs = numpy.random.poisson(y_exp)
y_errs = numpy.sqrt(y_obs)

chi2 = lambda pars: numpy.sum((y_obs-model(x_pts,pars))**2/model(x_pts,pars))
result = optimize.minimize(chi2, seed, method='Nelder-Mead')
print "best fit is:", result.x, "with chi2:", result.fun

y_fit = model(x, result.x)

fig = plt.figure(figsize=(7, 6), dpi=200)
ax = plt.axes()
ax.plot(x,y,"b-",label="true model")
ax.plot(x,y_fit,"r-",label="best fit")
ax.errorbar(x_pts, y_obs, yerr=y_errs, xerr=False, axes=ax, fmt='ko', markersize=2.0)
ax.set_ylabel('counts', position=(0., 1.), va='top', ha='right')
ax.set_xlabel('energy [keV]', position=(1., 0.), va='bottom', ha='right')
ax.yaxis.set_label_coords(-0.12, 1.)
ax.xaxis.set_label_coords(1.0, -0.1)
ax.set_ylim([0, 1.e3])
ax.legend()
plt.savefig("fit.png")
