function [X1, X2] = to_cartesian(theta, phi, L)
    X1 = L*[-sin(theta); cos(theta)];
    X2 = X1 - L*[sin(phi-theta); cos(phi-theta)];
end