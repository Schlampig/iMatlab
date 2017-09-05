%调用各种LPP算法的总方法

rdim = 81;
k = 5;
a = [0.01;0.1;1;10;100;1000];

for i_a = 1:length(a)
    a_num = a(i_a);
    for i_dim = 1:length(rdim)
        Rdim = rdim(i_dim);
        for i_data = 1:6
            switch i_data%根据数据集标号选择数据集  
                case 1
                    dataname = 'Coil20';
                    dataname_index = 1;
                case 2
                    dataname = 'ORL';
                    dataname_index = 1;
                case 3
                    dataname = 'PIE_mini';
                    dataname_index = 1;
                case 4
                    dataname = 'Yale';
                    dataname_index = 1;
                case 5
                    dataname = 'YaleB';
                    dataname_index = 1;
                case 6
                    dataname = 'COIL100_mini';
                    dataname_index = 0;
                otherwise
                    disp('You have input wrong dataset number!');%报错 
            end%end_switch_dataset_kind  
        
            fMMC(a_num,Rdim,dataname,dataname_index);   
            fDLPPMMC(a_num,k,Rdim,dataname,dataname_index);
            fNew(a_num,k,Rdim,dataname,dataname_index,1)
            fNew(a_num,k,Rdim,dataname,dataname_index,2)
            fNew(a_num,k,Rdim,dataname,dataname_index,3)
            fNew(a_num,k,Rdim,dataname,dataname_index,4)
            fNew(a_num,k,Rdim,dataname,dataname_index,5)
            fNew(a_num,k,Rdim,dataname,dataname_index,6)
            fNew(a_num,k,Rdim,dataname,dataname_index,7)
      
        end%for_i_data
    end%for_i_dim
end%for_i_a
