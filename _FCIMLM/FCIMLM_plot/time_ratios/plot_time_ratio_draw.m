
clear;
plot_time_ratio_set;

Y(2,:) = 2*Y(2,:);
Y(4,:) = 4*Y(4,:);
Y(6,:) = 9*Y(6,:);
Y(8,:) = 4*Y(8,:);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
plot(X(1,:),Y(1,:),'b-s',X(1,:),Y(2,:),'b--s',...
    X(1,:),Y(3,:),'r-o',X(1,:),Y(4,:),'r--o',...
    X(1,:),Y(5,:),'k-d',X(1,:),Y(6,:),'k--d',...
    X(1,:),Y(7,:),'g-x',X(1,:),Y(8,:),'g--x','LineWidth',3,'MarkerSize',10);
title('A) Training Time (s) Comparison','fontsize',24,'fontname','Times New Roman');
xlabel('{\beta}','fontsize',20,'fontname','Times New Roman');
ylabel('Training Time (s)','fontsize',20,'fontname','Times New Roman');
legend('MLMFCI-Segmentation','MatMHKS-Segmentation','MLMFCI-Page Blocks','MatMHKS-Page Blocks','MLMFCI-Statlog','MatMHKS-Statlog','MLMFCI-Waveform','MatMHKS-Waveform','fontname','Times New Roman','location','NorthEastOutside');
set(gca,'Xticklabel',{'0.1',' ','0.3',' ','0.5',' ','0.7',' ','0.9'});
axis([min(X(1,:)),max(X(1,:)),0,105]);
grid on;


