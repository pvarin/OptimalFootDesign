function plot_phase_diagrams(Q, T)
    %Plot the states vs. time
    ScreenSize= get( groot, 'Screensize' );
    ScreenW=ScreenSize(3)-1;
    ScreenH=ScreenSize(4)-1;
    
    h1 = figure(2);
    h1.Position=[ScreenW*.5,50,ScreenW*.5-10,ScreenH*.5-100];
    plot(T,Q,'-o');
            
    %Plot the phase portraits
    h2 = figure(20);
    h2.Position=[ScreenW*.5,ScreenH*.5+30,ScreenW*.5-10,ScreenH*.5-110];
    
    subplot(2,1,1); hold on;
    plot(Q(1,:),Q(3,:),'-o');
    subplot(2,1,2); hold on;
    plot(Q(2,:),Q(4,:),'-o');
end