clear;
LPP_bar_set;
X = 0:19;

%AUC:81,144,256,576
%--------------------------------------------------------------------%
figure;
bar(dim81_auc,'stack');
colormap(bone);
%以下几步设定横轴单位名称
set(gca,'xtick',X);
set(gca,'Xticklabel',[]);
xpos = X(2:end-1);
y_tempor = 40;
ypos = (y_tempor-0.4)*ones(1,length(xpos));
h = text(xpos,ypos,{'mNew1','mNew2','mNew3','mNew4','mNew5','mNew6','mNew7','DLPP/MMC','MMC','rNew1','rNew2','rNew3','rNew4','rNew5','rNew6','rNew7','DLPP','LDA'},'fontsize',12,'fontname','Times New Roman');
set(h,'rotation',315);
axis([min(X(1,:)),max(X(1,:)),y_tempor,535]);
%设定总标题
title('(a) AA Comparison (d = 81)','fontsize',24,'fontname','Times New Roman','fontweight','bold');
xlabel('Datasets','fontsize',20,'fontname','Times New Roman','fontweight','bold');
ylabel('AA_{sum} (%)','fontsize',20,'fontname','Times New Roman','fontweight','bold');
h_leg = legend('sCOIL-100','COIL-20','ORL','sPIE','Yale','YaleB');
set(h_leg,'fontsize',18,'fontname','Times New Roman','location','NorthEastOutside');
grid on;


%--------------------------------------------------------------------%
figure;
bar(dim144_auc,'stack');
colormap(bone);
%以下几步设定横轴单位名称
set(gca,'xtick',X);
set(gca,'Xticklabel',[]);
xpos = X(2:end-1);
y_tempor = 40;
ypos = (y_tempor-0.4)*ones(1,length(xpos));
h = text(xpos,ypos,{'mNew1','mNew2','mNew3','mNew4','mNew5','mNew6','mNew7','DLPP/MMC','MMC','rNew1','rNew2','rNew3','rNew4','rNew5','rNew6','rNew7','DLPP','LDA'},'fontsize',12,'fontname','Times New Roman');
set(h,'rotation',315);
axis([min(X(1,:)),max(X(1,:)),y_tempor,535]);
%设定总标题
title('(b) AA Comparison (d = 144)','fontsize',24,'fontname','Times New Roman','fontweight','bold');
xlabel('Datasets','fontsize',20,'fontname','Times New Roman','fontweight','bold');
ylabel('AA_{sum} (%)','fontsize',20,'fontname','Times New Roman','fontweight','bold');
h_leg = legend('sCOIL-100','COIL-20','ORL','sPIE','Yale','YaleB');
set(h_leg,'fontsize',18,'fontname','Times New Roman','location','NorthEastOutside');
grid on;


%--------------------------------------------------------------------%
figure;
bar(dim256_auc,'stack');
colormap(bone);
%以下几步设定横轴单位名称
set(gca,'xtick',X);
set(gca,'Xticklabel',[]);
xpos = X(2:end-1);
y_tempor = 40;
ypos = (y_tempor-0.4)*ones(1,length(xpos));
h = text(xpos,ypos,{'mNew1','mNew2','mNew3','mNew4','mNew5','mNew6','mNew7','DLPP/MMC','MMC','rNew1','rNew2','rNew3','rNew4','rNew5','rNew6','rNew7','DLPP','LDA'},'fontsize',12,'fontname','Times New Roman');
set(h,'rotation',315);
axis([min(X(1,:)),max(X(1,:)),y_tempor,535]);
%设定总标题
title('(c) AA Comparison (d = 256)','fontsize',24,'fontname','Times New Roman','fontweight','bold');
xlabel('Datasets','fontsize',20,'fontname','Times New Roman','fontweight','bold');
ylabel('AA_{sum} (%)','fontsize',20,'fontname','Times New Roman','fontweight','bold');
h_leg = legend('sCOIL-100','COIL-20','ORL','sPIE','Yale','YaleB');
set(h_leg,'fontsize',18,'fontname','Times New Roman','location','NorthEastOutside');
grid on;


%--------------------------------------------------------------------%
figure;
bar(dim576_auc,'stack');
colormap(bone);
%以下几步设定横轴单位名称
set(gca,'xtick',X);
set(gca,'Xticklabel',[]);
xpos = X(2:end-1);
y_tempor = 40;
ypos = (y_tempor-0.4)*ones(1,length(xpos));
h = text(xpos,ypos,{'mNew1','mNew2','mNew3','mNew4','mNew5','mNew6','mNew7','DLPP/MMC','MMC','rNew1','rNew2','rNew3','rNew4','rNew5','rNew6','rNew7','DLPP','LDA'},'fontsize',12,'fontname','Times New Roman');
set(h,'rotation',315);
axis([min(X(1,:)),max(X(1,:)),y_tempor,535]);
%设定总标题
title('(d) AA Comparison (d = 576)','fontsize',24,'fontname','Times New Roman','fontweight','bold');
xlabel('Datasets','fontsize',20,'fontname','Times New Roman','fontweight','bold');
ylabel('AA_{sum} (%)','fontsize',20,'fontname','Times New Roman','fontweight','bold');
h_leg = legend('sCOIL-100','COIL-20','ORL','sPIE','Yale','YaleB');
set(h_leg,'fontsize',18,'fontname','Times New Roman','location','NorthEastOutside');
grid on;

