function [combine_mat_num,r_valid] = Matrixlize_fun(vec_num)

%用于矩阵化的函数
%vec_num：传入的目标向量
%combine_mat_num：存放矩阵化可能行列数组和的矩阵（该函数返回值）
%r_valid：有效行数
%r_vec_num：目标向量行数
%c_vec_num：目标向量列数
%sum_vec_num：目标向量长度（因为是一维的所以是行或列数）
%zeromat_num：限制零元矩阵规模的值
%tempt_value：判断是否整除的中间值
%r_combine_num:矩阵化后新行数
%c_combine_num:矩阵化后新列数
%m和n循环控制变量
%mat_num:矩阵化后生成的矩阵

while(1),
    [r_vec_num,c_vec_num]=size(vec_num); %把数组（向量）vec_num的行数赋值给r_vec_num，列数赋值给c_vec_num

    if(r_vec_num+c_vec_num == 2) %如果输入的是一个数而不是向量，则报错
        disp('The input value is not a vector!It is a number! ');
        break;%跳出循环
    end

    sum_vec_num = 0;    %判断是不是一维向量，如果是一维向量就把长度赋给sum_vec_num，否则不是一维向量就报错
    if(c_vec_num == 1)
        sum_vec_num = r_vec_num;
    elseif(r_vec_num == 1)
        sum_vec_num = c_vec_num;
    else
        disp('The input value is not a vector! It is a matrix! ');
        break;%跳出循环
    end

    zeromat_num = sum_vec_num;    %定义零元矩阵的大小
    combine_mat_num = zeros(zeromat_num,2); %定义一个零元矩阵，有zeromat_num行和2列，第一列存放行数的可能组合，第二列存放列数的可能组合，行数就是组合数
    r_valid = 0;%定义有效行数
    %for n = 2:(sum_vec_num-2) %方法一：1和sum_vec_num自身不参与矩阵化，而sum_vec_num-1绝对不会被sum_vec_num整除
    for n = 1:sum_vec_num %方法二：允许矩阵化后出现向量
         tempt_value = mod(sum_vec_num,n);%判断当前的n是否能整除sum_vec_num，结果给tempt_value
        if(tempt_value == 0)%如果可以整除，将除数和解分别作为新构成矩阵的行数和列数，将此组合存入刚才创建的矩阵combine_mat_num中
            r_valid = r_valid+1;%记录有效的行数，即组合数
            r_combine_num = sum_vec_num/n;
            c_combine_num = n;
            combine_mat_num(r_valid,1) = r_combine_num;
            combine_mat_num(r_valid,2) = c_combine_num;
        else
            continue;
        end %end_if
    end %end_for

    %disp([r_valid]); %测试用
    
    if(r_valid == 0)  %如果没有找到有效的组合方法就报错
        disp('This vector can not be matrixlized!');
        break;%跳出循环
%    else %存在组合方法
%        for m = 1:r_valid     %显示矩阵化后的各个矩阵
%            mat_num = reshape(vec_num,combine_mat_num(m,1),combine_mat_num(m,2));
%            disp(['第 ',num2str(m),' 种分解方法是：']);
%            disp([mat_num]);
%        end
    end

    %y=1;%测试用，为了返回函数的值
    break;
end