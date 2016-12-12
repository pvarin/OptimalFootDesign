function info = rigid_failure(q,params,solving)
% function info = rigid_failure(q,params,solving)
%
% Inputs    q = the state of the compass gait
%           params = the compass gait parameters
%           solving = a flag to determine if the simulation has finished or
%               not
%
% Outputs   info = the status of the simulation
%                  1 -> all is good
%                  2 -> body collided with ground
%                  3 -> started falling backwards
%                  4 -> started falling forward

    info = 1;
    
    [X1, ~] = to_cartesian(q, params.L);
    
    if X1(2) < 0
        info = 2;
        return
    end
    
    % check for failures at the end of the simulation
    if ~solving
        if abs(q(2)) < 1e-3
            info = 4;
            return 
        end
    end
%     if q(4) > 0
%         info = 3;
%         return
%     end
end
    
%     %Test for tipping backward
%         if (q(3) > 0)
%             info = 2;
%         end
%     
%     %Test for tipping forward
%     
%     if solving==0
%         [X1,X2]=to_cartesian(q, L);
%         if abs(X1(1))> abs(X2(1))
%             info = 3;
%         end
%     end
% end