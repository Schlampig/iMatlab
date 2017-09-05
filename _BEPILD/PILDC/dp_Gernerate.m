function [dp] = dp_Gernerate(dp_index,label)

%生成理想label的函数

Npos = length(find(label==1));%训练样本中正类的个数
Nneg = length(find(label==0));%训练样本中负类的个数
Nall = Npos + Nneg;%训练样本总数

if dp_index == 1%±1为权重，+1是正类，-1是负类
    dp = [ones(Npos,1);-ones(Nneg,1)];
elseif dp_index == 2%N/Npos是正类，N/Nneg是负类
    dp = [(Nall/Npos)*ones(Npos,1); -(Nall/Nneg)*ones(Nneg,1)];
end

end