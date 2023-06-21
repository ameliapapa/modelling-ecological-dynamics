%Title: papa_ricker1.m
%Author: Amelia Papa 
%Subject: BS5260 Modelling Ecological Dynamics
%Practical #4
%Date: 09/05/2019
%-------------------------------------------------------------------------
%This script projects the Ricker model, to demonstrate the strength of
%density dependence on population dynamics. The following
%assumptions are made to approximate a fish population:
%1. A discrete breeding season
%2. Reproductive maturity reached at age 1
%3. Density-independent adult survival
%4. Density-independent fecundity
%5. Density-independent larval survival and settlement
%6. Cannibalism of juveniles by adults between settlement and age 1

%Clear MATLAB's memory
clear all

%First we generate symbolic expressions for per-capita and total
%recruitment according the Ricker model described above.
syms a b d Nt

%a represents the strength of density dependence, or the steepness by which
%per-capita recruitment decreases, as population size increases

%b represents the density-independent component of recruitment, or the
%number of recruits produced per adult, in the absence of
%density-dependence.

totrecruit = b*Nt*exp(-a*Nt) %symbolic expression for total recruitment
pcrecruit = b*exp(-a*Nt) %symbolic expression for per-capita recruitment
newN = [1-d+b*exp(-a*Nt)]*Nt %population size next year

%Plot per-capita recruitment as a function of population size for different
%values of a and b.
Nt = 0:0.01:1; %population size from time 0 to 1, in steps of 0.01
b = 3; 
a = 5;
pcrecruitvals1 = eval(pcrecruit); %The first evaluation of per-capita 
%recruitment with values of b=3 and a=5
plot(Nt, pcrecruitvals1, 'k')
hold on %allows multiple lines to be plotted on the same figure
b = 4;
a = 5;
pcrecruitvals2 = eval(pcrecruit); %The second evaluation of per-capita 
%recruitment with values of b=4 and a=5
plot(Nt, pcrecruitvals2, 'm')
b = 3;
a = 6;
pcrecruitvals3 = eval(pcrecruit); %The third evaluation of per-capita 
%recruitment with values of b=3 and a=6
plot(Nt, pcrecruitvals3, 'b')
xlabel('Per-capita recruitment')
ylabel('Population size')
title('Figure 1')
hold off
%--------------------------FIGURE LEGEND-----------------------------------
%Figure 1. Graphs show a projection of per-capita recruitment, as a
%function of population size. The black coloured line has the original
%values of a and b, which are 5 and 3 respectively. The magenta coloured
%line shows how with an increase in number of recruits produced per adult,
%the line will move above the original. However, if the
%strength of density dependence increases (a), the new blue line will be 
%lower than the original black line. This is explained by the fact that as
%the number of recruits produced per adult increases, in the absence of
%density dependence, consequently the population size at time "t" and "t+1"
%will increase. Similarly, an increase in "a", leads to a steeper rate of
%decrease for per-capita recruitment, and the opposite effect is observed.
%That is, lower values of population size are recorded.

%Plot total recruitment as a function of population size for different
%values of a and b.
Nt = 0:0.01:1;
b = 3;
a = 5;
recruitvals4 = eval(totrecruit); %evaluates the expression totrecruit
plot(Nt,recruitvals4, 'k') %The black coloured line represents the 
                           %original values of b=3 and a=5
ylabel ('Total Recruitment')
xlabel ('Population Size')
title('Figure 2')
hold on
b = 4;
a = 5;
recruitvals5 = eval(totrecruit);
plot(Nt,recruitvals5, 'm')
b = 3;
a = 6;
recruitvals4 = eval(totrecruit);
plot(Nt,recruitvals4, 'b')
hold off
%-------------------------Figure 2-----------------------------------------
%Figure 2. The plots show a projection of total recruitment of the fish 
%population, as a function of population size. The black coloured line
%represent the starting values of b=3 and a=5. An increase in the
%values of "a" yields a line below the original, whereas an increase in the
%values of "b" yields a line above the original. That is because as density
%dependence increases, per-capita recruitment also decreases, and
%population size cannot reach the same values as it did when density
%dependence was absent. The opposite happens when the density independent
%component of recruitment increases (b), as this increases the number of
%recruits produced per adult, and therefore the maximum value of population
%size will be higher.

% Plot next years population size as a function of population size this year
Nt = 0:0.01:1;
b = 3;
a = 5;
d = 0.1;
newNvals1 = eval(newN);
plot(Nt, newNvals1, 'k')
hold on
ylabel ('Population size at time "t+1"')
xlabel ('Population size at time "t"')
title('Figure 3')
plot(Nt, Nt, 'r') %plots the "unity line", where population size at time "t"
%equals the population size at time "t+1". This point on the graph is also
%one of the two equilibrium population sizes, where the population's growth
%rate is zero.
hold off
%-----------------------Figure 3------------------------------------------
%Figure 3. The plot shows a projection of next years population size as a
%function of population size this year. The point where the curve
%intersects the red line is the "persistence" equilibrium, where the
%population size at time t equals the population size at time t+1.