%ACC:81,144,256,576
%--------------------------------------------------------------------%
figure;
bar(dim81_acc,'stack');
colormap(bone);
%以下几步设定横轴单位名称
set(gca,'xtick',X);
set(gca,'Xticklabel',[]);
xpos = X(2:end-1);
y_tempor = 40;
ypos = (y_tempor-0.4)*ones(1,length(xpos));
h = text(xpos,ypos,{'mNew1','mNew2','mNew3','mNew4','mNew5','mNew6','mNew7','DLPP/MMC','MMC','rNew1','rNew2','rNew3','rNew4','rNew5','rNew6','rNew7','DLPP','LDA'},'fontsize',12,'fontname','Times New Roman');
set(h,'rotation',315);
axis([min(X(1,:)),max(X(1,:)),y_tempor,535]);
%设定总标题
title('(e) ACC Comparison (d = 81)','fontsize',24,'fontname','Times New Roman','fontweight','bold');
xlabel('Datasets','fontsize',20,'fontname','Times New Roman','fontweight','bold');
ylabel('ACC_{sum} (%)','fontsize',20,'fontname','Times New Roman','fontweight','bold');
h_leg = legend('sCOIL-100','COIL-20','ORL','sPIE','Yale','YaleB');
set(h_leg,'fontsize',18,'fontname','Times New Roman','location','NorthEastOutside');
grid on;


%--------------------------------------------------------------------%
figure;
bar(dim144_acc,'stack');
colormap(bone);
%以下几步设定横轴单位名称
set(gca,'xtick',X);
set(gca,'Xticklabel',[]);
xpos = X(2:end-1);
y_tempor = 40;
ypos = (y_tempor-0.4)*ones(1,length(xpos));
h = text(xpos,ypos,{'mNew1','mNew2','mNew3','mNew4','mNew5','mNew6','mNew7','DLPP/MMC','MMC','rNew1','rNew2','rNew3','rNew4','rNew5','rNew6','rNew7','DLPP','LDA'},'fontsize',12,'fontname','Times New Roman');
set(h,'rotation',315);
axis([min(X(1,:)),max(X(1,:)),y_tempor,535]);
%设定总标题
title('(f) ACC Comparison (d = 144)','fontsize',24,'fontname','Times New Roman','fontweight','bold');
xlabel('Datasets','fontsize',20,'fontname','Times New Roman','fontweight','bold');
ylabel('ACC_{sum} (%)','fontsize',20,'fontname','Times New Roman','fontweight','bold');
h_leg = legend('sCOIL-100','COIL-20','ORL','sPIE','Yale','YaleB');
set(h_leg,'fontsize',18,'fontname','Times New Roman','location','NorthEastOutside');
grid on;


%--------------------------------------------------------------------%
figure;
bar(dim256_acc,'stack');
colormap(bone);
%以下几步设定横轴单位名称
set(gca,'xtick',X);
set(gca,'Xticklabel',[]);
xpos = X(2:end-1);
y_tempor = 40;
ypos = (y_tempor-0.4)*ones(1,length(xpos));
h = text(xpos,ypos,{'mNew1','mNew2','mNew3','mNew4','mNew5','mNew6','mNew7','DLPP/MMC','MMC','rNew1','rNew2','rNew3','rNew4','rNew5','rNew6','rNew7','DLPP','LDA'},'fontsize',12,'fontname','Times New Roman');
set(h,'rotation',315);
axis([min(X(1,:)),max(X(1,:)),y_tempor,535]);
%设定总标题
title('(g) ACC Comparison (d = 256)','fontsize',24,'fontname','Times New Roman','fontweight','bold');
xlabel('Datasets','fontsize',20,'fontname','Times New Roman','fontweight','bold');
ylabel('ACC_{sum} (%)','fontsize',20,'fontname','Times New Roman','fontweight','bold');
h_leg = legend('sCOIL-100','COIL-20','ORL','sPIE','Yale','YaleB');
set(h_leg,'fontsize',18,'fontname','Times New Roman','location','NorthEastOutside');
grid on;


%--------------------------------------------------------------------%
figure;
bar(dim576_acc,'stack');
colormap(bone);
%以下几步设定横轴单位名称
set(gca,'xtick',X);
set(gca,'Xticklabel',[]);
xpos = X(2:end-1);
y_tempor = 40;
ypos = (y_tempor-0.4)*ones(1,length(xpos));
h = text(xpos,ypos,{'mNew1','mNew2','mNew3','mNew4','mNew5','mNew6','mNew7','DLPP/MMC','MMC','rNew1','rNew2','rNew3','rNew4','rNew5','rNew6','rNew7','DLPP','LDA'},'fontsize',12,'fontname','Times New Roman');
set(h,'rotation',315);
axis([min(X(1,:)),max(X(1,:)),y_tempor,535]);
%设定总标题
title('(h) ACC Comparison (d = 576)','fontsize',24,'fontname','Times New Roman','fontweight','bold');
xlabel('Datasets','fontsize',20,'fontname','Times New Roman','fontweight','bold');
ylabel('ACC_{sum} (%)','fontsize',20,'fontname','Times New Roman','fontweight','bold');
h_leg = legend('sCOIL-100','COIL-20','ORL','sPIE','Yale','YaleB');
set(h_leg,'fontsize',18,'fontname','Times New Roman','location','NorthEastOutside');
grid on;


