function ground = gen_ground(X,Y)
    ground = @(x) ground_interp(x,X,Y);
end


function y = ground_interp(x,X,Y)
    i = get_predecessor_index(X,x);
    
    if i==0 || i==length(Y)
        error('input not in range')
    end
    
    % linear interpolation
    alpha = (x-X(i+1))/(X(i)-X(i+1));
    y = Y(i)*alpha + Y(i+1)*(1-alpha);
end