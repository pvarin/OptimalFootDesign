function [qdot]=dynamics_rigid_NEW(q,params)
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
    a=params.a;
    b=params.b;
    m=params.m;
    M=params.M;
    
    %convert to the correct angles
        theta1 = theta +pi/2 -gamma;   
        theta2 = pi-phi;
        d_theta1 = d_theta;
        d_theta2 = -d_phi;
        
        Tau=0;
        
    %define a ton of redundant constants
        m1=m+1/2*M;
        m2=m1;
        l1=L;
        l2=l1;
        lc1=L-b*m/m1;
        lc2=L-lc1;
        I1=m*(b-lc2)^2 + 1/2*M*lc2^2;
        I2=I1;
    
    %Define a bunch of constants
        d_11=m1*lc1^2 + m2*(l1^2+ lc2^2 + 2*l1*lc2*cos(theta2)) + I1 + I2;
        
        d_12=m2*(lc2^2 + l1*lc2*cos(theta2)) + I2;
        
        d_22=m2*lc2^2 + I2;
        
        d_21=d_12;
        
    %this had ambiguous contents of sine
        h_1 = -m2*l1*lc2*sin(theta2)*d_theta2^2 - 2*m2*l1*lc2*sin(theta2)*d_theta2*d_theta1;
        h_2 = m2*l1*lc2*sin(theta2)*d_theta1^2;
        
        p_1 = (m1*lc1 + m2*l1)*g*cos(theta1) + m2*lc2*g*cos(theta1+ theta2);
        p_2 = m2*lc2*g*cos(theta1 + theta2);
        
        nu_1= m2*l1*lc2*sin(theta2)*d_theta2^2 + 2*m2*l1*lc2*sin(theta2)*d_theta2*d_theta1 +...
              m2*lc2*g*cos(theta1 + theta2) + (m1*lc1 + m2*l1)*g*cos(theta1);
        
        nu_2=-m2*l1*lc2*sin(theta2)*d_theta1^2 - m2*lc2*g*cos(theta1 + theta2) + Tau;
        
                
    % compute the derivatives
    d2_theta = (d_22*nu_1-d_12*nu_2)/(d_11*d_22 - d_12^2);
            
    d2_phi   = -(-d_12*nu_1 + d_11*nu_2)/(d_11*d_22 - d_12^2);
      

    qdot = [d_theta; d_phi; d2_theta; d2_phi];
end


