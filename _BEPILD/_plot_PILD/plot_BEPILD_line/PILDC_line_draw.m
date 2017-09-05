
clear;
PILDC_line_set;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
plot(X(1,:),AA(1,:),'k-s',...
    X(1,:),AA(2,:),'m-*',...
    X(1,:),AA(3,:),'r-d',...
    X(1,:),AA(4,:),'b-+',...
    'LineWidth',2.5,'MarkerSize',10);
title('i) AUC Comparison','fontsize',24,'fontname','Times New Roman','fontweight','bold');
xlabel('Datasets','fontsize',20,'fontname','Times New Roman','fontweight','bold');
ylabel('AUC (%)','fontsize',20,'fontname','Times New Roman','fontweight','bold');
legend('BEPILD(y_{pos1,neg1})','BEPILD(y_{pos2,neg2})','PILD(y_{pos1,neg1})','PILD(y_{pos2,neg2})','fontsize',18,'fontname','Times New Roman','location','NorthEastOutside');
set(gca,'xtick',X);
set(gca,'Xticklabel',[]);
xpos = X;
y_tempor = 40;
ypos = (y_tempor-0.4)*ones(1,size(X,2));
h = text(xpos,ypos,{'Wisconsin','Pima','Yeast1','Vehicle1','Vehicle0','Glass6','Yeast3','Ecoli3','Ecoli\_0\_3\_4\_vs\_5','Ecoli\_0\_2\_3\_4\_vs\_5','Yeast\_0\_3\_5\_9\_vs\_7-8','Ecoli\_0\_4\_6\_vs\_5','Ecoli\_0\_6\_7\_vs\_3-5','Yeast\_0\_5\_6\_7\_9\_vs\_4','Ecoli\_0\_6\_7\_vs\_5','Glass\_0\_1\_6\_vs\_2','Led7digit\_0\_2\_4\_5\_6\_7\_8\_9\_vs\_1','Ecoli\_0\_1\_4\_7\_vs\_5\_6','Yeast\_1\_vs\_7','Ecoli4','Dermatology\_6\_5\_5','Abalone9\_18','Yeast\_1\_4\_5\_8\_vs\_7','Yeast4','Winequality\_red\_4\_5\_5','Yeast\_1\_2\_8\_9\_vs\_7','Yeast5','Yeast6','Winequality\_red-8\_vs\_6\_7\_5\_5','Winequality\_white\_3\_9\_vs\_5\_5\_5','Abalone19'},'fontsize',12,'fontname','Times New Roman');
set(h,'rotation',315);
axis([min(X(1,:)),max(X(1,:)),y_tempor,100]); 
grid on;

figure;
plot(X(1,:),GM(1,:),'k-s',...
    X(1,:),GM(2,:),'m-*',...
    X(1,:),GM(3,:),'r-d',...
    X(1,:),GM(4,:),'b-+',...
    'LineWidth',2.5,'MarkerSize',10);
title('ii) GM Comparison','fontsize',24,'fontname','Times New Roman','fontweight','bold');
xlabel('Datasets','fontsize',20,'fontname','Times New Roman','fontweight','bold');
ylabel('GM (%)','fontsize',20,'fontname','Times New Roman','fontweight','bold');
legend('BEPILD(y_{pos1,neg1})','BEPILD(y_{pos2,neg2})','PILD(y_{pos1,neg1})','PILD(y_{pos2,neg2})','fontsize',18,'fontname','Times New Roman','location','NorthEastOutside');
set(gca,'xtick',X);
set(gca,'Xticklabel',[]);
xpos = X;
y_tempor = 0;
ypos = (y_tempor-0.4)*ones(1,size(X,2));
h = text(xpos,ypos,{'Wisconsin','Pima','Yeast1','Vehicle1','Vehicle0','Glass6','Yeast3','Ecoli3','Ecoli\_0\_3\_4\_vs\_5','Ecoli\_0\_2\_3\_4\_vs\_5','Yeast\_0\_3\_5\_9\_vs\_7-8','Ecoli\_0\_4\_6\_vs\_5','Ecoli\_0\_6\_7\_vs\_3-5','Yeast\_0\_5\_6\_7\_9\_vs\_4','Ecoli\_0\_6\_7\_vs\_5','Glass\_0\_1\_6\_vs\_2','Led7digit\_0\_2\_4\_5\_6\_7\_8\_9\_vs\_1','Ecoli\_0\_1\_4\_7\_vs\_5\_6','Yeast\_1\_vs\_7','Ecoli4','Dermatology\_6\_5\_5','Abalone9\_18','Yeast\_1\_4\_5\_8\_vs\_7','Yeast4','Winequality\_red\_4\_5\_5','Yeast\_1\_2\_8\_9\_vs\_7','Yeast5','Yeast6','Winequality\_red-8\_vs\_6\_7\_5\_5','Winequality\_white\_3\_9\_vs\_5\_5\_5','Abalone19'},'fontsize',12,'fontname','Times New Roman');
set(h,'rotation',315);
axis([min(X(1,:)),max(X(1,:)),y_tempor,100]);
grid on;