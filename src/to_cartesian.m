function [X1, X2] = to_cartesian(theta, phi, l)
    X1 = l*[-sin(theta); cos(theta)];
    X2 = X1 - l*[sin(phi-theta); cos(phi-theta)];
end