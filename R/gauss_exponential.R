# This code illustrates how to fit a model to observations
# using the standard chi^2 minimization technique.
# WARNING: Here we simulate a counting experiment (poisson distribution)
#          and thus the chi^2 technique is only valid asymptotically.
#          For low count data one would use a maximum likelihood technique instead.
#          This code is not optimized for speed and is meant for educational purpose only. 

library(Hmisc) # provides errorbar function "errbar"
rm(list=ls()) # clear memory
setwd("/Users/hans/Analysis/teaching/PHY505/fitting/")

# define the model (gaussian with exponentially decaying background)
model <- function(x, pars) {
  A=pars[1]; B=pars[2]; C=pars[3]; D=pars[4]; E=pars[5]
  A*exp(-B*x)+C*exp(-1/2*((x-D)/E)^2)
}

# parameters
a=1000 # exp. norm.
b=0.2 # exp. slope
c=100 # gauss norm
mu=8 # peak location
sigma=1 #1 # width
seed = c(a, b, c, mu, sigma)

# create model points for plotting
x<-seq(0,20,0.01)
y<-model(x, seed)

pts_model = data.frame(
  x  = x
  , y  = y
)

# create model points on sampling grid (bins)
x<-seq(1,19,by=1)
y<-model(x, seed)

# generate random numbers from poisson distribution in each "bin"
set.seed(1, kind = NULL, normal.kind = NULL) # change seed to obtained new dataset
yobs = rpois(length(y), y)
pts_obs = data.frame(
  x  = x
  , y  = yobs
  , sd = sqrt(yobs)
)

# define chi2 function
chi2 <- function(pars) {
    yobs = pts_obs$y
    xobs = pts_obs$x
    yexp = model(xobs, pars)
    sum((yobs-yexp)^2/yexp)
    # alternatively use sum((yobs-yexp)^2/yobs)
}

# do a numerical minimization
result = optim(seed, chi2, gr = NULL, method = "BFGS")
x = seq(0,20,by=0.01)
y = model(x, result$par)

pts_fit = data.frame(
  x  = x
  , y  = y
)

# plot the result
png(file="fitresult.png",width=1500,height=1250, res=250)
# line of original model
with (
  data = pts_model
  , expr = plot(x, y, "l", col="red", xlab="energy [keV]", ylab="counts", ylim=c(0.0,800.0), las=1)
)
# line of best fit
with (
  data = pts_fit
  , expr = lines(x, y, col="green", lwd=2)
)
# data points ...
with (
  data = pts_obs
  , expr = points(x, y, col="black", cex = .5,pch=21,bg="black", add=T)
)
# ... and errorbars
with (
  data = pts_obs
  , expr = errbar(x, y, y+sd, y-sd, add=T, pch=1, cap=.01, cex = .5)
)
legend(8,800, c("true model","fit result"), lty=c(1,1), lwd=c(2.5,2.5),col=c("red","green")) 
dev.off()

# perform crude uncertainty calculation 
# crude == ignore possible correlations between fit parameters (can be drastic underestimate)
# use mean of gaussian as example

reduced_model <- function(x, mean) {
   model(x, c(result$par[1], result$par[2], result$par[3], mean, result$par[5]))
}

delta_chi2 <- function(mean) {
  yobs = pts_obs$y
  xobs = pts_obs$x
  yexp = reduced_model(xobs, mean)
  # define chi2_min = 0
  sum((yobs-yexp)^2/yexp)-chi2(result$par)
}

# visualize - ranges are hardcoded
scan_x = seq(7.4,8.4, by=0.01)
scan_y = sapply(scan_x, delta_chi2)

png(file="chi2_mean.png",width=1500,height=1250, res=250)
plot(scan_x, scan_y, "l", col="black", xlab="", ylab="", las=1)
mtext(expression(paste(Delta, chi^2)), 2, 2.0, cex = 1.5)
mtext("mean [kev]", 1, 3.0, cex = 1.5)
dev.off()

# solve for Delta Chi2 == 1 via root finding.
f <- function (x, a) delta_chi2(x) - a
x1 = uniroot(f, c(result$par[4]-0.3, result$par[4]), tol = 0.0001, a = 1)
x2 = uniroot(f, c(result$par[4], result$par[4]+0.3), tol = 0.0001, a = 1)

paste("the mean is: ", result$par[4], " + ", x2$root-result$par[4], " - ", result$par[4]-x1$root)

# calculate uncertainties that take into account correlation:
# need to re-minimize nuisance parameters 
# (everything that is not the mean in our example)
# for each value of the parameter of interest 
# (in our case the mean)
# we need a nested function definition to this

minimize_stepwise <- function(mean) {
  reduced_model <- function(x, pars) {
    model(x, c(pars[1], pars[2], pars[3], mean, pars[4]))
  }
  delta_chi2 <- function(pars) {
    yobs = pts_obs$y
    xobs = pts_obs$x
    yexp = reduced_model(xobs, pars)
    # define chi2_min = 0
    sum((yobs-yexp)^2/yexp)-chi2(result$par)
  }
  seed = c(seed[1], seed[2], seed[3], seed[5])
  result2 = optim(seed, delta_chi2, gr = NULL, method = "BFGS")
  result2$value
}

scan_y = sapply(scan_x, minimize_stepwise)

png(file="chi2_mean_profile.png",width=1500,height=1250, res=250)
plot(scan_x, scan_y, "l", col="black", xlab="", ylab="", las=1)
mtext(expression(paste(Delta, chi^2)), 2, 2.0, cex = 1.5)
mtext("mean [kev]", 1, 3.0, cex = 1.5)
dev.off()

# solve for Delta Chi2 == 1 via root finding.
f <- function (x, a) minimize_stepwise(x) - a
x1 = uniroot(f, c(result$par[4]-0.3, result$par[4]), tol = 0.0001, a = 1)
x2 = uniroot(f, c(result$par[4], result$par[4]+0.3), tol = 0.0001, a = 1)

paste("the mean is: ", result$par[4], " + ", x2$root-result$par[4], " - ", result$par[4]-x1$root)

