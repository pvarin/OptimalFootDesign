function dist=dist_to_ground_level(q,L,on)

[X1, X2] = to_cartesian(q, L);


if on==0
    dist=1;
else
dist=(X2(2));
end

end