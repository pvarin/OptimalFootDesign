function animate_compass_gait(T,Q,params,varargin)
% function animate_compass_gait(T,Q)
%
% Input: T      = the time vector
%        Q      = the trajectory
%        params = the compass gait parameters
%        speed  = (optional) how much faster to animate (e.g. 2 = 2x speed)
    
    % unpack the optional speed parameter
    speed = 1;
    if nargin > 3
        speed = varargin{1};
    end

    % construct the inital plot
    
    ScreenSize= get( groot, 'Screensize' );
    ScreenW=ScreenSize(3)-1;
    ScreenH=ScreenSize(4)-1;
    
    
    h = figure(1);
    clf
    h.Position =[10,50,ScreenW*.5-10,ScreenH*.5-25];
    [leg_1, leg_2] = plot_compass_gait(Q(:,1), h, params);
    
    drawnow;
    
    % animate all of the next sequences
    for i=2:length(T)
        pause((T(i)-T(i-1))/speed);
        update_compass_gait(Q(:,i), leg_1, leg_2, params)
    end
end

function [leg_1, leg_2] = plot_compass_gait(q, h, params)
    figure(h);
    [X1, X2] = to_cartesian(q,params.L);
    R = [ cos(params.gamma), sin(params.gamma);
         -sin(params.gamma), cos(params.gamma)];
    
    X1 = R*X1(1:2);
    X2 = R*X2(1:2);
    
    % plot the ground
    c = 2*params.L*cos(params.gamma);
    s = 2*params.L*sin(params.gamma);
    plot([c,-c],[-s,s],'g', 'LineWidth', 2);
    axis equal
    hold on;
    
    % plot the legs
    leg_2 = plot([X1(1),X2(1)],[X1(2),X2(2)],'ro-','LineWidth',2,'MarkerSize',8,'MarkerFaceColor','r');
    leg_1 = plot([0,X1(1)]    ,[0,X1(2)]    ,'bo-','LineWidth',2,'MarkerSize',8,'MarkerFaceColor','b');
    plot([0]    ,[0]    ,'ko','MarkerFaceColor','k','MarkerSize',8)
end

function update_compass_gait(q, leg_1, leg_2, params)
%     figure(h);
    [X1, X2] = to_cartesian(q,params.L);
    R = [ cos(params.gamma), sin(params.gamma);
         -sin(params.gamma), cos(params.gamma)];
    
    X1 = R*X1(1:2);
    X2 = R*X2(1:2);
    
    set(leg_1,{'XData','YData'},{[0,X1(1)],[0,X1(2)]});
    set(leg_2,{'XData','YData'},{[X1(1),X2(1)],[X1(2),X2(2)]});
end