function i = get_predecessor_index(X,x)
    
    % base case
    if length(X) == 1
        if x<X(1)
            i = 0;
        else
            i = 1;
        end
        return
    end
 
    % recursive call for binary search
    i = ceil(length(X)/2);
    
    if X(i)>x
        i = get_predecessor_index(X(1:i),x);
    elseif X(i)<x
        i = i+get_predecessor_index(X(i+1:end),x);
    end
end