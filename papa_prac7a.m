%Title: papa_prac7a.m
%Author: Amelia Papa 
%Subject: BS5260 Modelling Ecological Dynamics
%Practical #6 Trohic Dynamics and Ecosystem Collapse
%Tutor: Alfonso Ruiz Moreno
%Date: 31/05/2019
%-------------------------------------------------------------------------
%This script projects trophic dynamics and its effect on the ecosystem. The
%model consists of an abiotic resource (R), a basal species that consumes
%the resource (B1), an herbivore that consumes the basal species (B2), and
%a predator that consumes the herbivore (B3). By looking at three trophic
%levels, the aim is to investigate major shifts in the structure of an
%ecosystem, and the rate at which these changes happen. Steady states are 
%calculated from the growth rate equations of all trophic levels, and
%consequently 5 possible equilibria.

%First, we clear MATLAB's history
clear all

%Start by declaring all necessary symbolic variables
syms S a u1 c1 d1 u2 c2 d2 u3 c3 d3 R B1 B2 B3

%Set up symbolic expressions for the growth rate equations
dRdt = S - a*R - u1*R*B1
dB1dt = c1*u1*R*B1 - d1*B1 - u2*B1*B2
dB2dt = c2*u2*B1*B2 - d2*B2 - u3*B2*B3
dB3dt = c3*u3*B2*B3 - d3*B3 

%Find the resource concentration and biomass levels at which the community
%is at a steady state
[B1hat B2hat B3hat Rhat] = solve(dB1dt,dB2dt,dB3dt,dRdt,[B1,B2,B3,R]) 

%Equilibrium #1: Resource + All consumers
%Equilibrium #2: Resource + Basal species
%Equilibrium #3: Not meaningful biologically
%Equilibrium #4: Resource + No consumers
%Equilibrium #5: Resource + Basal species + Herbivore

%The third equilibrium, whith only B2,B3 and the resource is not 
%biologically meaningful. This is because B2 and B3 cannot make use of the
%resources, without B1. Consequently their population will decrease towards
%extinction.

save papa_nhats





