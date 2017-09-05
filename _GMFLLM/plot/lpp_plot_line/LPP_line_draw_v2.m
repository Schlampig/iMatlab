clear;
LPP_line_set_v2;

X = 0:7;
for i_data = 1:3
    if i_data == 1
        A = D49;
        data_dim = '49';
    elseif i_data == 2
        A = D64;
        data_dim = '64';
    elseif i_data == 3
        A = D81;
        data_dim = '81';
    end
    for j = 1:6
        switch j
            case 1
                data_name = 'sCOIL-100';
            case 2
                data_name = 'COIL-20';
             case 3
                data_name = 'ORL';
             case 4
                data_name = 'sPIE';
             case 5
                data_name = 'Yale';
             case 6
                data_name = 'YaleB';
        end%switch
        
        D = [A(j,:);A(j+6,:);A(j+12,:);A(j+18,:);A(j+24,:);A(j+30,:);A(j+36,:);A(j+42,:);A(j+48,:)];
        figure;
        %Slw: r--; Sw: k-; Slw&Sw:g-.
        %Slb:  o; Sb:  d; Slb&Sb:  x
        plot(X(2:end-1),D(1,:),'r--o',...  DLPP/MMC  Slw
            X(2:end-1),D(2,:),'k-d',...   MMC  Sw
            X(2:end-1),D(3,:),'k-o',...    1 Sw
            X(2:end-1),D(4,:),'g-.d',...   2 Sw&Slw
            X(2:end-1),D(5,:),'g-.o',...   3 Sw&Slw
            X(2:end-1),D(6,:),'r--d',...    4 Slw
            X(2:end-1),D(7,:),'k-x',...   5  Sw
            X(2:end-1),D(8,:),'r--x',...   6  Slw
            X(2:end-1),A(9,:),'g-.x',...    7  Sw&Slw
            'LineWidth',2.5,'MarkerSize',10);        
        title(['AUC Comparison on ', data_name,' (', data_dim, ')'],'fontsize',24,'fontname','Times New Roman','fontweight','bold');
        xlabel('a ','fontsize',20,'fontname','Times New Roman','fontweight','bold');
        ylabel('AUC (%)','fontsize',20,'fontname','Times New Roman','fontweight','bold');
        if j == 6
            legend('DLPP/MMC','MMC','mNew1','mNew2','mNew3','mNew4','mNew5','mNew6','mNew7','fontsize',18,'fontname','Times New Roman','location','NorthEastOutside');
        end%if
        set(gca,'xtick',X);
        set(gca,'Xticklabel',[]);
        xpos = X(2:end-1);
        y_tempor = min(min(D)) - 10; 
        ypos = (y_tempor-2)*ones(1,length(xpos));
        h = text(xpos,ypos,{'0.01','0.1','1','10','100','1000'},'fontsize',12,'fontname','Times New Roman');
        % set(h,'rotation',315);
        axis([min(X(1,:)),max(X(1,:)),y_tempor,100]); 
        grid on;
    end%j
end%i_data

% plot(X(2:end-1),A(1,:),'r--+',...  DLPP/MMC  Slw
%     X(2:end-1),A(2,:),'b-.*',...   MMC  Sw
%     X(2:end-1),A(3,:),'k-d',...    1 Sw
%     X(2:end-1),A(4,:),'r--o',...   2 Sw&Slw
%     X(2:end-1),A(5,:),'b-.+',...   3 Sw&Slw
%     X(2:end-1),A(6,:),'k-*',...    4 Slw
%     X(2:end-1),A(7,:),'r--d',...   5  Sw
%     X(2:end-1),A(8,:),'b-.o',...   6  Slw
%     X(2:end-1),A(9,:),'k-+',...    7  Sw&Slw








