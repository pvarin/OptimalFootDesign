function [X1, X2] = to_cartesian(q, L)
    theta=q(1);
    phi=q(2);
    d_theta=q(3);
    d_phi=q(4);

    X1 = L*[-sin(theta); cos(theta); -cos(theta)*d_theta; -sin(theta)*d_theta];
    X2 = X1 - L*[sin(phi-theta); cos(phi-theta); cos(phi-theta)*(d_phi-d_theta); -sin(phi-theta)*(d_phi-d_theta)];
end