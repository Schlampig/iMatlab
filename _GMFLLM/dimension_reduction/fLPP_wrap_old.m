%���ø���LPP�㷨���ܷ���

rdim = [81;144;256;576];
k = 5;
a = 2;

for i_dim = 1:length(rdim)
    Rdim = rdim(i_dim);
    for i_data = 1:6
        switch i_data%�������ݼ����ѡ�����ݼ�  
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
                disp('You have input wrong dataset number!');%���� 
        end%end_switch_dataset_kind  
        
        fMMC(1,Rdim,dataname,dataname_index);   
        fLDA(Rdim,dataname,dataname_index);
        fLPP(k,Rdim,dataname,dataname_index);
        fLPPMMC(0.8,k,Rdim,dataname,dataname_index);
        fDLPP(k,Rdim,dataname,dataname_index);
        fDLPPMMC(1000,k,Rdim,dataname,dataname_index);
        fFLPP(k,Rdim,dataname,dataname_index);
      
    end%for_i_data
end%for_i_dim
