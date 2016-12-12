clc;
close all;

%Define Constants and Initial Conditions
params.m = 1;
params.M = 10;
%params.beta = 0.1;
params.L = 1;
params.gamma = 2.5*pi/180;

q0=[.05;pi/10.5;pi/5.5;-.5;-1;-0.5];

for i=1:50
    disp(strcat('Starting Step #',num2str(i)))

    [T,Q, info] = solve_one_step_level_ground(q0,params);
    q0 = Q(:,end);
    
    %Plot the states vs. time
    figure(2)
    plot(T,Q,'-o');
            
    %Plot the phase portraits
    figure(20);
    subplot(2,1,1); hold on;
    plot(Q(1,:),Q(3,:),'-o');
    subplot(2,1,2); hold on;
    plot(Q(2,:),Q(4,:),'-o');

    animate_compass_gait(T,Q,params);
    
    if (info ~= 1)
        if (info == -1)
            disp('Failure: integration took more than allotted time')
        elseif (info == 2)
            disp('Failure: robot started tipping backwards')
        else
            disp('Failure: unknown failure')% this should never happen
        end
        break
    end
end