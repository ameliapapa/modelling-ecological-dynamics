%Title: papa_prac7b.m
%Author: Amelia Papa 
%Subject: BS5260 Modelling Ecological Dynamics
%Practical #6 Trohic Dynamics and Ecosystem Collapse
%Tutor: Alfonso Ruiz Moreno
%Date: 31/05/2019
%-------------------------------------------------------------------------
%This script projects a model of trohic dynamics, aiming to investigate
%bottom-up and top-down effects on the food chain. The absence of one
%trophic level leads to a different odd/even pattern of the system, which
%in turn reflects different changes in population sizes. The influence of
%certain trophic levels is investigated using invasibility analysis, as
%well as the odd-even phenomenon. In conclusion, with regards to the lake
%eutrophication example, nutrient runoff has shown to have a positive
%impact on algal abundance, only in the absence of the herbivores.

%First clear MATLAB's history
clear all

%Declare all model parameters as "global"
global S a u1 c1 d1 u2 c2 d2 u3 c3 d3 R B1 B2 B3
load papa_nhats

%Next, we want to determine the conditions required for these trophic
%levels to persist together, by doing an invasibility analysis.

%The first question we ask is, can the basal species increase when rare in
%the presence of the resource.

pc1 = c1*u1*R - d1 - u2*B2 %per capita growth rate of trophic level 1

invade1 = subs(pc1, {R,B2},{Rhat(4), B2hat(4)}) %plugs in the values of R 
%B2 for the resource-only equilibrium

%If the per capita growth rate of the basal species at the resource-only
%equilibrium is positive (S*c1*u1/a - d1 > 0), then the basal species will
%increase when rare in the presence of the resource. 

%S/a > d1/c1*u1 is the rearranged expression of the inequality. 
%S/a is the amount of resources at the equilibrium, where all consumers are
%absent. Because trophic 1 needs less resources to maintain a stable 
%equilibrium when it is present in the environment, compared to the higher 
%amount of resources required in its absence, the conclusion can be made
%that the basal species can increase when rare and establish. This is
%consistent with the R* principle.


%Now let's look at the conditions under which trophic level 2 can establish

pc2 = c2*u2*B1 - d2 - u3*B3 %This is the equation for the per-capita growth 
%rate of trophic level 2. However, for the invasibility analysis, u3 and B3
%can be ignored. This is because the predator's " per-capita consumption 
%rate" (u3) will be zero, when there are no herbivores to consume.
%Equilibrium 2, with resource and basal species only, also shows how in the
%absence of B2, B3hat is zero.

invade2 = subs(pc2, {R,B1,B3},{Rhat(2), B1hat(2), B3hat(2)}) %plugs in the 
%values of R and B1

%After rearranging the inequality - d2 - (c2*u2*(a*d1 - S*c1*u1))/(d1*u1)
%by hand, we get : (S*c1*u1-a*d1)/d1*u1 > d2/c2*u2. 
%The expression on the right on the inequality is B1hat for equilibrium 5,
%when the herbivore is present. This means that the herbivore can increase
%when rare, only if the prey required for it to persist in the habitat
%is lower than the prey equilibrium when the herbivore is absent. This finding
%is consistent with the R* principle, that supports the principle of
%competitive exclusion (Species cannot coexist when competing for a single,
%shared limiting resource).

%By increasing S, the resource equilibrium concentration in the absence of 
%trophic level 1 will increase, but the resource equilibrium concentration 
%with basal species present will not change, because there is no
%"S" in the expression. As a result, it will be easier for trophic level 1
%to establish.

%Now let's look at the conditions under which trophic level 3 can establish
pc3 = c3*u3*B2 - d3 %This is the equation for the per-capita growth 
%rate of trophic level 3.
invade3 = subs(pc3, {B2},{B1hat(2)})
%-------------------------------------------------------------------------

%Numerical analysis
%We start by defining all variables to equal 0.1, except S. 
c1 = 0.1; c2 = 0.1; c3 = 0.1;
u1 = 0.1; u2 = 0.1; u3 = 0.1; 
d1 = 0.1; d2 = 0.1; d3 = 0.1;
a = 0.1; 


