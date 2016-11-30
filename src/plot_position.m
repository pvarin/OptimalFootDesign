function plot_position(q,L,gamma)
% Inputs:  q = The state vector [theta, phi]
% Outputs: Plot of the 

    if length(q)==2  
        [X1, X2] = to_cartesian(q,L);
        
        R=[cos(-gamma),-sin(-gamma);sin(-gamma),cos(-gamma)];

        fig=figure(1)
        set(fig,'Position',[20,100,500,500])
        clf
        hold on
        
        X1=R*X1;
        X2=R*X2;
        
        %Plot the Ground
            plot([2*L*cos(gamma),-2*L*cos(gamma)],...
                 [-2*L*sin(gamma),2*L*sin(gamma)],'g', 'LineWidth',2)
        
        %Plot the Legs
            plot([0,X1(1)]    ,[0,X1(2)]    ,'b-','LineWidth',2)
            plot([X1(1),X2(1)],[X1(2),X2(2)],'r-','LineWidth',2)
            
        %Plot the feet and body
            plot([0]    ,[0]    ,'ko','MarkerFaceColor','k','MarkerSize',8)
            plot([X1(1)],[X1(2)],'bo','MarkerFaceColor','b','MarkerSize',8)
            plot([X2(1)],[X2(2)],'ro','MarkerFaceColor','r','MarkerSize',8)

        
    
        xlim([-L+X1(1), L+X1(1)])
        
        YLI=(L+X1(1)+L+X1(1));
        
        ylim([-0.1*L,2*L])
    else
    end
end
