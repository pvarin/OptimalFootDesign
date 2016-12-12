function msg = get_error_message(info)
    if (info == 1)
        msg = 'Success';
    elseif (info == -2)
        msg = 'Failure: bad initial condition';
    elseif (info == -1)
        msg = 'Failure: integration took more than allotted time';
    elseif (info == 2)
        msg = 'Failure: body collided with ground';
    elseif (info == 3)
        msg = 'Failure: robot is tipping backward';
    elseif (info == 4)
        msg = 'Failure: robot is tipping forward';
    else
        msg = 'Failure: unknown failure, need to debug failure mode';% If this ever happens we should debug the failure mode
    end
end