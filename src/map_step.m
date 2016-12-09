function qf = map_step(q0,params)
    [T, Q] = solve_one_step_level_ground(q0,params);
    qf = Q(:,end);
end