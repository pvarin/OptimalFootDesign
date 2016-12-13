clc;
close all;

%Define Constants and Initial Conditions
params.m = 1;
params.M = 20;
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

Stable_pts = zeros(1,5);
All_pts = zeros(1,3);
Steps = zeros(150,150);
stables_pts_count = 1;

% gammas = linspace(.25*(pi/180),2*(pi/180),10);
% thetas = linspace(pi/20,pi/4,10);
% phis = linspace(pi/20,pi/4,10);
% dthetas = linspace(0,-1,10);
% dphis = linspace(0,-1,10);

%gammas = linspace(.25*(pi/180),2*(pi/180),10);
gammas = .25*pi/180;
thetas = linspace(pi/31,pi/10,150);
%phis = linspace(pi/16,pi/12,20);
dthetas = linspace(-.99,-.34,150);
%dphis = linspace(0,-.01,20);
dphis = 0;
[X,Y] = meshgrid(thetas,dthetas);
%q0=[params.gamma;0;-0.4;-2.4];
for sweep1 = 1:150
    for sweep2 = 1:1
        for sweep3 = 1:150
            for sweep4 = 1:1
                for sweep5 = 1:1
params.gamma = gammas(sweep5);                  
q0=[thetas(sweep1);2*thetas(sweep1);dthetas(sweep3);dphis(sweep4)];
q0_save = q0;
for i=1:30
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
        All_pts = [All_pts;q0_save(1),q0_save(3),i];
        Steps(sweep1,sweep3) = i;
        break
    end
end
if i == 30
   Stable_pts =  [Stable_pts;q0_save',params.gamma];
   stables_pts_count = stables_pts_count+1
end
if (i > best_steps) || (i == 30)
    best_steps = i;
    best_init = q0_save;
    best_gamma = params.gamma;
%     disp(strcat('Best # of steps is_',num2str(best_steps)))
%     disp('For initial conditions')
%     disp(strcat('theta(0) = ',num2str(best_init(1))))
%     disp(strcat('phi(0) = ',num2str(best_init(2))))
%     disp(strcat('d_theta(0) = ',num2str(best_init(3))))
%     disp(strcat('d_phi(0) = ',num2str(best_init(4))))
%     disp(strcat('gamma = ',num2str(best_gamma)))
    if i == 30
       best_steps = 0; 
    end
end
All_pts = [All_pts;q0_save(1),q0_save(3),i];
Steps(sweep1,sweep3) = i;
%disp('Running still')
    
                end
            end
        end
    end
end
%pcolor(Stable_pts(2:stables_pts_count,1),Stable_pts(2:stables_pts_count,2),Stable_pts(2:stables_pts_count,3));
%surf(All_pts(:,1),All_pts(:,2),All_pts(:,3))
pcolor(Steps)
shading flat