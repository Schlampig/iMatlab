function [dp] = get_dp(dp_index,label)

%生成理想label的函数

Npos = length(find(label==1));%训练样本中正类的个数
Nneg = length(find(label==0));%训练样本中负类的个数
Nall = Npos + Nneg;%训练样本总数
dp = label;

if dp_index == 1%±1为权重，+1是正类，-1是负类
    dp(find(label==1)) = 1;
    dp(find(label==0)) = -1;
elseif dp_index == 2%N/Npos是正类，-N/Nneg是负类
    dp(find(label==1)) = Nall/Npos;
    dp(find(label==0)) = -(Nall/Nneg);
end

end % function