S = 0.2; %The case of a system with low productivity
N_init = [1; 0.25; 0.1; 4];
tf = 100;
[t n] = ode45('papa_prac7c',[0 tf],N_init);
figure
plot(t,n)
xlabel("Time")
ylabel("Population Size")
legend("trophic 1","trophic 2","trophic 3","resource")
title("S = 0.2") 

%----------------------------FIGURE LEGEND---------------------------------
%Figure 1. This Figure plots the population size of all trophic levels
%over time. Low productivity (S=0.2) is unable to sustain any consumers
%and they all become extinct. The resource heads towards equilibrium (S/a).


%Invasibility analysis: Each trophic level can invade if the abundance of
%its prey, when they arrive, is higher than the abundance of the prey at
%which that invading trophic level has exactly zero per capita growth.

eval(invade1) %The per capita growth rate of the basal species at the 
%resource-only equilibrium equals -0.08, which is less than zero, meaning
%the basal species can increase when rare.
eval(invade2) %The per-capita growth rate of trophic level 2 at the 
%resource+trophic level 1 equilibrium is negative, meaning it is able to
%increase when rare. 
eval(invade3) %The per-capita growth rate of trophic level 3 at the 
%resource+basal species+ herbivore equilibrium is negative, meaning it 
%can increase when rare.

S = 20; %The productivity of the system is increased  one hundredfold to see 
%if it can support all trophic levels.
N_init = [1; 0.25; 0.1; 4];
tf = 100;
[t n] = ode45('papa_prac7c',[0 tf],N_init);
figure
semilogy(t,n)
xlabel("Time")
ylabel("Population Size")
legend("trophic 1","trophic 2","trophic 3","resource")
title("S = 20") 

%----------------------------FIGURE LEGEND---------------------------------
%Figure 2. This Figure plots the population size of all trophic levels
%and the resource over time. Greater productivity (S=20) can sustain some 
%consumers, but the predators become extinct. 

S = 200;
N_init = [1; 0.25; 0.1; 4];
tf = 100;
[t n] = ode45('papa_prac7c',[0 tf],N_init);
figure
semilogy(t,n)
xlabel("Time")
ylabel("Population Size")
legend("trophic 1","trophic 2","trophic 3","resource")
title("S = 200") 

%----------------------------FIGURE LEGEND---------------------------------
%Figure 3. This Figure plots the population size of all trophic levels
%over time. When S=200, the productivity of the system sustains all trophic
%levels. This finding corresponds to the bottom-up effect, where the number
%of trophic levels that can be supported depends on the productivity of the
%system. The more productive the system is, the more trophic levels can
%persist.


%Now we simulate a case of overfishing of trophic level 3.
S=200; %the resource supply is high enough to support an increase of the 
%third trophic level when rare
N_init = [1; 0.25; 0; 4];
[tlo nlo] = ode45('papa_prac7c',[0 tf],N_init);
figure
semilogy(tlo,nlo)
xlabel("Time")
ylabel("Population Size")
legend("trophic 1","trophic 2","trophic 3","resource")
title("Overfishing of the third trophical level")

%----------------------------FIGURE LEGEND---------------------------------
%Figure 4. This Figure plots the population size of all trophic levels
%over time, in the absence of predators. The herbivores can increase when
%rare and invade.

%Next we simulate a case of high nutrient levels, and the predators are
%overfished.
S=600;
[thi nhi] = ode45('papa_prac7c',[0 tf],N_init);
figure
semilogy(thi,nhi)
xlabel("Time")
ylabel("Population Size")
legend("trophic 1","trophic 2","trophic 3","resource")
title("High nutrient levels")

%----------------------------FIGURE LEGEND---------------------------------
%Figure 5. This Figure shows that in a highly productive system with no
%predators, the herbivores continue to invade once established, and the
%basal species heads towards carrying capacity.

