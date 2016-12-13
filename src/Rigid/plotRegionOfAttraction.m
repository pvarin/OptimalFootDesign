%Define Constants and Initial Conditions
params.m = 1;
params.M = 10;
params.beta = 0.1;
params.gamma = 0.0043633;
params.L = 1;
params.a=0.5;
params.b=0.5;

Theta0=pi/10;
Phi0=2*Theta0;

% Beware with N=M=250 this takes ~18 minutes to run
M = 250;
N = 250;
NumSteps = zeros(M,N);

% fixed point
% q =
%     0.1552
%     0.3103
%    -0.5498
%    -0.0263


% theta = linspace(0.145,.16,N);
% phi = 0.3103;
% d_theta = -0.5498;
% d_phi = linspace(0.4,-0.4,M);

theta = 0.1552;
phi = linspace(0.225,0.46,N);
d_theta = linspace(-0.54,-0.58,M);
d_phi = -0.0263;


tic;
for i=1:N
    i
    toc
    for j=1:M
%         q0 = [theta(i); phi; d_theta; d_phi(j)];
        q0 = [theta; phi(i); d_theta(j); d_phi];
        for k=1:20
            % solve one timestep
            [T,Q, info] = solve_one_step_level_ground(q0,params);
            q0 = Q(:,end);
            if (info ~= 1)
                NumSteps(j,i) = k-1;
                break
            elseif (k==20)
                NumSteps(j,i) = k;
                q0;
            end
        end
    end
end

% pcolor(theta, d_phi, NumSteps); hold on
% plot(0.1552, -0.0263,'k+','MarkerSize',20,'LineWidth',2)
% xlabel('\theta','FontSize',20)
% ylabel('d\phi/dt','FontSize',20)

pcolor(phi, d_theta, NumSteps); hold on
plot(0.3103,-0.5498,'k+','MarkerSize',20,'LineWidth',2)
xlabel('\phi','FontSize',20)
ylabel('d\theta/dt','FontSize',20)

set(gca,'FontSize',16)
h = colorbar;
ylabel(h,'# steps to failure','FontSize',20)
shading flat