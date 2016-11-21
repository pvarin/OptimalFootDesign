function plot_position(q,L)
% Inputs:  q = The state vector [theta, phi]
% Outputs: Plot of the 

    if length(q)==2  
        [X1, X2] = to_cartesian(q(1),q(2),L);

        fig=figure(1)
        set(fig,'Position',[20,100,500,500])
        clf
        hold on

        plot([0,X1(1)]    ,[0,X1(2)]    ,'b-','LineWidth',2)
        plot([X1(1),X2(1)],[X1(2),X2(2)],'r-','LineWidth',2)
        
        plot([0]    ,[0]    ,'ko','MarkerFaceColor','k','MarkerSize',8)
        plot([X1(1)],[X1(2)],'bo','MarkerFaceColor','b','MarkerSize',8)
        plot([X2(1)],[X2(2)],'ro','MarkerFaceColor','r','MarkerSize',8)
    
    else
    end
end
