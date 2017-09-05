
clear;
plot_uci_Clambda_set;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
plot(X(1,:),Y(1,:),'r-s',...
    X(1,:),Y(2,:),'m-*',...
    X(1,:),Y(3,:),'g-d',...
    X(1,:),Y(4,:),'b-+',...
    X(1,:),Y(5,:),'k-^',...
    'LineWidth',2.5,'MarkerSize',10);
title('a)','fontsize',24,'fontname','Times New Roman','fontweight','bold');
xlabel('C','fontsize',20,'fontname','Times New Roman','fontweight','bold');
ylabel('Classification Accuracy (%)','fontsize',20,'fontname','Times New Roman','fontweight','bold');
legend('ORL','Letter','Coil\_20','Yale','YaleB','fontsize',18,'fontname','Times New Roman','location','NorthEastOutside');
set(gca,'Xticklabel',{'0.01','','0.1','','1','','10','','100'},'fontsize',16,'fontname','Times New Roman');
axis([min(X(1,:)),max(X(1,:)),52,96]);
grid on;

figure;
plot(X(1,:),Y(6,:),'r-s',...
    X(1,:),Y(7,:),'m-*',...
    X(1,:),Y(8,:),'g-d',...
    X(1,:),Y(9,:),'b-+',...
    X(1,:),Y(10,:),'k-^',...
    'LineWidth',2.5,'MarkerSize',10);
title('b)','fontsize',24,'fontname','Times New Roman','fontweight','bold');
xlabel('{\lambda}','fontsize',20,'fontname','Times New Roman','fontweight','bold');
ylabel('Classification Accuracy (%)','fontsize',20,'fontname','Times New Roman','fontweight','bold');
legend('ORL','Letter','Coil\_20','Yale','YaleB','fontsize',18,'fontname','Times New Roman','location','NorthEastOutside');
set(gca,'Xticklabel',{'0.01','','0.1','','1','','10','','100'},'fontsize',16,'fontname','Times New Roman');
axis([min(X(1,:)),max(X(1,:)),67,100]);
grid on;