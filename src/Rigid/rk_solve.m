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
%                   -2 -> Bad initial condition
%                   -1 -> Failed to detect a collision
%                    1 -> Success
%                   >1 -> User defined failures based on failure_func

%BEGIN PROGRAM ===========================================================

    % define the number of consecutive failures
    max_failure = 5;

    % start with a fixed timestep
    N = ceil(tmax/h) + max_failure;
    T = 0:h:h*(N-1);
    
    Q = zeros(length(q0),N);
    Q(:,1) = q0;
    
    if (collision_func(q0) < 0)
        error('Initial condition violates the collision condition');
    end
    
    % integrate until the collition function is violated
    i = 1;
    num_consecutive_failures = 0;
    while (num_consecutive_failures < max_failure && i<N)
        if collision_func(Q(:,i)) || (failure_func(Q(:,i),1) ~= 1)
            num_consecutive_failures = num_consecutive_failures + 1;
        else
            num_consecutive_failures = 0;
        end
        
        Q(:,i+1) = rk_step(derivs, Q(:,i),h);
        i=i+1;
    end
    
    i = i-num_consecutive_failures;
    
    % check if the initial condition was bad
    if i==1
        Q = Q(:,1);
        T = T(1);
        info = -2;
        return
    end
    
    % if failed set the failure flag
    info = failure_func(Q(:,i),1);
    if (info ~= 1)
        T = T(1:i);
        Q = Q(:,1:i);
        return
    end
    
    % make sure a collision was detected
    if (collision_func(Q(:,i)) ~= 1)
        info = -1;
        return
    end
    
    % binary search until the collision function is within tolerence or the
    % change in timestep is within tolerance
    dh = h/2;
    while (abs(dist_to_ground_func(Q(:,i))) > 1e-6) || (dh > 1e-6)
        if dist_to_ground_func(Q(:,i)) > 0
            h = h+dh;
        else
            h = h-dh;
        end
        dh = dh/2;
        Q(:,i) = rk_step(derivs, Q(:,i-1),h);
    end
    
    T(i) = T(i-1) + h;
    
    % if failed set the failure flag
    info = failure_func(Q(:,i),0);
    if (info ~= 1)
        T = T(1:i);
        Q = Q(:,1:i);
        return
    end
    
    % remove excess vector
    T = T(1:i);
    Q = Q(:,1:i);
end