function q = rk_step(deriv,q,h)
    a21 = 1/2;
    a31 = 0;
    a32 = 1/2;
    a41 = 0;
    a42 = 0;
    a43 = 1;
    
    b1 = 1/6;
    b2 = 1/3;
    b3 = 1/3; 
    b4 = 1/6;
    
    k1 = deriv(q);
    k2 = deriv(q + h*a21*k1);
    k3 = deriv(q + h*(a31*k1 + a32*k2));
    k4 = deriv(q + h*(a41*k1 + a42*k2 + a43*k3));
    
    q = q + h*(b1*k1 + b2*k2 + b3*k3 + b4*k4);
end