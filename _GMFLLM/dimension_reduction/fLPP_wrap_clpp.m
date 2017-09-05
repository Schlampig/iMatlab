%调用CLPP算法的总方法

rdim = [144;256;576];
kc = [5;10];


k = 5;
a = 2;

for i_dim = 1:length(rdim)
    Rdim = rdim(i_dim);
    for i_kc = 1:length(kc)
        kc_num = kc(i_kc);
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
    
            fCLPP(a,k,kc_num,Rdim,dataname,dataname_index);

        
        end%for_i_data
    end%for_i_kc
end%for_i_dim


