function [T, Q, info] = solve_one_step_rough_terrain(q0,params,gamma_next,varargin)
% function [T, Q, info] = solve_level_ground(q0,params,varargin)
%
% Solves the initial value problem for a compass gait on level ground.
% Stops integration when the foot hits the ground and performs the
% appropriate step transition so that the final condition of this function
% can be immediately used as the initial condition for the next step.
% 
% Inputs:   q0      = initial condition
%           params  = system parameters
%           options = (optional) integration parameters
%                      options.tmax = maximum time to simulate
%                      options.h    = size of timestep
%
% Outputs:  T    = A time vector specifying the times at the knot points
%           Q    = A state trajectory specifying the state at each of the
%                  times in the time vector
%           info = Integer specifying success or failure (see rk_solve.m)

    % Set default parameters
    options.tmax = 5;
    options.h = 0.01;
    
    % Unpack parameters from options struct
    if nargin > 2
        opts = varargin{1};
        if isfield(opts,'tmax')
            options.tmax = opts.tmax;
        end
        if isfield(opts,'h')
            options.h = opts.h;
        end
    end
    
    dynamics       = @(q) dynamics_rigid(q,params);   
    collision      = @(q) collision_rigid_level(q);
    dist_to_ground = @(q) dist_to_ground_level(q,params);
    failure_func   = @(q,solving) rigid_failure(q,params,solving);
    
    [T, Q, info] = rk_solve(dynamics, options.tmax, options.h, q0, collision, dist_to_ground, failure_func);
    if (info ~= 1)
        return
    end
    
    % make the transition at the end of the step
    theta = Q(1,end);
    H=[ -1, 0,                             0, 0
        -2, 0,                             0, 0
         0, 0,                  cos(2*theta), 0
         0, 0, cos(2*theta)*(1-cos(2*theta)), 0];
    
    Q(:,end) = H*Q(:,end) + [params.gamma - gamma_next; 0; 0; 0];
end