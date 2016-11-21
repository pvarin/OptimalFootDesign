%%
thetaVec=-pi/2:0.1:pi/2;
phiVec=0:0.1:pi;
L=4;

for(i=1:length(phiVec))
    theta=0.2;%thetaVec(i);
    phi=phiVec(i);
    
    q=[theta, phi];
    plot_position(q,L);
    axis(1.1*[-L,L,-0.2,2*L])
    pause(0.005);
    
end




%%
clc
q=[pi/3;pi/7;pi/10;pi/11]
beta=0.1;
gamma=5*pi/180;
L=1;
% [FunHand, qdot]=dynamics_rigid(q,beta,gamma,L)


%%
tspan = [0 5];
y0 = 0;
[t,y] = ode45(FunHand, [0,5], [0,pi/4,0,-1]);
%[t,y] = ode45(@()dynamics_rigid, [0,5], [0,0,0,0]);
plot(t,y,'-o');

for(i=1:size(y,1))
    theta=y(i,1);%thetaVec(i);
    phi=y(i,2);
    
    q=[theta, phi];
    plot_position(q,L);
    axis(1.1*[-2*L,2*L,-2*L,2*L])
    pause(0.005);
    
end

%%

function dydt = vdp1(t,y)
%VDP1  Evaluate the van der Pol ODEs for mu = 1
%
%   See also ODE113, ODE23, ODE45.

%   Jacek Kierzenka and Lawrence F. Shampine
%   Copyright 1984-2014 The MathWorks, Inc.

dydt = [y(2); (1-y(1)^2)*y(2)-y(1)];