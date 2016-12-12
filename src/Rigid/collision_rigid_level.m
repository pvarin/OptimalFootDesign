function [collision] = collision_rigid_level(q)
% [collision] = collision_rigid_level(q)
%
% Inputs:   q = States
%
% Outputs:  collision (boolean, 1 = collision);


 collision = (2*q(1)<=q(2) && q(2)<0);


end

