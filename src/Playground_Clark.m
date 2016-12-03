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
gamma=2.5*pi/180;
L=1;


%%
tspan = [0 5];
y0=[-pi/100;pi/40;0;-0.2];
%[FunHand, qdot]=dynamics_rigid(q,beta,gamma,L);

for i=1:2

[t,y] = ode45(FunHand, [0:0.005:5], y0);
%[t,y] = ode45(@()dynamics_rigid, [0,5], [0,0,0,0]);
plot(t,y,'-o');
figure(20);
subplot(2,1,1);
plot(y(:,1),y(:,3),'-o');
subplot(2,1,2);
plot(y(:,2),y(:,4),'-o');


figure(2)
for(i=1:size(y,1))
    theta=y(i,1);%thetaVec(i);
    phi=y(i,2);
    
    q=[theta; phi];
    plot_position(q,L,gamma);
    %axis(1.1*[-2*L,2*L,-2*L,2*L])
    pause(0.05);
    
    [X1,X2]=to_cartesian(q,L);
    
    if (dist_to_ground_level(q,L,1)<=0)&&((X2(1)>0.1)||(X2(1)<-0.1))
                
        t(i);
        inc=i;
        H=[ -1,0,0,0
            -2,0,0,0
            0,0,cos(2*theta), 0
            0,0,cos(2*theta)*(1-cos(2*theta)),0];
        y0=H*y(i,:)'
        
        
        break 
    end
    
end

end
