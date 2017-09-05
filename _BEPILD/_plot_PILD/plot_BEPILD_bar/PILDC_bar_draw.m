


acc_res = [ 81.87	76.67	80.7	95.65;
            87.16	97.29	53.017	99.88;
            87.64	86.13	81.71	87.36;
            88.55	91.63	58.23	95.64;
            86.39	86.91	86.29	83.45;
            90.57	67.94	90.57	79.9;
            50.37	45.04	48.32	52.31];
        
auc_res = [ 85.01	76.81	80.86	95.63;
            82.47	99.49	72.12	88.29;
            86.47	85.36	82.86	85.28;
            81.32	67.64	75.17	67.38;
            87.92	86.39	86.31	83.45;
            90.43	59.71	90.43	78.59;
            51.58	42.22	50.54	48.96];
        
traintime_res = [   0.39	51.2	0.18;
                    0.17	129.48	0.08;
                    0.04	12.59	0.02;
                    0.01	2.28	0.01;
                    0.02	5.68	0.01;
                    0.01	0.8	    0.01;
                    0.01	0.51	0.01];      
                
testtime_res = [5.53	0.5     4.13	13.82;
                4.71	0.39	1.03    119.61;
                0.08	0.02	0.04	1.71;
                0.05	0.11	0.02	0.44;
                0.02	0.01	0.01	0.41;
                0.08	0.18	0.01	1.28;
                0.01	0.01	0.01	0.04]; 

            

%使用数据集的基本信息及近邻k的最优选取放在另一张表里。           
figure;
bar(acc_res,1);
colormap(bone);
set(gca,'XTickLabel',{'Letter','Shuttle','Satellite','PaB','Waveform','Spambase','Cmc'},'fontsize',16,'fontname','Times New Roman');
title('i) Acc Comparison','fontsize',24,'fontname','Times New Roman','fontweight','bold');
xlabel('Datasets','fontsize',20,'fontname','Times New Roman','fontweight','bold');
ylabel('Classification Accuracy (%)','fontsize',20,'fontname','Times New Roman','fontweight','bold');
legend('BEPILD','SVM(Linear)','PILD','kNN','fontsize',18,'fontname','Times New Roman','location','NorthEastOutside');
grid on;

figure;
bar(auc_res,1);
colormap(bone);
set(gca,'XTickLabel',{'Letter','Shuttle','Satellite','PaB','Waveform','Spambase','Cmc'},'fontsize',16,'fontname','Times New Roman');
title('ii) AUC Comparison','fontsize',24,'fontname','Times New Roman','fontweight','bold');
xlabel('Datasets','fontsize',20,'fontname','Times New Roman','fontweight','bold');
ylabel('AUC (%)','fontsize',20,'fontname','Times New Roman','fontweight','bold');
legend('BEPILD','SVM(Linear)','PILD','kNN','fontsize',18,'fontname','Times New Roman','location','NorthEastOutside');
grid on;

figure;%数字加进方框中。
bar(traintime_res,1);
colormap(bone);
set(gca,'XTickLabel',{'Letter','Shuttle','Satellite','PaB','Waveform','Spambase','Cmc'},'fontsize',16,'fontname','Times New Roman');
%title('iii) Training Time Comparison','fontsize',24,'fontname','Times New Roman','fontweight','bold');
title('v) Partial enlarged view of Sub-fig. iii)','fontsize',24,'fontname','Times New Roman','fontweight','bold');
xlabel('Datasets','fontsize',20,'fontname','Times New Roman','fontweight','bold');
ylabel('Training Time (s)','fontsize',20,'fontname','Times New Roman','fontweight','bold');
legend('BEPILD','SVM(Linear)','PILD','kNN','fontsize',18,'fontname','Times New Roman','location','NorthEastOutside');
axis([0,8,0,1]);%放大图时候用，作为局部图
grid on;



figure;
bar(testtime_res,1);
colormap(bone);
set(gca,'XTickLabel',{'Letter','Shuttle','Satellite','PaB','Waveform','Spambase','Cmc'},'fontsize',16,'fontname','Times New Roman');
%title('iv) Testing Time Comparison','fontsize',24,'fontname','Times New Roman','fontweight','bold');
title('vi) Partial enlarged view of Sub-fig. iv)','fontsize',24,'fontname','Times New Roman','fontweight','bold');
xlabel('Datasets','fontsize',20,'fontname','Times New Roman','fontweight','bold');
ylabel('Testing Time (s)','fontsize',20,'fontname','Times New Roman','fontweight','bold');
legend('BEPILD','SVM(Linear)','PILD','kNN','fontsize',18,'fontname','Times New Roman','location','NorthEastOutside');
axis([0,8,0,6]);%放大图时候用，作为局部图
grid on;



