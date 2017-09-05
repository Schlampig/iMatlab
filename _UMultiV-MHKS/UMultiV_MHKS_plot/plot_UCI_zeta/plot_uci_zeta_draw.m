
clear;
plot_uci_zeta_set;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
plot(X(1,:),Y(1,:),'r-s',X(1,:),Y(2,:),'g-*',X(1,:),Y(3,:),'y-d',X(1,:),Y(4,:),'b-+',X(1,:),Y(5,:),'k-^',X(1,:),Y(6,:),'m-p','LineWidth',2,'MarkerSize',10);
xlabel('{\zeta^p}','fontsize',18,'fontname','Times New Roman');
ylabel('Classification Accuracy (%)','fontsize',18,'fontname','Times New Roman');
legend('Secom','Lenses','Sonar','Water','Iris','Glass',0,'location','NorthEastOutside');
set(gca,'Xticklabel',{'0.01','','0.1','','1','','10','','100'});
axis([min(X(1,:)),max(X(1,:)),35,99]);
grid on;

figure;
plot(X(1,:),Y(7,:),'r-s',X(1,:),Y(8,:),'g-*',X(1,:),Y(9,:),'y-d',X(1,:),Y(10,:),'b-+',X(1,:),Y(11,:),'k-^',X(1,:),Y(12,:),'m-p','LineWidth',2,'MarkerSize',10);
xlabel('{\zeta^p}','fontsize',18,'fontname','Times New Roman');
ylabel('Classification Accuracy (%)','fontsize',18,'fontname','Times New Roman');
legend('HV','Housing','Ionosphere','Transfusion','HC','Pima',0,'location','NorthEastOutside');
set(gca,'Xticklabel',{'0.01','','0.1','','1','','10','','100'});
axis([min(X(1,:)),max(X(1,:)),67,94]);
grid on;