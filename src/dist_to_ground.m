function dist=dist_to_ground_level(q,L)

[X1, X2] = to_cartesian(q(1), (q(2)), L);
dist=(X2(2));

end