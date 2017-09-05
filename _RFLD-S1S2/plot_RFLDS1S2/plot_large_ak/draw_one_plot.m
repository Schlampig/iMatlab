function draw_one_plot(X,Y,i,tag) 
   % draw subplot 
   plot(X,Y(1,:),'k-',...
        X,Y(2,:),'r--',...
        X,Y(3,:),'b-.',...
        X,Y(4,:),'m-s',...
        X,Y(5,:),'g-o',...
        'LineWidth',2,'MarkerSize',6);
    
    %set tittle
    switch i
        case 1
            title('(a) Abalone19','fontsize',14,'fontweight','bold','fontname','Times New Roman');
        case 2
            title('(b) WineR','fontsize',14,'fontweight','bold','fontname','Times New Roman');
        case 3
            title('(c) WineW','fontsize',14,'fontweight','bold','fontname','Times New Roman');
        case 4
            title('(d) Yeast1','fontsize',14,'fontweight','bold','fontname','Times New Roman');
        case 5
            title('(e) Yeast3','fontsize',14,'fontweight','bold','fontname','Times New Roman');
        case 6
            title('(f) Yeast4','fontsize',14,'fontweight','bold','fontname','Times New Roman');
        case 7
            title('(g) Yeast5','fontsize',14,'fontweight','bold','fontname','Times New Roman');
        case 8
            title('(h) Yeast6','fontsize',14,'fontweight','bold','fontname','Times New Roman');
    end%switch
    
    % set legend and X labels
    if tag == 'a'
        h = legend('k = 1','k = 3','k = 5','k = 7','k = 9');
        set(h,'fontsize',10,'fontweight','bold','fontname','Times New Roman','location','NorthEastOutside');
        xlabel('\alpha','fontsize',12,'fontname','Times New Roman','fontweight','bold');
        set(gca,'xtick',[min(X):1:max(X)]);
        set(gca,'Xticklabel',{'0.1','0.3','0.5','0.7','0.9'},'fontsize',12,'fontname','Times New Roman');
%         set(gca,'Xticklabel',{'0.1','','0.3','','0.5','','0.7','','0.9'},'fontsize',16,'fontname','Times New Roman');
    elseif tag == 'k'
        h = legend('\alpha = 0.1','\alpha = 0.3','\alpha = 0.5','\alpha = 0.7','\alpha = 0.9');
        set(h,'fontsize',10,'fontweight','bold','fontname','Times New Roman','location','NorthEastOutside');
        xlabel('k','fontsize',12,'fontname','Times New Roman','fontweight','bold');
        set(gca,'xtick',[min(X):1:max(X)]);
        set(gca,'Xticklabel',{'1','3','5','7','9'},'fontsize',12,'fontname','Times New Roman');
%         set(gca,'Xticklabel',{'1','','3','','5','','7','','9'},'fontsize',16,'fontname','Times New Roman');
    end%if
    % set Y labels
    ylabel('AA(%)','fontsize',12,'fontname','Times New Roman','fontweight','bold');
    axis([ min(X), max(X), min(min(Y)) - 1, max(max(Y)) + 1]);
    grid on; 
    
end%function


        
          