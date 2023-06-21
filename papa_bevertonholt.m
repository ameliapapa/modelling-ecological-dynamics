%Title: papa_bevertonholt.m
%Author: Amelia Papa 
%Subject: BS5260 Modelling Ecological Dynamics
%Practical #4
%Date: 13/05/2019
%-------------------------------------------------------------------------
%This script projects an analysis of fish population dynamics using the
%Beverton-Holt model. This model is reasonably well approximated by the 
%following assumptions:
%1. A discrete breeding season
%2. Reproductive maturity reached at age 1
%3. Density-independent adult survival
%4. Density-independent fecundity
%5. Density-independent larval survival and settlement
%6. Settling larvae compete with one another during the juvenile phase.
%The aim is to find the possible equilibrium sizes, and investigate the 
%conditions under which those equilibria are unstable or locally stable.

%First, clear MATLAB's memory
clear all

%We re-declare values of b,a,d and Nt as symbolic variables
syms a b d Nt

%The symbolic expression of population size at time "t+1" versus Nt,
%according to the Beverton-Holt model.
newN = [1-d+b/(1+a*Nt)]*Nt

%Find the possible equilibria, where the population's growth rate is zero.
nhats = newN == Nt 
solve(nhats, Nt)
nhats1 = 0 %first equilibrium population size
nhats2 = (b - d)/(a*d) %second equilibrium population size

slope = diff(newN, Nt) %Finds the derivative of Nt+1 with respect to Nt
slope1 = subs(slope, Nt, nhats1) %The slope of the first equilibrium is 1+b-d
slope2 = subs(slope, Nt, nhats2) 

%Simplify the answer for the slope of the second equilibrium
simplify(b/((b - d)/d + 1) - d - (b*(b - d))/(d*((b - d)/d + 1)^2) + 1)

%The slope of the second equilibrium equals (d^2 - b*d + b)/b, which can 
%be rearranged to form 1-d(1-d/b).

%The first slope can have a magnitude greater than 1, so we conclude that
%the equilibrium, when population size equals zero, is unstable. The
%biological explanation is that when in a good year, population size
%slightly increases from zero, there will be more recruits in the
%population, therefore the population will continue to increase away from
%the equilibrium.

%The second slope, for the "persistence" equilibrium can only have a 
%magnitude between 0 and 1, thus making the equilibrium population size 
%locally stable. Because the Beverton-Holt
%model exhibits density-dependent recruitment, as population size
%increases, and total recruitment plateaus, the population size will always 
%return to equilibrium.

%The difference between the Beverton-Holt and Ricker model, in terms of
%total recruitment plotted against population size, is that competition
%between settling larvae sets an asymptote for the number of total
%recruitment. As the population size increases, the resources for which the
%larvae compete to settle, will be limited. There will come a point when
%the competition between larvae and larval mortality is high, but the
%number of total recruits, that is the larvae that eventually settle, will
%stay the same. This characteristic makes the Beverton-Holt model more
%prone to stability. 


