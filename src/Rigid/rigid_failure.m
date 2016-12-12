function info = rigid_failure(q,L,solving)
% function info = rigid_failure(q,L)
%
% Inputs    q = the state of the compass gait
%           L = length of the legs
%
% Outputs   info = the status of the simulation
%                  1 -> all is good
%                  2 -> the robot is tipping backward
%                  3 -> the robot is tipping forward
    info = 1;
    
    %Test for tipping backward
        if (q(3) > 0)
            info = 2;
        end
    
    %Test for tipping forward
    
    if solving==0
        [X1,X2]=to_cartesian(q, L);
        if abs(X1(1))> abs(X2(1))
            info = 3;
        end
    end
end