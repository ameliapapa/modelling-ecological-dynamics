%Title: papa_prac7c.m
%Author: Amelia Papa 
%Subject: BS5260 Modelling Ecological Dynamics
%Practical #6 Trohic Dynamics and Ecosystem Collapse
%Tutor: Alfonso Ruiz Moreno
%Date: 31/05/2019
%-------------------------------------------------------------------------
%This script projects a numerical analysis of the trophic dynamics model.

function dndt = papa_prac7c(t,n) 
global S a u1 c1 d1 u2 c2 d2 u3 c3 d3 
dndt(1,1) = c1*u1*n(4)*n(1)-d1*n(1)-u2*n(1)*n(2);
dndt(2,1) = c2*u2*n(1)*n(2)-d2*n(2)-u3*n(2)*n(3);
dndt(3,1) = c3*u3*n(2)*n(3)-d3*n(3);
dndt(4,1) = S-a*n(4)-u1*n(4)*n(1); 
end

