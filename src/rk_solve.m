function [T, Q] = rk_solve(derivs,tmax, h, q0, collision_func, dist_to_ground_func)
%
% [T, Q] = rk_solve(derivs, h, q0, collision_func, dist_to_ground_func)
%
% Inputs:   derivs = function handle of derivative function
%           tmax   = maximum time to simulate (assuming no collisions are found) 
%           h      = time step
%           q0     = initial state condions
%
%           collision_func      = function handle for colision detection
%           dist_to_ground_func = function handle for distance to ground
%
%           *** NOTE:   All function handles (derivs, collision_func,
%                       distance_to_ground) must be in terms of
%                       ONLY the states (q).
%
% Outputs:  T =  Time vector
%           Q =  State trajectory vector (there are length(t) rows,
%                each with a state vactor in them)

%BEGIN PROGRAM ===========================================================

    % start with a fixed timestep
    N = ceil(tmax/h);
    T = 0:h:h*(N-1);
    
    Q = zeros(length(q0),N);
    Q(:,1) = q0;
    
    if (collision_func(q0) < 0)
        error('Initial condition violates the collision condition');
    end
    
    % integrate until the collition function is violated
    i = 1;
    while collision_func(Q(:,i)) ~= 1
        Q(:,i+1) = rk_step(derivs, Q(:,i),h);
        i=i+1;
    end
    
    if i==1
       error('Bad initial condition: collision detected on first timestep'); 
    end
    
    % iterate until the collision function is within tolerence
    % (note: there is an assumption that the collision function is continuous)
    while abs(dist_to_ground_func(Q(:,i))) > 1e-6
        if dist_to_ground_func(Q(:,i)) > 0
            h = h+h/2;
        else
            h = h-h/2;
        end
        Q(:,i) = rk_step(derivs, Q(:,i-1),h);
    end
    
    T(i) = T(i-1) + h;
    
    % remove excess vector
    T = T(1:i);
    Q = Q(:,1:i);
end