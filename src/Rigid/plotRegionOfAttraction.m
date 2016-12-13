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

M = 250;
N = 250;
NumSteps = zeros(M,N);

% theta = linspace(0,pi/10,N);
% phi = 0.29671;
% d_theta = linspace(-1,0,M);
% d_phi = -0.4;


theta = linspace(0.145,.16,N);
phi = 0.3103;
d_theta = -0.5498;
d_phi = linspace(0.4,-0.4,M);

tic;
for i=1:N
    i
    toc
    for j=1:M
%         q0 = [theta(i); phi; d_theta(j); d_phi];
        q0 = [theta(i); phi; d_theta; d_phi(j)];
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

pcolor(theta, d_phi, NumSteps)
xlabel('\theta')
ylabel('d\phi/dt')