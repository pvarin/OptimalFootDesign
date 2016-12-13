clc;
close all;

%Define Constants and Initial Conditions
params.m = 1;
params.M = 10;
params.beta = 0.1;
params.L = 1;
% params.gamma = 2.84*pi/180;
params.gamma = 0.0043633;
params.a=0.5;
params.b=0.5;

Theta0=pi/10;
Phi0=2*Theta0;

gamma_mean = 0.0043633;
gamma_std = 0.001;
next_gamma = random_slope(gamma_mean, gamma_std);

% q0=[Theta0;Phi0;-1.0;-0.5];
q0 = [0.15708;0.29671;-0.55556;0];
for i=1:50
    disp(strcat('Starting Step #',num2str(i)))

    % choose a random slope
    params.gamma = next_gamma;
    next_gamma = random_slope(gamma_mean, gamma_std);
    [T,Q, info] = solve_one_step_rough_terrain(q0,params,next_gamma);
    q0 = Q(:,end);
    
    % visuals
    plot_phase_diagrams(Q,T)
    animate_compass_gait(T,Q,params);
    
    if (info ~= 1)
        msg = get_error_message(info);
        disp(msg);
        break
    end
end