# This code illustrates how to fit a model to observations
# using the standard chi^2 minimization technique.

library(Hmisc) # provides errorbar function "errbar"
rm(list=ls()) # clear memory
setwd("/Users/hans/Analysis/teaching/PHY505/fitting/")

# define the model (linear)
model <- function(x, pars) {
  A=pars[1]; B=pars[2];
  A+B*x
}

# parameters
a=1000 # offset
b=-100 # slope

seed = c(a, b)

stddev = 100 # std deviation of normal noise

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

# generate random numbers from norma distribution in each "bin"
#set.seed(1, kind = NULL, normal.kind = NULL) # change seed to obtained new dataset
yobs = rnorm(length(y), y, stddev)
pts_obs = data.frame(
  x  = x
  , y  = yobs
  , sd = stddev
)

# define chi2 function
chi2 <- function(pars) {
    yobs = pts_obs$y
    xobs = pts_obs$x
    yexp = model(xobs, pars)
    sum((yobs-yexp)^2/stddev^2)
}

# do a numerical minimization
result = optim(seed, chi2, gr = NULL, method = "L-BFGS-B")
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
  , expr = plot(x, y, "l", col="red", xlab="x [a.u.]", ylab="y [a.u.]", ylim=c(-1000.0,1000.0), las=1)
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

reduced_model <- function(x, offset) {
   model(x, c(offset, result$par[2]))
}

delta_chi2 <- function(offset) {
  yobs = pts_obs$y
  xobs = pts_obs$x
  yexp = reduced_model(xobs, offset)
  # define chi2_min = 0
  sum((yobs-yexp)^2/stddev^2)-chi2(result$par)
}

# visualize - ranges are hardcoded
scan_x = seq(900,1100, by=1)
scan_y = sapply(scan_x, delta_chi2)

png(file="chi2_mean.png",width=1500,height=1250, res=250)
plot(scan_x, scan_y, "l", col="black", xlab="", ylab="", las=1)
mtext(expression(paste(Delta, chi^2)), 2, 2.0, cex = 1.5)
mtext("offset [a.u.]", 1, 3.0, cex = 1.5)
dev.off()

# solve for Delta Chi2 == 1 via root finding.
f <- function (x, a) delta_chi2(x) - a
x1 = uniroot(f, c(result$par[1]-100, result$par[1]), tol = 0.0001, a = 1)
x2 = uniroot(f, c(result$par[1], result$par[1]+100), tol = 0.0001, a = 1)

paste("the mean is: ", result$par[1], " + ", x2$root-result$par[1], " - ", result$par[1]-x1$root)

# calculate uncertainties that take into account correlation:
# need to re-minimize nuisance parameters 
# (here: slope)
# for each value of the parameter of interest 
# (here: offset)
# we need a nested function definition to this

minimize_stepwise <- function(offset) {
  reduced_model <- function(x, pars) {
    model(x, c(offset, pars[2]))
  }
  delta_chi2 <- function(pars) {
    yobs = pts_obs$y
    xobs = pts_obs$x
    yexp = reduced_model(xobs, pars)
    # define chi2_min = 0
    sum((yobs-yexp)^2/stddev^2)-chi2(result$par)
  }
  seed = c(seed[1], seed[2])
  result2 = optim(seed, delta_chi2, gr = NULL, method = "L-BFGS-B")
  result2$value
}

scan_y = sapply(scan_x, minimize_stepwise)

png(file="chi2_mean_profile.png",width=1500,height=1250, res=250)
plot(scan_x, scan_y, "l", col="black", xlab="", ylab="", las=1)
mtext(expression(paste(Delta, chi^2)), 2, 2.0, cex = 1.5)
mtext("offset [a.u.]", 1, 3.0, cex = 1.5)
dev.off()

# solve for Delta Chi2 == 1 via root finding.
f <- function (x, a) minimize_stepwise(x) - a
x1 = uniroot(f, c(result$par[1]-100, result$par[1]), tol = 0.0001, a = 1)
x2 = uniroot(f, c(result$par[1], result$par[1]+100), tol = 0.0001, a = 1)

paste("the mean is: ", result$par[1], " + ", x2$root-result$par[1], " - ", result$par[1]-x1$root)

# demonstrate that the 2nd approach is more accurate by simulation
# parameters
a=1000 # offset
b=-100 # slope
seed = c(a, b)
numit = 1000
offsets = double(length=numit)
x<-seq(1,19,by=1)
y<-model(x, seed)
for (i in 1:numit) {
   yobs = rnorm(length(y), y, stddev)
   
   # define chi2 function
   chi2 <- function(pars) {
     xobs = pts_obs$x
     yexp = model(xobs, pars)
     sum((yobs-yexp)^2/stddev^2)
   }
   #set.seed(i, kind = NULL, normal.kind = NULL)
   result = optim(seed, chi2, gr = NULL, method = "L-BFGS-B")
   offsets[i] = result$par[1]
}
paste("std-deviation of offset found by simulation:",sd(offsets))

# compare to analytic result
xobs=pts_obs$x
D = sum(xobs*xobs/stddev^2)
B = 1/stddev^2*length(xobs)
A = sum(xobs/stddev^2)
err = D/(D*B-A^2)
paste("std-deviation of offset found by analytic calculation:",sqrt(err))