
clear;

x_1 = 0:10;
y_1 = power(2,x_1);
px_1 = [1,2,3,4,5];
py_1 = [100,200,300,400,500];

x_2 = 0:25;
y_2 = x_2.^2;
px_2 = [6,7,8,9];
py_2 = [64,128,256,512];

x_3 = 0:6;
y_3 = 100*x_3;
px_3 = [9,12,16,24];
py_3 = [81,144,256,576];

figure;

plot(x_1,y_1,'r--',...
    x_2,y_2,'b-',...
    x_3,y_3,'k-.',...
    px_1,py_1,'ro',...
    px_2,py_2,'bo',...
    px_3,py_3,'ko',...
    'LineWidth',2.5,'MarkerSize',10);

h = legend('2^{x}','x^{2}','100x');
set(h,'fontsize',18,'fontname','Times New Roman','location','NorthEastOutside')
axis([0,25,0,600]); 
grid on;