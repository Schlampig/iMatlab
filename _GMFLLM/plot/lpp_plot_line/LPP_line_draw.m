clear;
LPP_line_set;


X = 0:7;

%sCOIL100
%-------------------------------------------------------------%
figure;
A = data1;
plot(X(2:end-1),A(1,:),'r--+',...
    X(2:end-1),A(2,:),'b-.*',...
    X(2:end-1),A(3,:),'k-d',...
    X(2:end-1),A(4,:),'r--o',...
    X(2:end-1),A(5,:),'b-.+',...
    X(2:end-1),A(6,:),'k-*',...
    X(2:end-1),A(7,:),'r--d',...
    X(2:end-1),A(8,:),'b-.o',...
    X(2:end-1),A(9,:),'k-+',...
    X(2:end-1),A(10,:),'r--*',...
    X(2:end-1),A(11,:),'b-.d',...
    X(2:end-1),A(12,:),'k-o',...
    'LineWidth',2.5,'MarkerSize',10);
title('(a) AA Comparison on sCOIL-100','fontsize',24,'fontname','Times New Roman','fontweight','bold');
xlabel('a','fontsize',20,'fontname','Times New Roman','fontweight','bold');
ylabel('AA (%)','fontsize',20,'fontname','Times New Roman','fontweight','bold');
h_leg = legend('DLPP/MMC(d=49)','MMC(d=49)','mNew5(d=49)','DLPP/MMC(d=64)','MMC(d=64)','mNew5(d=64)','DLPP/MMC(d=81)','MMC(d=8`)','mNew5(d=81)','DLPP/MMC(d=100)','MMC(d=100)','mNew5(d=100)');
set(h_leg,'fontsize',18,'fontname','Times New Roman','location','NorthEastOutside');
set(gca,'xtick',X);
set(gca,'Xticklabel',[]);
xpos = X(2:end-1);
y_tempor = 95;
ypos = (y_tempor-0.1)*ones(1,length(xpos));
h = text(xpos,ypos,{'1','10','100','1000','1500','2000'});
% set(h,'fontsize',12,'fontname','Times New Roman');
% set(h,'rotation',315);
axis([min(X(1,:)),max(X(1,:)),y_tempor,100]); 
grid on;


%Coil20
%-------------------------------------------------------------%
figure;
A = data2;
plot(X(2:end-1),A(1,:),'r--+',...
    X(2:end-1),A(2,:),'b-.*',...
    X(2:end-1),A(3,:),'k-d',...
    X(2:end-1),A(4,:),'r--o',...
    X(2:end-1),A(5,:),'b-.+',...
    X(2:end-1),A(6,:),'k-*',...
    X(2:end-1),A(7,:),'r--d',...
    X(2:end-1),A(8,:),'b-.o',...
    X(2:end-1),A(9,:),'k-+',...
    X(2:end-1),A(10,:),'r--*',...
    X(2:end-1),A(11,:),'b-.d',...
    X(2:end-1),A(12,:),'k-o',...
    'LineWidth',2.5,'MarkerSize',10);
title('(b) AA Comparison on COIL-20','fontsize',24,'fontname','Times New Roman','fontweight','bold');
xlabel('a','fontsize',20,'fontname','Times New Roman','fontweight','bold');
ylabel('AA (%)','fontsize',20,'fontname','Times New Roman','fontweight','bold');
% legend('DLPP/MMC(d=49)','MMC(d=49)','mNew5(d=49)','DLPP/MMC(d=64)','MMC(d=64)','mNew5(d=64)','DLPP/MMC(d=81)','MMC(d=8`)','mNew5(d=81)','DLPP/MMC(d=100)','MMC(d=100)','mNew5(d=100)','fontsize',18,'fontname','Times New Roman','location','NorthEastOutside');
set(gca,'xtick',X);
set(gca,'Xticklabel',[]);
xpos = X(2:end-1);
y_tempor = 85;
ypos = (y_tempor-0.4)*ones(1,length(xpos));
h = text(xpos,ypos,{'1','10','100','1000','1500','2000'});
% set(h,'fontsize',12,'fontname','Times New Roman');
% set(h,'rotation',315);
axis([min(X(1,:)),max(X(1,:)),y_tempor,100]); 
grid on;

