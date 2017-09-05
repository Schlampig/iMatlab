
%addpath(genpath(pwd))

data_struct = dir('3\*.mat');
% data_struct = dir('raw_dim_reduced_data\*.mat');

for i_dataset = 1:length(data_struct)
    dataname = data_struct(i_dataset).name(1:end-4);
    generate10fcv(dataname);
end%for_i_dataset