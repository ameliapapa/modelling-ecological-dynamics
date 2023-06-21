%Title: papa_whale1
%Author: Amelia Papa
%Subject: BS5260
%Practical #3
%Date: 17/04/2019
%--------------------------------------------------------------------------

%This script projects the population dynamics of the northern right
%whale, by incorporating stochasticity into population projections and 
%exploring extinction risk for the species, based on the demographic 
%estimates from Caswell et al.(1999). 

%The model assumes a 1:1 sex ratio and that females never produce more than
%one offspring in a year. With the aim of modelling population dynamics of 
%females, we look for how many females will be alive next year, for every
%female alive this year.

%Stage 1
%First, clear MATLAB's memory of any remaining variables.
clear all

%Define the variables:
p = 0.959 %probability of female survival
m = 0.037 %probability that a surviving female gives birth
n = 150 %the initial number of females in the population
%From these values, the geometric growth factor can be calculated for this
%population and it would be 0.996. This calculation shows that the
%population size is expected to decrease over time (R<1).

p_rand = rand(1,n);
%For each female in the population, an equally likely random value
%between 0 and 1 is generated. A separate random number is needed for each
%female, because demographic stochasticity is chance variation in the fate
%of the individuals. This means that every individual will influence
%fluctuations in population size.

surviv_vector = p_rand < p; 
%Creates a new vetor with "0" or "1" values. If the value from the p_rand
%vetor is smaller than p=0.959,then "1" is recorded.
%If the value is greater, than "0" is recorded in this new surviv_vector.

survivors = sum(surviv_vector)
%The values of the surviv_vector are added, which returns the total number
%of surviving females in the population.
survivors


%For a female to give birth, she first has to survive. This is why 

m_rand = rand(1,survivors)
%For a female to give birth, she first has to survive. This is why the
%number of survivors is used to generate this vector, which a random value
%between 0 and 1 for each of the living female.

birth_vector = m_rand < m
%Each number in the m_rand vector is checked, and "1" is recorded if the 
%number is less than theprobability that a surviving female gives birth.
%However, if the number is greater than m=0.037, then "0" is recorded.

births = sum(birth_vector);
%Adds up the number of living female calfs to give the number of births.

new_n = survivors +  births;
%Adds the surviving females and births, to find the female population
%size at the beginning of next year. The total population size will be 
%double this value, considering the 1:1 sex ratio.

new_n
