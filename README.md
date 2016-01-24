## PHY 445/515 Senior Laboratory - Chi-Squared Fitting Example

The code snippets provided by this repository are meant to help beginners learn non-linear fitting.
The following languages/tools are supported: __PYTHON, R, MATLAB, Mathematica__

The toy model assumes a superposition of a gaussian component (signal) on top of an exponentially decaying component (background).

Here the chi-square function is a sum over the expected and observed bin counts and approximates the poisson distribution that governs the number of counts in each bin by the appropriate gaussian distribution.<br>
BEWARE: This is wrong if bins with low number of counts (<~10) exist. 

The best-fit parameters are obtained numerically via minimization. 

useful links: <br>
https://it.stonybrook.edu/software/title/matlab <br>
https://it.stonybrook.edu/software/title/mathematica <br>
https://it.stonybrook.edu/software/title/python <br>
http://www.scipy.org/about.html <br>
https://it.stonybrook.edu/software/title/r-project <br>
https://www.r-project.org <br>




