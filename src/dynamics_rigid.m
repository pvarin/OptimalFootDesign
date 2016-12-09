function [qdot]=dynamics_rigid(q,params)
% I'm defining q here to be [theta, phi, thetadot, phidot]
% 
% Inputs:   q     = States
%           params= A parameter object containing (L, gamma, M, m)

    % unpack the state;
    theta  = q(1);
    phi    = q(2);
    d_theta = q(3);
    d_phi   = q(4);
    
    % unpack the parameters
    beta = params.m/params.M;
    gamma = params.gamma;
    L = params.L;
    g=9.81; %[m/s^2] acceleration due to gravity
    
    % compute the derivatives
    thetaDD = (1/(1+2*beta*(1-cos(phi))-beta*(1-cos(phi))))*...
              (beta*sin(phi)*(d_phi^2-2*d_theta*d_phi)...
                  - (beta*g/L)*(sin(theta-phi-gamma) - sin(theta-gamma))...
                  + (g/L)*sin(theta-gamma));
            
    phiDD   = (1/(beta*(1-cos(phi))-beta))*...
              (-beta*d_theta^2*sin(phi) - (beta*g/L)*sin(theta-phi-gamma));
    

    qdot = [d_theta; d_phi; thetaDD; phiDD];
end