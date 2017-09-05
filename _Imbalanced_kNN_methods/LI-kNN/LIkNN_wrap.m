function LIkNN_wrap

%用来设置IBkNN_main函数所需要的输入变量的函数。

% index = [1;7;8;9;10;11;12;13;14;15;16;17;18;19;20;21;22;23;24;25;26];
index = 1:64;
ktimes = 5;
k = [7;9;11;13;15;17;19];
inf = [1;3];



for i_index = 1:length(index)           
    for i_k = 1:length(k)
        for i_inf = 1:length(inf)
            LIkNN_main(index(i_index),ktimes,k(i_k),inf(i_inf));
        end%for_i_inf
    end%for_i_k
end%for_i_index

end