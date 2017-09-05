
clear;
plot_uci_time_set;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
plot(X(1,:),Y(1,:),'r-s',X(1,:),Y(2,:),'y-*',X(1,:),Y(3,:),'k-d',X(1,:),Y(4,:),'b-+','LineWidth',2,'MarkerSize',10);
title('Lenses/Time','fontsize',18,'fontname','Times New Roman','fontweight','bold');
xlabel('\beta','fontsize',18,'fontname','Times New Roman');
ylabel('Training Time (s)','fontsize',18,'fontname','Times New Roman');
legend('UMultiV-MHKS','MultiV-MHKS','MatMHKS','MHKS',0,'location','NorthEastOutside');
set(gca,'Xticklabel',{'0.1',' ','0.3',' ','0.5',' ','0.7 '});
axis([min(X(1,:)),max(X(1,:)),0,3]);
grid on;

figure;
plot(X(1,:),Y(5,:),'r-s',X(1,:),Y(6,:),'y-*',X(1,:),Y(7,:),'k-d',X(1,:),Y(8,:),'b-+','LineWidth',2,'MarkerSize',10);
title('Glass/Time','fontsize',18,'fontname','Times New Roman','fontweight','bold');
xlabel('\beta','fontsize',18,'fontname','Times New Roman');
ylabel('Training Time (s)','fontsize',18,'fontname','Times New Roman');
legend('UMultiV-MHKS','MultiV-MHKS','MatMHKS','MHKS',0,'location','NorthEastOutside');
set(gca,'Xticklabel',{'0.1',' ','0.3',' ','0.5',' ','0.7 '});
axis([min(X(1,:)),max(X(1,:)),24,69]);
grid on;

figure;
plot(X(1,:),Y(9,:),'r-s',X(1,:),Y(10,:),'y-*',X(1,:),Y(11,:),'k-d',X(1,:),Y(12,:),'b-+','LineWidth',2,'MarkerSize',10);
title('Iris/Time','fontsize',18,'fontname','Times New Roman','fontweight','bold');
xlabel('\beta','fontsize',18,'fontname','Times New Roman');
ylabel('Training Time (s)','fontsize',18,'fontname','Times New Roman');
legend('UMultiV-MHKS','MultiV-MHKS','MatMHKS','MHKS',0,'location','NorthEastOutside');
set(gca,'Xticklabel',{'0.1',' ','0.3',' ','0.5',' ','0.7 '});
axis([min(X(1,:)),max(X(1,:)),0,26]);
grid on;

figure;
plot(X(1,:),Y(13,:),'r-s',X(1,:),Y(14,:),'y-*',X(1,:),Y(15,:),'k-d',X(1,:),Y(16,:),'b-+','LineWidth',2,'MarkerSize',10);
title('Water/Time','fontsize',18,'fontname','Times New Roman','fontweight','bold');
xlabel('\beta','fontsize',18,'fontname','Times New Roman');
ylabel('Training Time (s)','fontsize',18,'fontname','Times New Roman');
legend('UMultiV-MHKS','MultiV-MHKS','MatMHKS','MHKS',0,'location','NorthEastOutside');
set(gca,'Xticklabel',{'0.1',' ','0.3',' ','0.5',' ','0.7 '});
axis([min(X(1,:)),max(X(1,:)),2,16]);
grid on;

figure;
plot(X(1,:),Y(17,:),'r-s',X(1,:),Y(18,:),'y-*',X(1,:),Y(19,:),'k-d',X(1,:),Y(20,:),'b-+','LineWidth',2,'MarkerSize',10);
title('Pima/Time','fontsize',18,'fontname','Times New Roman','fontweight','bold');
xlabel('\beta','fontsize',18,'fontname','Times New Roman');
ylabel('Training Time (s)','fontsize',18,'fontname','Times New Roman');
legend('UMultiV-MHKS','MultiV-MHKS','MatMHKS','MHKS',0,'location','NorthEastOutside');
set(gca,'Xticklabel',{'0.1',' ','0.3',' ','0.5',' ','0.7 '});
axis([min(X(1,:)),max(X(1,:)),1,10]);
grid on;

figure;
plot(X(1,:),Y(21,:),'r-s',X(1,:),Y(22,:),'y-*',X(1,:),Y(23,:),'k-d',X(1,:),Y(24,:),'b-+','LineWidth',2,'MarkerSize',10);
title('Housing/Time','fontsize',18,'fontname','Times New Roman','fontweight','bold');
xlabel('\beta','fontsize',18,'fontname','Times New Roman');
ylabel('Training Time (s)','fontsize',18,'fontname','Times New Roman');
legend('UMultiV-MHKS','MultiV-MHKS','MatMHKS','MHKS',0,'location','NorthEastOutside');
set(gca,'Xticklabel',{'0.1',' ','0.3',' ','0.5',' ','0.7 '});
axis([min(X(1,:)),max(X(1,:)),0,4]);
grid on;


figure;
plot(X(1,:),Y(25,:),'r-s',X(1,:),Y(26,:),'y-*',X(1,:),Y(27,:),'k-d',X(1,:),Y(28,:),'b-+','LineWidth',2,'MarkerSize',10);
title('Sonar/Time','fontsize',18,'fontname','Times New Roman','fontweight','bold');
xlabel('\beta','fontsize',18,'fontname','Times New Roman');
ylabel('Training Time (s)','fontsize',18,'fontname','Times New Roman');
legend('UMultiV-MHKS','MultiV-MHKS','MatMHKS','MHKS',0,'location','NorthEastOutside');
set(gca,'Xticklabel',{'0.1',' ','0.3',' ','0.5',' ','0.7 '});
axis([min(X(1,:)),max(X(1,:)),0,10]);
grid on;

