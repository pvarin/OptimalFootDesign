function [T, Q, info] = rk_solve(derivs, tmax, h, q0, collision_func, dist_to_ground_func, failure_func)
%
% [T, Q, info] = rk_solve(derivs, h, q0, collision_func, dist_to_ground_func, failure_func)
%
% Inputs:   derivs = function handle of derivative function
%           tmax   = maximum time to simulate (assuming no collisions are found) 
%           h      = time step
%           q0     = initial state condions
%
%           collision_func      = function handle for colision detection
%           dist_to_ground_func = function handle for distance to ground
%           failure_func        = function handle that signals the failure
%                                 condition
%
%           *** NOTE:   All function handles (derivs, collision_func,
%                       distance_to_ground, failure_func) must be in terms of
%                       ONLY the states (q).
%
% Outputs:  T    =  Time vector
%           Q    =  State trajectory vector (there are length(t) rows,
%                   each with a state vactor in them)
%           info =  Integer specifying success or failure
%                   -1 -> Failed to detect a collision
%                    1 -> Success
%                   >1 -> User defined failures based on failure_func

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
    while collision_func(Q(:,i)) ~= 1 && i<N
        Q(:,i+1) = rk_step(derivs, Q(:,i),h);
        i=i+1;
        
        % check for the robot tipping over backwards
        info = failure_func(Q(:,i));
        if info ~= 1
            Q = Q(:,1:i);
            T = T(1:i);
            return
        end
    end
    
    % make sure that the initial condition was satisfied
    if i==1
        error('Bad initial condition: collision detected on first timestep'); 
    end
    
    % make sure a collision was detected
    if (collision_func(Q(:,i)) ~= 1)
        info = -1;
        return
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