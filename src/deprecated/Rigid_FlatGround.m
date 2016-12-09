clc

%Define Constants and Initial Conditions
params.m = 1;
params.M = 10;
params.beta = 0.1;
params.L = 1;
params.gamma = 2.5*pi/180;

beta     = 0.1;
gammaDeg = 2.5; %Ramp Angle (in degrees)
L=1;

tmax = 5;
h=0.01;
q0=[pi/10.5;pi/5.5;-1;-0.5];
    
%Calculate gamma in radians 
gamma=2.5 *pi/180; % The ramp angle (in rad) 
                
%Define the dist_to_ground, dynaics, and collision functions
%in terms of ONLY q
dynamics       = @(q) dynamics_rigid(q,params);   
collision      = @(q) collision_rigid_level(q);
dist_to_ground = @(q) dist_to_ground_level(q,params);
  
    
%Simulate walking
for i=1:50
    disp(strcat('Starting Step #',num2str(i)))
    %Run the Runge-Kutta Function
    [T,Q] = rk_solve(dynamics, tmax, h, q0,collision ,dist_to_ground);
    [T,Q] = solve_one_step_level_ground(q0,params);
    
    %Plot the states vs. time
    figure(2)
    plot(T,Q,'-o');
            
    %Plot the phase portraits
    figure(20);
    subplot(2,1,1);
    plot(Q(:,1),Q(:,3),'-o');
    subplot(2,1,2);
    plot(Q(:,2),Q(:,4),'-o');


    %Animate the walking
    figure(3)
    for j=1:size(Q,2)
        theta=Q(1,j);%thetaVec(i);
        phi=Q(2,j);

        q=[theta; phi];
        plot_position(q,L,gamma);
        %axis(1.1*[-L,L,-L/5,L])
        pause(0.005);
    end

        
    %Switch the Legs
    inc=j;
    %Q(:,j);
    disp('State Before foot Switch:')
    Q(:,j)

    H=[ -1,0,0,0
        -2,0,0,0
        0,0,cos(2*theta), 0
        0,0,cos(2*theta)*(1-cos(2*theta)),0];
    q0=H*Q(:,j);
    disp('State After foot Switch:')
        
end
