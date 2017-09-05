
%addpath(genpath(pwd))


data_struct = dir('3\*.mat');
% data_struct = dir('fvc10_dim_reduced_data\*.mat');

for i_dataset = 1:length(data_struct)
    dataname = data_struct(i_dataset).name(1:end-10);
    kNN_multi_wrap(dataname);
end%for_i_dataset