figure;
plot(X(1,:),Y(29,:),'r-s',X(1,:),Y(30,:),'y-*',X(1,:),Y(31,:),'k-d',X(1,:),Y(32,:),'b-+','LineWidth',2,'MarkerSize',10);
title('BCW/Time','fontsize',18,'fontname','Times New Roman','fontweight','bold');
xlabel('\beta','fontsize',18,'fontname','Times New Roman');
ylabel('Training Time (s)','fontsize',18,'fontname','Times New Roman');
legend('UMultiV-MHKS','MultiV-MHKS','MatMHKS','MHKS',0,'location','NorthEastOutside');
set(gca,'Xticklabel',{'0.1',' ','0.3',' ','0.5',' ','0.7 '});
axis([min(X(1,:)),max(X(1,:)),10,23]);
grid on;

figure;
plot(X(1,:),Y(33,:),'r-s',X(1,:),Y(34,:),'y-*',X(1,:),Y(35,:),'k-d',X(1,:),Y(36,:),'b-+','LineWidth',2,'MarkerSize',10);
title('Ionosphere/Time','fontsize',18,'fontname','Times New Roman','fontweight','bold');
xlabel('\beta','fontsize',18,'fontname','Times New Roman');
ylabel('Training Time (s)','fontsize',18,'fontname','Times New Roman');
legend('UMultiV-MHKS','MultiV-MHKS','MatMHKS','MHKS',0,'location','NorthEastOutside');
set(gca,'Xticklabel',{'0.1',' ','0.3',' ','0.5',' ','0.7 '});
axis([min(X(1,:)),max(X(1,:)),2,12]);
grid on;

figure;
plot(X(1,:),Y(37,:),'r-s',X(1,:),Y(38,:),'y-*',X(1,:),Y(39,:),'k-d',X(1,:),Y(40,:),'b-+','LineWidth',2,'MarkerSize',10);
title('Transfusion/Time','fontsize',18,'fontname','Times New Roman','fontweight','bold');
xlabel('\beta','fontsize',18,'fontname','Times New Roman');
ylabel('Training Time (s)','fontsize',18,'fontname','Times New Roman');
legend('UMultiV-MHKS','MultiV-MHKS','MatMHKS','MHKS',0,'location','NorthEastOutside');
set(gca,'Xticklabel',{'0.1',' ','0.3',' ','0.5',' ','0.7 '});
axis([min(X(1,:)),max(X(1,:)),1,20]);
grid on;

figure;
plot(X(1,:),Y(41,:),'r-s',X(1,:),Y(42,:),'y-*',X(1,:),Y(43,:),'k-d',X(1,:),Y(44,:),'b-+','LineWidth',2,'MarkerSize',10);
title('Secom/Time','fontsize',18,'fontname','Times New Roman','fontweight','bold');
xlabel('\beta','fontsize',18,'fontname','Times New Roman');
ylabel('Training Time (s)','fontsize',18,'fontname','Times New Roman');
legend('UMultiV-MHKS','MultiV-MHKS','MatMHKS','MHKS',0,'location','NorthEastOutside');
set(gca,'Xticklabel',{'0.1',' ','0.3',' ','0.5',' ','0.7 '});
axis([min(X(1,:)),max(X(1,:)),9,44]);
grid on;

figure;
plot(X(1,:),Y(45,:),'r-s',X(1,:),Y(46,:),'y-*',X(1,:),Y(47,:),'k-d',X(1,:),Y(48,:),'b-+','LineWidth',2,'MarkerSize',10);
title('HC/Time','fontsize',18,'fontname','Times New Roman','fontweight','bold');
xlabel('\beta','fontsize',18,'fontname','Times New Roman');
ylabel('Training Time (s)','fontsize',18,'fontname','Times New Roman');
legend('UMultiV-MHKS','MultiV-MHKS','MatMHKS','MHKS',0,'location','NorthEastOutside');
set(gca,'Xticklabel',{'0.1',' ','0.3',' ','0.5',' ','0.7 '});
axis([min(X(1,:)),max(X(1,:)),2,7]);
grid on;

figure;
plot(X(1,:),Y(49,:),'r-s',X(1,:),Y(50,:),'y-*',X(1,:),Y(51,:),'k-d',X(1,:),Y(52,:),'b-+','LineWidth',2,'MarkerSize',10);
title('Cmc/Time','fontsize',18,'fontname','Times New Roman','fontweight','bold');
xlabel('\beta','fontsize',18,'fontname','Times New Roman');
ylabel('Training Time (s)','fontsize',18,'fontname','Times New Roman');
legend('UMultiV-MHKS','MultiV-MHKS','MatMHKS','MHKS',0,'location','NorthEastOutside');
set(gca,'Xticklabel',{'0.1',' ','0.3',' ','0.5',' ','0.7 '});
axis([min(X(1,:)),max(X(1,:)),3,12]);
grid on;

figure;
plot(X(1,:),Y(53,:),'r-s',X(1,:),Y(54,:),'y-*',X(1,:),Y(55,:),'k-d',X(1,:),Y(56,:),'b-+','LineWidth',2,'MarkerSize',10);
title('HV/Time','fontsize',18,'fontname','Times New Roman','fontweight','bold');
xlabel('\beta','fontsize',18,'fontname','Times New Roman');
ylabel('Training Time (s)','fontsize',18,'fontname','Times New Roman');
legend('UMultiV-MHKS','MultiV-MHKS','MatMHKS','MHKS',0,'location','NorthEastOutside');
set(gca,'Xticklabel',{'0.1',' ','0.3',' ','0.5',' ','0.7 '});
axis([min(X(1,:)),max(X(1,:)),0,11]);
grid on;