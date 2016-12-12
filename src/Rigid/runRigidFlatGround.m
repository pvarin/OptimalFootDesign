clc;
close all;

%Define Constants and Initial Conditions
params.m = 1;
params.M = 10;
params.beta = 0.1;
params.L = 1;
params.gamma = 2.84*pi/180;
params.a=0.5;
params.b=0.5;

Theta0=pi/10;
Phi0=2*Theta0;


q0=[Theta0;Phi0;-1.0;-0.5];
for i=1:50
    disp(strcat('Starting Step #',num2str(i)))

    [T,Q, info] = solve_one_step_level_ground(q0,params);
    q0 = Q(:,end);
    
    %Plot the states vs. time
    ScreenSize= get( groot, 'Screensize' );
    ScreenW=ScreenSize(3)-1;
    ScreenH=ScreenSize(4)-1;
    
    h1 = figure(2);
    h1.Position=[ScreenW*.5,50,ScreenW*.5-10,ScreenH*.5-100];
    plot(T,Q,'-o');
            
    %Plot the phase portraits
    h2 = figure(20);
    h2.Position=[ScreenW*.5,ScreenH*.5+30,ScreenW*.5-10,ScreenH*.5-110];
    
    subplot(2,1,1); hold on;
    plot(Q(1,:),Q(3,:),'-o');
    subplot(2,1,2); hold on;
    plot(Q(2,:),Q(4,:),'-o');

    animate_compass_gait(T,Q,params);
    %animate_compass_gait(T(end),Q(:,end),params);
    
    if (info ~= 1)
        msg = get_error_message(info);
        disp(msg);
        break
    end
end