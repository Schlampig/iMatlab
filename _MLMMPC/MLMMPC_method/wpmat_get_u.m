function [u] = wpmat_get_u(train_binary_data,train_binary_label,InputPar,M_row,M_col,S1,I,v,b,M,D)

%迭代中用来获取权重向量u的函数
clear u;

I_phi = eye(size(M,1));%生成关系单位矩阵

for p_u = 1:size(train_binary_label)
    if p_u == 1
        A = reshape(train_binary_data(p_u,:),M_row,M_col);
        B=[A zeros(size(A,1),1);zeros(1,size(A,2)) 1];
        z = train_binary_label(p_u)*B*v;
        Z = z;
        z_phi = B*v;%不含类标号的样本矩阵存在另一个增广矩阵中
        Z_phi = z_phi;        
        clear A;clear B;
    else
        A = reshape(train_binary_data(p_u,:),M_row,M_col);
        B=[A zeros(size(A,1),1);zeros(1,size(A,2)) 1];
        z = train_binary_label(p_u)*B*v;
        Z = [Z,z];
        z_phi = B*v;%不含类标号的样本矩阵存在另一个增广矩阵中
        Z_phi = [Z_phi,z_phi];        
        clear A;clear B;
    end%end_if
end%end_p_u

for i_u = 1:size(train_binary_label)-1%求pairwise部分
    for j_u = i_u+1:size(train_binary_label)
        if i_u == 1 && j_u == 2
            A_i = reshape(train_binary_data(i_u,:),M_row,M_col);
            A_j = reshape(train_binary_data(j_u,:),M_row,M_col);
            B_i =[A_i zeros(size(A_i,1),1);zeros(1,size(A_i,2)) 1];
            B_j =[A_j zeros(size(A_j,1),1);zeros(1,size(A_j,2)) 1];
            z = D(i_u,j_u)*(B_i - M(i_u,j_u)*B_j)*v;
            Z_phi = z;
            clear A_i;clear A_j;clear B_i;clear B_j;
        else
            A_i = reshape(train_binary_data(i_u,:),M_row,M_col);
            A_j = reshape(train_binary_data(j_u,:),M_row,M_col);
            B_i =[A_i zeros(size(A_i,1),1);zeros(1,size(A_i,2)) 1];
            B_j =[A_j zeros(size(A_j,1),1);zeros(1,size(A_j,2)) 1];            
            z = D(i_u,j_u)*(B_i - M(i_u,j_u)*B_j)*v;
            Z_phi = [Z_phi,z];
            clear A_i;clear A_j;clear B_i;clear B_j;
        end
    end%for_j_v
end%for_i_v

Z = Z';
Z_phi = Z_phi';

u = pinv(InputPar.C*S1 + Z'*Z + InputPar.lam*Z_phi'*Z_phi)*Z'*(I+b);
u = [u(1:M_row);1];%让u的最后一位总是为1
