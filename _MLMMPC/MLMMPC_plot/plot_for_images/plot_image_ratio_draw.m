
clear;
plot_image_ratio_set;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
plot(X(1,:),Y(1,:),'b-s',X(1,:),Y(2,:),'g-*',X(1,:),Y(3,:),'r-d',X(1,:),Y(4,:),'k-.',X(1,:),Y(5,:),'k:',X(1,:),Y(6,:),'b--','LineWidth',3,'MarkerSize',10);
xlabel('Number of Training Samples (Coil-20)','fontsize',18,'fontname','Times New Roman');
ylabel('Classification Accuracy (%)','fontsize',18,'fontname','Times New Roman');
legend('MLMRPC','MatMHKS','MHKS','SVM(Linear)','SVM(Poly)','SVM(RBF)','fontname','Times New Roman','location','NorthEastOutside');
set(gca,'Xticklabel',{'144',' ','432',' ','720',' ','1008',' ','1296'});
axis([min(X(1,:)),max(X(1,:)),45,100]);
grid on;

figure;
plot(X(1,:),Y(7,:),'b-s',X(1,:),Y(8,:),'g-*',X(1,:),Y(9,:),'r-d',X(1,:),Y(10,:),'k-.',X(1,:),Y(11,:),'k:',X(1,:),Y(12,:),'b--','LineWidth',3,'MarkerSize',10);
xlabel('Number of Training Samples (ORL)','fontsize',18,'fontname','Times New Roman');
ylabel('Classification Accuracy (%)','fontsize',18,'fontname','Times New Roman');
legend('MLMRPC','MatMHKS','MHKS','SVM(Linear)','SVM(Poly)','SVM(RBF)','fontname','Times New Roman','location','NorthEastOutside');
set(gca,'Xticklabel',{'40',' ','120',' ','200',' ','280',' ','360'});
axis([min(X(1,:)),max(X(1,:)),50,100]);
grid on;

figure;
plot(X(1,:),Y(13,:),'b-s',X(1,:),Y(14,:),'g-*',X(1,:),Y(15,:),'r-d',X(1,:),Y(16,:),'k-.',X(1,:),Y(17,:),'k:',X(1,:),Y(18,:),'b--','LineWidth',3,'MarkerSize',10);
xlabel('Number of Training Samples (Yale)','fontsize',18,'fontname','Times New Roman');
ylabel('Classification Accuracy (%)','fontsize',18,'fontname','Times New Roman');
legend('MLMRPC','MatMHKS','MHKS','SVM(Linear)','SVM(Poly)','SVM(RBF)','fontname','Times New Roman','location','NorthEastOutside');
set(gca,'Xticklabel',{'17',' ','50',' ','83',' ','116',' ','149'});
axis([min(X(1,:)),max(X(1,:)),25,80]);
grid on;

figure;
plot(X(1,:),Y(19,:),'b-s',X(1,:),Y(20,:),'g-*',X(1,:),Y(21,:),'r-d',X(1,:),Y(22,:),'k-.',X(1,:),Y(23,:),'k:',X(1,:),Y(24,:),'b--','LineWidth',3,'MarkerSize',10);
xlabel('Number of Training Samples (YaleB)','fontsize',18,'fontname','Times New Roman');
ylabel('Classification Accuracy (%)','fontsize',18,'fontname','Times New Roman');
legend('MLMRPC','MatMHKS','MHKS','SVM(Linear)','SVM(POLY)','SVM(RBF)','fontname','Times New Roman','location','NorthEastOutside');
set(gca,'Xticklabel',{'242',' ','725',' ','1207',' ','1690',' ','2173'});
axis([min(X(1,:)),max(X(1,:)),35,96]);
grid on;

figure;
plot(X(1,:),Y(25,:),'b-s',X(1,:),Y(26,:),'g-*',X(1,:),Y(27,:),'r-d',X(1,:),Y(28,:),'k-.',X(1,:),Y(29,:),'k:',X(1,:),Y(30,:),'b--','LineWidth',3,'MarkerSize',10);
xlabel('Number of Training Samples (Letter)','fontsize',18,'fontname','Times New Roman');
ylabel('Classification Accuracy (%)','fontsize',18,'fontname','Times New Roman');
legend('MLMRPC','MatMHKS','MHKS','SVM(Linear)','SVM(Poly)','SVM(RBF)','fontname','Times New Roman','location','NorthEastOutside');
set(gca,'Xticklabel',{'50',' ','150',' ','250',' ','350',' ','450'});
axis([min(X(1,:)),max(X(1,:)),45,95]);
grid on;