figure
hold on
plot(tlo,nlo(:,1))
plot(thi,nhi(:,1),"--")
xlabel("Time")
ylabel("Population Size")
legend("S=200","S=600")
title("Algae: Predators Fished Out")

%----------------------------FIGURE LEGEND---------------------------------
%Figure 6. This figure shows that regardless of the low or high nutrient levels,  
%the basal species will eventually decrease and settle. This is because trophic
%level 2 will continue to invade, in the absence of trophic level 3. 

%Next we simulate a case of overfishing of herbivores.
S=200
N_init = [1; 0; 0.1; 4];
[tlo nlo] = ode45('papa_prac7c',[0 tf],N_init);
figure
semilogy(tlo,nlo)
xlabel("Time")
ylabel("Population Size")
legend("trophic 1","trophic 2","trophic 3","resource")
title("Overfishing of the second trophical level")

%----------------------------FIGURE LEGEND---------------------------------
%Figure 7. This figure shows that in low productive system, in the absence
%of the herbivores, the population size of predators will decrease over time. 
%The basal species invade and take up all the productivity of the system.

S=600;
[thi nhi] = ode45('papa_prac7c',[0 tf],N_init);
figure
semilogy(thi,nhi)
xlabel("Time")
ylabel("Population Size")
legend("trophic 1","trophic 2","trophic 3","resource")
title("High nutrient levels")

%----------------------------FIGURE LEGEND---------------------------------
%Figure 8. This figure shows that in highly productive system, in the
%absence of herbivores the population of predators continues to head towards 
%extinction. This is because it is unable to make use of the added 
%productivity of the system, without the herbivores on which it preys on. 
%The population size of the basal species at equilibrium has increased.

figure
hold on
plot(tlo,nlo(:,1))
plot(thi,nhi(:,1),"--")
xlabel("Time")
ylabel("Population Size")
legend("S=200","S=600")
title("Algae: Herbivores Fished Out")
%----------------------------FIGURE LEGEND---------------------------------
%Figure 9. This figure compares compares the case of high and low nutrient
%levels in a system with no herbivores. The predator decreases exponentially,
%because it only feeds on herbivores. The basal species invades, because of
%the increased productivity in the absence of its predator.


%By looking at the equilibrium population sizes, using invasibility
%analysis, we find that B2 can increase when rare if 
%d2/c2*u2<(-a*d1+S*c1*u1)/d1*u1. The term in the left of the inequality
%is the equilibrium population of B1 in the absence of the predator. The
%term in the right of the inequality is the equilibrium population of B1 in
%the absence of the herbivore. By looking at Figure 6 and 9, we can see
%that algae population size in the absence of the predators is lower than
%the algae population size in the absence of the herbivore (150<600).
%Therefore, we can expect that B2 increases when rare, as seen in Figures 2
%5. 


%Noteworthy is the fact that in the absence of predators, the equilibrium
%abundance of the algal species does not change with the increase in
%nutrient supply, as seen in Figure 6. This is because in equilibrium 5,
%B1hat= d2/c2*u2, and is therefore independent from the nutrient supply.
%However, Figure 9 demonstrates how different productivity levels of the 
%trophic system will yield different equilibrium population sizes for 
%algal abundance. This is because at the second equilibrium, where 
%herbivores are absent, "B1" is dependent on "S" (B1hat = -(a*d1 -S*c1*u1)/(d1*u1)). 


%This pattern can be explained by the odd-even phenomenon. For food chains
%with even numbers of trophic levels, increases in productivity at the
%lowest level, will lead to increased biomass of the even-numbered trophic
%levels, but not at odd. 

%In our model when predators were removed from the system, an increase in
%the even trophic levels was observed (R and B1), but odd-numbered levels
%(B1) stayed the same. This is seen in figures 3 to 5. Conversely, figures
%7-9 show how in the absence of B2, even numbered trophic levels increase
%(B1), as the nutrient supply increases. These conclusions support the
%argument of a bottom up trophic cascade.
