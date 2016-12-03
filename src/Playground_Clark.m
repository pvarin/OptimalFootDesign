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
q0=[pi/3;pi/7;pi/10;pi/11]
beta=0.1;
gamma=2.5*pi/180;
L=1;

tspan = [0 5];
y0=[pi/10;pi/5.5;-1;-0.5];
%[FunHand, qdot]=dynamics_rigid(q0,beta,gamma,L);

 g=9.81; %[m/s^2] acceleration due to gravity
FunHand = @(t,q)[ q(3);...
                    q(4);...
                   (1/(1+2*beta*(1-cos(q(2)))-beta*(1-cos(q(2)))))*...
                   (beta*sin(q(2))*(q(4)^2-2*q(3)*q(4))...
                      - (beta*g/L)*(sin(q(1)-q(2)-gamma) - sin(q(1)-gamma))...
                      + (g/L)*sin(q(1)-gamma));...
                    (1/(beta*(1-cos(q(2)))-beta))*...
                    (-beta*q(3)^2*sin(q(2)) - (beta*g/L)*sin(q(1)-q(2)-gamma))];
       




for i=1:50

[t,y] = ode45(FunHand, [0:0.01:10], y0);
%[t,y] = ode45(@()dynamics_rigid, [0,5], [0,0,0,0]);
figure(2)
plot(t,y,'-o');
figure(20);
subplot(2,1,1);
plot(y(:,1),y(:,3),'-o');
subplot(2,1,2);
plot(y(:,2),y(:,4),'-o');

figure(21);
plot(t,y(:,1),'b-',t,y(:,2)/2,'r-');


figure(3)
for(j=1:size(y,1))
    theta=y(j,1);%thetaVec(i);
    phi=y(j,2);
    
    q=[theta; phi];
    plot_position(q,L,gamma);
    %axis(1.1*[-L,L,-L/5,L])
    pause(0.005);
    
    [X1,X2]=to_cartesian(q,L);
    
    dist_to_ground_level(q,L,1)
    
%     if(t(j)>2)
%         
%         break
%     end
    t(j)
    if (2*theta<=phi && phi<0)
         q 
         
        t(j)
        inc=j;
        y(j,:);
        H=[ -1,0,0,0
            -2,0,0,0
            0,0,cos(2*theta), 0
            0,0,cos(2*theta)*(1-cos(2*theta)),0];
        y0=H*y(j,:)'
        
       
        
        
        break 
    end
    
end

end
