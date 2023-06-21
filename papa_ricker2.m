%Title: papa_ricker2.m
%Author: Amelia Papa 
%Subject: BS5260 Modelling Ecological Dynamics
%Practical #4
%Date: 09/05/2019
%-------------------------------------------------------------------------
%This script projects a symbolic analysis of population dynamics for a 
%population with Ricker-type recruitment. The aim is to find the possible 
%equilibrium sizes, and investigate the conditions under which those
%equilibria are unstable or locally stable.

%Clear MATLAB's memory
clear all

%We re-declare values of b,a,d and Nt as symbolic variables
syms a b d Nt
newN = [1-d+b*exp(-a*Nt)]*Nt %symbolic expression of population size next 
                             %year versus population size this year.
nhats = newN == Nt %finds the steady state where the population size
                   %in "t+1" equals the population size at time "t".
solve(nhats, Nt) %The solve function yields two solutions for the 
%steady state, 0 and log(b/d)/a. These are the two population sizes where 
%we have an equilibrium, for any given set of parameter values.
nhats1 = 0 %population size at the first equilibrium. This is when there are 
%no adults to reproduce or die, therefore the population will stay at zero.
nhats2 = log(b/d)/a %This is the population size at the second equilibrium, 
%which corresponds to the population's "carrying capacity". This depends on
%the model parameters b,d and a. As previously seen in papa_ricker.m, an
%increase in "b", yields higher values of population size, and
%simultaneously we should expect the equilibrium population size to
%increase. 
%The carrying capacity is negatively with the parameter "a", and therefore
%we expect a decrease in equilibrium population size, if "a" increases.
%Figure 1 and 2 demonstrate this relationship. 

%Now that we have the equilibrium population sizes, we wish to check their
%stability. 
%In order to investigate if these equilibria are stable or unstable
%mathematically, we look for the derivative of N at time t+1 versus N at
%time t. The function diff, find the slope of newN(N at time t+1) with
%respect to Nt. 

slope = diff(newN, Nt)
%Now that we have the slope of newN, it is useful to know the value of the
%slope at our two equilibria. 
slope1 = subs(slope, Nt, nhats1) %The slope when population size is zero, 
                                 %equals 1+b-d
slope2 = subs(slope, Nt, nhats2) %The slope for the second equilibrium
                                 %population size equals 1 - d*log(b/d).

%For a logistic model in discrete time, if the slope of the production
%function is in magnitude between 0 and 1, then the population returns 
%to equilibrium, and therefore this equilibrium is stable.

%For the Ricker model, since the values of both b and d are expected to be
%positive, with d always less than or equal to 1, it is safe to assume that 
%the second slope will have a magnitude between 0 and 1, and the 
%persistence equilibrium is stable. When the population size is zero, 
%the first slope can also have a magnitude greater than 1, meaning the 
%first equilibrium is unstable.

%The Ricker model is considered to exhibit density dependent
%post recruitment mortality,because as population size increases,
%the total recruitment decreases. This characteristic of the
%model, makes the population that experiences cannibalism of recruits
%prone to instability. At large values of "b", when adults produce large
%numbers of recruits (example b=200), and adult mortality is also high
%(example d=0.9), the magnitude of the second slope shows negative values
%smaller than -1, therefore the equilibrium is unstable. The biological
%explanation is that if individuals are dying very quickly, but also
%reproduce rapidly, there will be high fluctuations in the population size.
%The Beverton-Holt model will not exhibit the same fluctuations, because
%competition limits the number of total recruitment, and therefore is less
%prone to instability. 
