function plot_position(q)
    % q is the state vector [theta, phi]
    [X1, X2] = to_cartesian(q(1),q(2),1);
    
    
    plot([0,X1(1),X2(1)],[0,X1(2),X2(2)],'-o')
end