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
	mean=pars[3];
	sigma=pars[4];
	return A*numpy.exp(-B*x)+C*numpy.exp(-1./2.*((x-mean)/sigma)**2)

# parameters
a=1000 # exp. norm.
b=0.2 # exp. slope
c=100 # gauss norm
mean=8 # peak location
sigma=1 # width
seed = [a, b, c, mean, sigma]

x = numpy.arange(0, 20, 0.01)
y = model(x, seed)

x_pts = numpy.arange(1., 20., 1.0)
y_exp = model(x_pts, seed)
#y_obs = numpy.random.poisson(y_exp)
y_obs = [800, 704, 578, 458, 339, 323, 320, 311, 221, 139, 105, 87, 73, 60, 56, 46, 36, 32, 26]
y_errs = numpy.sqrt(y_obs)

chi2 = lambda pars: numpy.sum((y_obs-model(x_pts,pars))**2/model(x_pts,pars))
result = optimize.minimize(chi2, seed, method='Nelder-Mead')
chi2_min = result.fun
print "best fit is:", result.x, "with chi2:", chi2_min

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

# calculate uncertainties for mean
means = numpy.linspace(result.x[3]-0.3, result.x[3]+0.3, 100).tolist()
chi2vals = []
for mu in means:
       	def chi2_rel(pars, mu=mu):		
    		current_pars = list(pars[:3])+[mu]+list(pars[3:])		
    		y_exp = model(x_pts, current_pars)
    		return numpy.sum((y_obs-y_exp)**2/y_exp) - chi2_min
    
    	x0 = [seed[0], seed[1], seed[2], seed[4]]
    	res = optimize.minimize(chi2_rel, x0, method='Nelder-Mead')
	chi2vals.append(res.fun)

fig = plt.figure(figsize=(7, 6), dpi=200)
ax = plt.axes()
ax.plot(means, chi2vals, "k-")
ax.set_ylabel('$\\Delta\\chi^2$', position=(0., 1.), va='top', ha='right')
ax.set_xlabel('mean [keV]', position=(1., 0.), va='bottom', ha='right')
ax.yaxis.set_label_coords(-0.12, 1.)
ax.xaxis.set_label_coords(1.0, -0.1)
plt.savefig("chi2.png")

# find roots numerically via interpolation
from scipy.interpolate import InterpolatedUnivariateSpline
spline = InterpolatedUnivariateSpline(means, numpy.asarray(chi2vals)-1.)
roots = spline.roots()
print "best fit:", result.x[3], "+", roots[1]-result.x[3], "-", result.x[3]-roots[0]

 
    

      






