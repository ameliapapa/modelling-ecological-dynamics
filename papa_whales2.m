%Title: papa_whale1
%Author: Amelia Papa
%Subject: BS5260
%Practical 3
%Date: 17/04/2019
%--------------------------------------------------------------------------

%This script projects the population dynamics of the northern right
%whale over time, based on the demographic estimates from 
%Caswell et al.(1999). 

%Stage 2: Population Size Over Time

%First, clear MATLAB's memory of any remaining variables.
clear all

%Define the variables:
p = 0.959 %probability of survival
m = 0.037 %probability that a surviving adult gives birth to a female
n = 150 %number of females in the population

for t=1:2000 
    p_rand = rand (1,n(t)); %For each female in the population at time t,  
    %an equally likely random value between 0 and 1 is recorded.
    surviv_vector = p_rand <p; 
    survivors = sum (surviv_vector);
    m_rand = rand (1,survivors);
    birth_vector = m_rand <m;
    births = sum (birth_vector);
    new_n = survivors + births;
    n = [n new_n]; %the new vector is now a matrix, which takes into 
    %account the population size at every time step.
end

%Plot the population trajectory
figure
plot (1:2001,n) %We are plotting from 1 to 2001 because the length of the 
%"n" vector is 2001. This also includes the next years population when
%t=2000.
xlabel ('Time')
ylabel ('Population Size')
title ('Whale Population Projection')

TimeofExtinction = find(n==0) 
%Creates a vector for when the population goes to zero.

min(TimeofExtinction) %Finds the first year that the population will be 
%zero. This will change everytime we run the code, because the surviving 
%females are randomly chosen.

%-------------------FIGURE LEGEND----------------------------------------
%Figure1. -- Graphs show a projection of whale populations, achieved by
%the effect of demographic stochasticity in small populations. In addition,
%the time to extinction can be interpreted from the graph, when the
%population size on the vertical axis reaches zero. This will differ every
%time the simulation is run.

%Stage 3: Extinction Risk Profiles
%From the graphs generated above, it is clear that the time to extinction
%is unpredictable. However, using the Extinction Risk Profile provided in
%the handout, we are able to put 95% confidence limits on the time to
%extinction.

%The Extinction Risk Profile was made from 1000 simulated population
%trajectories, which means that the data is normally distributed. This
%allows us to find the mean time of extinction, which is when the
%probability of the population not being extinct is 0.5. From here, we can
%add 0.475 to 0.5 and subtract 0.475 from 0.5, which is half of the 95%
%confidence range we are looking for. This is possible only because the
%data is symmetric. 
%From the graph, we can approximately say that there is a 97.5% probability
%that the population is not extinct in 400 years. From the binomial
%distribution, we know that the probability for the population to be
%extinct in 400 years is 2.5%. 
%Similarly, we can approximate that there is a 2.5% probability that the
%population will not be extinct in 1200 years, meaning there is a 97.5%
%probability that the population will be extinct in 1200 years.
%In conclusion, from the extinction risk profile above, we can be 95%
%confident that the population will be extinct between 400 to 1200 years.