%ORL
%-------------------------------------------------------------%
figure;
A = data3;
plot(X(2:end-1),A(1,:),'r--+',...
    X(2:end-1),A(2,:),'b-.*',...
    X(2:end-1),A(3,:),'k-d',...
    X(2:end-1),A(4,:),'r--o',...
    X(2:end-1),A(5,:),'b-.+',...
    X(2:end-1),A(6,:),'k-*',...
    X(2:end-1),A(7,:),'r--d',...
    X(2:end-1),A(8,:),'b-.o',...
    X(2:end-1),A(9,:),'k-+',...
    X(2:end-1),A(10,:),'r--*',...
    X(2:end-1),A(11,:),'b-.d',...
    X(2:end-1),A(12,:),'k-o',...
    'LineWidth',2.5,'MarkerSize',10);
title('(c) AA Comparison on ORL','fontsize',24,'fontname','Times New Roman','fontweight','bold');
xlabel('a','fontsize',20,'fontname','Times New Roman','fontweight','bold');
ylabel('AA (%)','fontsize',20,'fontname','Times New Roman','fontweight','bold');
% legend('DLPP/MMC(d=49)','MMC(d=49)','mNew5(d=49)','DLPP/MMC(d=64)','MMC(d=64)','mNew5(d=64)','DLPP/MMC(d=81)','MMC(d=8`)','mNew5(d=81)','DLPP/MMC(d=100)','MMC(d=100)','mNew5(d=100)','fontsize',18,'fontname','Times New Roman','location','NorthEastOutside');
set(gca,'xtick',X);
set(gca,'Xticklabel',[]);
xpos = X(2:end-1);
y_tempor = 40;
ypos = (y_tempor-0.8)*ones(1,length(xpos));
h = text(xpos,ypos,{'1','10','100','1000','1500','2000'});
% set(h,'fontsize',12,'fontname','Times New Roman');
% set(h,'rotation',315);
axis([min(X(1,:)),max(X(1,:)),y_tempor,90]); 
grid on;

%sPIE
%-------------------------------------------------------------%
figure;
A = data4;
plot(X(2:end-1),A(1,:),'r--+',...
    X(2:end-1),A(2,:),'b-.*',...
    X(2:end-1),A(3,:),'k-d',...
    X(2:end-1),A(4,:),'r--o',...
    X(2:end-1),A(5,:),'b-.+',...
    X(2:end-1),A(6,:),'k-*',...
    X(2:end-1),A(7,:),'r--d',...
    X(2:end-1),A(8,:),'b-.o',...
    X(2:end-1),A(9,:),'k-+',...
    X(2:end-1),A(10,:),'r--*',...
    X(2:end-1),A(11,:),'b-.d',...
    X(2:end-1),A(12,:),'k-o',...
    'LineWidth',2.5,'MarkerSize',10);
title('(d) AA Comparison on sPIE','fontsize',24,'fontname','Times New Roman','fontweight','bold');
xlabel('a','fontsize',20,'fontname','Times New Roman','fontweight','bold');
ylabel('AA (%)','fontsize',20,'fontname','Times New Roman','fontweight','bold');
% legend('DLPP/MMC(d=49)','MMC(d=49)','mNew5(d=49)','DLPP/MMC(d=64)','MMC(d=64)','mNew5(d=64)','DLPP/MMC(d=81)','MMC(d=8`)','mNew5(d=81)','DLPP/MMC(d=100)','MMC(d=100)','mNew5(d=100)','fontsize',18,'fontname','Times New Roman','location','NorthEastOutside');
set(gca,'xtick',X);
set(gca,'Xticklabel',[]);
xpos = X(2:end-1);
y_tempor = 78;
ypos = (y_tempor-0.5)*ones(1,length(xpos));
h = text(xpos,ypos,{'1','10','100','1000','1500','2000'});
% set(h,'fontsize',12,'fontname','Times New Roman');
% set(h,'rotation',315);
axis([min(X(1,:)),max(X(1,:)),y_tempor,97]); 
grid on;

