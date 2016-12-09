function dist=dist_to_ground_level(q,params)
    [~, X2] = to_cartesian(q, params.L);
    dist=(X2(2));
end