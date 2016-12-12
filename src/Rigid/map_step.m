function qf = map_step(q0,params)
    % TODO: discretize the states and make a special failure state, then
    % run the dynamics forward and return the state bucket that the final
    % answer falls into
    
    [T, Q, info] = solve_one_step_level_ground(q0,params);
    qf = Q(:,end);
    
    % compute the bucket from qf and info
end