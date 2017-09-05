clear;
plot_para_set;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
plot(X(1,:),Y(1,:),'g-s',...
    X(1,:),Y(2,:),'r--',...
    X(1,:),Y(3,:),'b-*',...
    X(1,:),Y(4,:),'k-^',...
    X(1,:),Y(5,:),'r-d','LineWidth',3,'MarkerSize',10);
xlabel('C','fontsize',18,'fontname','Times New Roman');
ylabel('Classification Accuracy (%)','fontsize',18,'fontname','Times New Roman');
legend('Coil-20','ORL','Letter','Yale','YaleB','fontname','Times New Roman','location','NorthEastOutside');
set(gca,'Xticklabel',{'0.01',' ','0.1',' ','1',' ','10','','100'});
axis([min(X(1,:)),max(X(1,:)),55,100]);
grid on;

%----------------------------------------------------------------------

figure;
plot(X(1,:),Y(6,:),'g-s',...
    X(1,:),Y(7,:),'r--',...
    X(1,:),Y(8,:),'b-*',...
    X(1,:),Y(9,:),'k-^',...
    X(1,:),Y(10,:),'r-d','LineWidth',3,'MarkerSize',10);
xlabel('\lambda','fontsize',18,'fontname','Times New Roman');
ylabel('Classification Accuracy (%)','fontsize',18,'fontname','Times New Roman');
legend('Coil-20','ORL','Letter','Yale','YaleB','fontname','Times New Roman','location','NorthEastOutside');
set(gca,'Xticklabel',{'0.01',' ','0.1',' ','1',' ','10','','100'});
axis([min(X(1,:)),max(X(1,:)),65,100]);
grid on;

%----------------------------------------------------------------------

figure;
plot(X(1,:),Y(11,:),'g-s',...
    X(1,:),Y(12,:),'r--',...
    X(1,:),Y(13,:),'b-*',...
    X(1,:),Y(14,:),'k-^',...
    X(1,:),Y(15,:),'r-d','LineWidth',3,'MarkerSize',10);
xlabel('\gamma','fontsize',18,'fontname','Times New Roman');
ylabel('Classification Accuracy (%)','fontsize',18,'fontname','Times New Roman');
legend('Coil-20','ORL','Letter','Yale','YaleB','fontname','Times New Roman','location','NorthEastOutside');
set(gca,'Xticklabel',{'0.01',' ','0.1',' ','1',' ','10','','100'});
axis([min(X(1,:)),max(X(1,:)),65,100]);
grid on;