%Yale
%-------------------------------------------------------------%
figure;
A = data5;
plot(X(2:end-1),A(1,:),'r--+',...
    X(2:end-1),A(2,:),'b-.*',...
    X(2:end-1),A(3,:),'k-d',...
    X(2:end-1),A(4,:),'r--o',...
    X(2:end-1),A(5,:),'b-.+',...
    X(2:end-1),A(6,:),'k-*',...
    X(2:end-1),A(7,:),'r--d',...
    X(2:end-1),A(8,:),'b-.o',...
    X(2:end-1),A(9,:),'k-+',...
    X(2:end-1),A(10,:),'r--*',...
    X(2:end-1),A(11,:),'b-.d',...
    X(2:end-1),A(12,:),'k-o',...
    'LineWidth',2.5,'MarkerSize',10);
title('(e) AA Comparison on Yale','fontsize',24,'fontname','Times New Roman','fontweight','bold');
xlabel('a','fontsize',20,'fontname','Times New Roman','fontweight','bold');
ylabel('AA (%)','fontsize',20,'fontname','Times New Roman','fontweight','bold');
% legend('DLPP/MMC(d=49)','MMC(d=49)','mNew5(d=49)','DLPP/MMC(d=64)','MMC(d=64)','mNew5(d=64)','DLPP/MMC(d=81)','MMC(d=8`)','mNew5(d=81)','DLPP/MMC(d=100)','MMC(d=100)','mNew5(d=100)','fontsize',18,'fontname','Times New Roman','location','NorthEastOutside');
set(gca,'xtick',X);
set(gca,'Xticklabel',[]);
xpos = X(2:end-1);
y_tempor = 33;
ypos = (y_tempor-0.6)*ones(1,length(xpos));
h = text(xpos,ypos,{'1','10','100','1000','1500','2000'});
% set(h,'fontsize',12,'fontname','Times New Roman');
% set(h,'rotation',315);
axis([min(X(1,:)),max(X(1,:)),y_tempor,60]); 
grid on;

%YaleB
%-------------------------------------------------------------%
figure;
A = data6;
plot(X(2:end-1),A(1,:),'r--+',...
    X(2:end-1),A(2,:),'b-.*',...
    X(2:end-1),A(3,:),'k-d',...
    X(2:end-1),A(4,:),'r--o',...
    X(2:end-1),A(5,:),'b-.+',...
    X(2:end-1),A(6,:),'k-*',...
    X(2:end-1),A(7,:),'r--d',...
    X(2:end-1),A(8,:),'b-.o',...
    X(2:end-1),A(9,:),'k-+',...
    X(2:end-1),A(10,:),'r--*',...
    X(2:end-1),A(11,:),'b-.d',...
    X(2:end-1),A(12,:),'k-o',...
    'LineWidth',2.5,'MarkerSize',10);
title('(f) AA Comparison on YaleB','fontsize',24,'fontname','Times New Roman','fontweight','bold');
xlabel('a','fontsize',20,'fontname','Times New Roman','fontweight','bold');
ylabel('AA (%)','fontsize',20,'fontname','Times New Roman','fontweight','bold');
% legend('DLPP/MMC(d=49)','MMC(d=49)','mNew5(d=49)','DLPP/MMC(d=64)','MMC(d=64)','mNew5(d=64)','DLPP/MMC(d=81)','MMC(d=8`)','mNew5(d=81)','DLPP/MMC(d=100)','MMC(d=100)','mNew5(d=100)','fontsize',18,'fontname','Times New Roman','location','NorthEastOutside');
set(gca,'xtick',X);
set(gca,'Xticklabel',[]);
xpos = X(2:end-1);
y_tempor = 40;
ypos = (y_tempor-0.6)*ones(1,length(xpos));
h = text(xpos,ypos,{'1','10','100','1000','1500','2000'});
% set(h,'fontsize',12,'fontname','Times New Roman');
% set(h,'rotation',315);
axis([min(X(1,:)),max(X(1,:)),y_tempor,77]); 
grid on;








