clear;
clc;

% Number of Principal component vectors
X=[ 1          3          5          7      9;         % inner_k
];

% Percentage of Accuracy
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%k_inner
Y=[
    %0.1        0.3         0.5     0.7         0.9
    92.741703	95.813234	96.467532	96.536797	96.753247;%MLMFCI-Segmentation
    92.438672   94.730983	95.186147	95.440115   95.541126;%MatMHKS-Segmentation
    94.694416   95.544244   96.146252   96.319317   96.489945;%MLMFCI-PaB
    91.161421	92.145654	93.085923   95.783059   96.124314;%MatMHKS-PaB
    83.944051	87.249723	88.296020	88.720207	89.177019;%MLMFCI-Statlog
    83.008116	85.192009	85.712065	86.031088	86.366460;%MatMHKS-Statlog
    83.763058	85.654286	86.070428	86.653333	86.726547;%MLMFCI-Waveform
    84.505446	86.074286	86.534614	86.993333	87.005988;%MatMHKS-Waveform 
];