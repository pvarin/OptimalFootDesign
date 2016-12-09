function info = rigid_failure(q)
% function info = rigid_failure(q)
%
% Inputs    q = the state of the compass gait
%
% Outputs   info = the status of the simulation
%                  1 -> all is good
%                  2 -> the robot is tipping backward
    info = 1;
    if (q(3) > 0)
        info = 2;
    end
end