function [FunHand, qdot]=dynamics_rigid(q,beta,gamma,L)
% I'm defining q here to be [theta, phi, thetadot, phidot]
% 
% Inputs:   q     = States
%           beta  = Ratio of foot mass to body mass (m/M)
%           gamma = Ramp angle (rad)
%           L     = Length of the legs

    g=9.81; %[m/s^2] acceleration due to gravity
    
    theta  = q(1);
    phi    = q(2);
    thetaD = q(3);
    phiD   = q(4);
    
    
    thetaDD = (1/(1+2*beta*(1-cos(phi))-beta*(1-cos(phi))))*...
              (beta*sin(phi)*(phiD^2-2*thetaD*phiD)...
                  - (beta*g/L)*(sin(theta-phi-gamma) - sin(theta-gamma))...
                  + (g/L)*sin(theta-gamma));
            
    phiDD   = (1/(beta*(1-cos(phi))-beta))*...
              (-beta*thetaD^2*sin(phi) - (beta*g/L)*sin(theta-phi-gamma));
    

    qdot = [thetaD; phiD; thetaDD; phiDD];
    
    
    
    %Function Handle
    
    FunHand = @(t,q)[ q(3);...
                    q(4);...
                   (1/(1+2*beta*(1-cos(q(2)))-beta*(1-cos(q(2)))))*...
                   (beta*sin(q(2))*(q(4)^2-2*q(3)*q(4))...
                      - (beta*g/L)*(sin(q(1)-q(2)-gamma) - sin(q(1)-gamma))...
                      + (g/L)*sin(q(1)-gamma));...
                    (1/(beta*(1-cos(q(2)))-beta))*...
                    (-beta*q(3)^2*sin(q(2)) - (beta*g/L)*sin(q(1)-q(2)-gamma))];
       


end