
clear;
plot_ak_set;

Y = {'Y_MTMFLD_a','Y_MTMFLD_k','Y_BEMFLD_a','Y_BEMFLD_k','Y_MFLD_a','Y_MFLD_k'};

for i = 1:length(Y)
    figure;
    plot(X,eval([Y{i},'(1,:)']),'k-',...
        X,eval([Y{i},'(2,:)']),'r--',...
        X,eval([Y{i},'(3,:)']),'r-.',...
        X,eval([Y{i},'(4,:)']),'b-s',...
        X,eval([Y{i},'(5,:)']),'b-o',...
        X,eval([Y{i},'(6,:)']),'b-d',...
        X,eval([Y{i},'(7,:)']),'b-x',...
        X,eval([Y{i},'(8,:)']),'b-*',...
        'LineWidth',5,'MarkerSize',20);
        % set legend
        h = legend('Abalone19','WineR','WineW','Yeast1','Yeast3','Yeast4','Yeast5','Yeast6');
        set(h,'fontsize',18,'fontweight','bold','fontname','Times New Roman','location','NorthEastOutside');
        %set tittle
        switch i
            case 1
                title('(a1) MTRFLD','fontsize',30,'fontweight','bold','fontname','Times New Roman');
            case 2
                title('(b1) MTRFLD','fontsize',30,'fontweight','bold','fontname','Times New Roman');
            case 3
                title('(a2) BERFLD','fontsize',30,'fontweight','bold','fontname','Times New Roman');
            case 4
                title('(b2) BERFLD','fontsize',30,'fontweight','bold','fontname','Times New Roman');
            case 5
                title('(a3) RFLD','fontsize',30,'fontweight','bold','fontname','Times New Roman');
            case 6
                title('(b3) RFLD','fontsize',30,'fontweight','bold','fontname','Times New Roman');
        end%switch
        % set X&Y labels
        if mod(i,2) == 0
            xlabel('k','fontsize',20,'fontname','Times New Roman','fontweight','bold');
            set(gca,'Xticklabel',{'0.1','','0.3','','0.5','','0.7','','0.9'},'fontsize',16,'fontname','Times New Roman');
        else
            xlabel('\alpha','fontsize',20,'fontname','Times New Roman','fontweight','bold');
            set(gca,'Xticklabel',{'1','','3','','5','','7','','9'},'fontsize',16,'fontname','Times New Roman');
        end%if
        ylabel('AA(%)','fontsize',20,'fontname','Times New Roman','fontweight','bold');
        axis([ min(X(1,:)), max(X(1,:)), min(min(eval(Y{i}))) - 10, max(max(eval(Y{i}))) + 1]);
        grid on;
    
    
end%for_i
