function [T, Q] = rk_solve(derivs, h, q0, collision_func)
    % start with a fixed timestep
    N = 100;
    T = 0:h:h*(N-1);
    
    Q = zeros(length(q0),N);
    Q(:,1) = q0;
    
    if (collision_func(q0) < 0)
        error('Initial condition violates the collision condition');
    end
    
    % integrate until the collition function is violated
    i = 1;
    while collision_func(Q(:,i)) > 0
        Q(:,i+1) = rk_step(derivs, Q(:,i),h);
        i=i+1;
    end
    
    % iterate until the collision function is within tolerence
    % (note: there is an assumption that the collision function is continuous)
    while abs(collision_func(Q(:,i))) > 1e-6
        if collision_func(Q(:,i)) > 0
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