clc;
close all;

%Define Constants and Initial Conditions
params.m = 5;
params.M = 10;
params.beta = 0.1;
params.L = 1;
params.gamma = 0.03*pi/180;
params.a=0.5;
params.b=0.5;

Theta0=pi/15;
Phi0=2*Theta0;

best_steps = 0;
best_init = [0;0;0;0];
best_gamma = 0;

gammas = linspace(.25*(pi/180),5*(pi/180),10);
thetas = linspace(pi/20,pi/4,10);
phis = linspace(pi/20,pi/4,10);
dthetas = linspace(0,-1,10);
dphis = linspace(0,-1,10);
%q0=[params.gamma;0;-0.4;-2.4];
for sweep1 = 1:10
    for sweep2 = 1:10
        for sweep3 = 1:10
            for sweep4 = 1:10
                for sweep5 = 1:10
params.gamma = gammas(sweep5);                  
q0=[thetas(sweep2);phis(sweep3);dthetas(sweep4);dphis(sweep1)];
q0_save = q0;
for i=1:50
   % disp(strcat('Starting Step #',num2str(i)))

    [T,Q, info] = solve_one_step_level_ground(q0,params);
    q0 = Q(:,end);
    
    %Plot the states vs. time
%     ScreenSize= get( groot, 'Screensize' );
%     ScreenW=ScreenSize(3)-1;
%     ScreenH=ScreenSize(4)-1;
    
  %  h1 = figure(2);
   % h1.Position=[ScreenW*.5,50,ScreenW*.5-10,ScreenH*.5-100];
    %plot(T,Q,'-o');
            
    %Plot the phase portraits
   % h2 = figure(20);
   % h2.Position=[ScreenW*.5,ScreenH*.5+30,ScreenW*.5-10,ScreenH*.5-110];
    
%     subplot(2,1,1); hold on;
%     plot(Q(1,:),Q(3,:),'-o');
%     subplot(2,1,2); hold on;
%     plot(Q(2,:),Q(4,:),'-o');

%     animate_compass_gait(T,Q,params);
    %animate_compass_gait(T(end),Q(:,end),params);
    
    if (info ~= 1)
        if (info == -1)
            %disp('Failure: integration took more than allotted time')
        elseif (info == 2)
            %disp('Failure: robot started tipping backwards')
        elseif (info == 3)
            %disp('Failure: robot started tipping forward')
        else
            %disp('Failure: unknown failure')% this should never happen
        end
        break
    end
end
if i > best_steps
    best_steps = i;
    best_init = q0_save;
    best_gamma = params.gamma;
    disp(strcat('Best # of steps is_',num2str(best_steps)))
    disp('For initial conditions')
    disp(strcat('theta(0) = ',num2str(best_init(1))))
    disp(strcat('phi(0) = ',num2str(best_init(2))))
    disp(strcat('d_theta(0) = ',num2str(best_init(3))))
    disp(strcat('d_phi(0) = ',num2str(best_init(4))))
    disp(strcat('gamma = ',num2str(best_gamma)))
end

    
                end
            end
        end
    end
end
