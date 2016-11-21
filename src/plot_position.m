function plot_position(q)
% Inputs:  q = The state vector [theta, phi]
% Outputs: Plot of the 

    if length(q)==2  
    [X1, X2] = to_cartesian(q(1),q(2),1);
    
    figure(1)
    plot([0,X1(1),X2(1)],[0,X1(2),X2(2)],'-o')
    
    else
    end
end