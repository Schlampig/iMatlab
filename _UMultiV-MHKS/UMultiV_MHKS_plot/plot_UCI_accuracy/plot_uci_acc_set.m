clear all;
clc;

% Number of Principal component vectors
X=[ 1          3          5          7;         % inner_k
];

% Percentage of Accuracy
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%k_inner
Y=[
    %Lenses
    %0.1    0.3     0.5     0.7
    77.01	78.23	78.18	77.97; %UMultiV-MHKS
    73.15	75.24	76.43	75.631; %MultiV-MHKS
    74.65	75.43	75.45	75.67; %MatMHKS
    72.7273	74.47	76.59	76.29; %MHKS 

    %Glass  
    63.95	66.77	68.44	68.57; %UMultiV-MHKS
    62.29	63.68	66.84	65.17; %MultiV-MHKS
    61.51	63.27	65.97	63.42; %MatMHKS
    61.16	65.86	65.53	64.03; %MHKS
 
    
    %Iris
    81.93	94.48	96.00	96.67; %UMultiV-MHKS
    90.19	94.8	95.73	96.01; %MultiV-MHKS
    91.4	95.56	95.86	94.83; %MatMHKS
    91.133	93.78	95.4	94.23; %MHKS 
 
    %Water
    92.13	94.04	98.25	98.18; %UMultiV-MHKS
    93.01	96.32	97.14	97.39; %MultiV-MHKS
    85.56	91.48	93.68	93.37; %MatMHKS
    87.94	90.74	94.56	93.31; %MHKS 

    %Pima
    67.14	70.79	70.93	71.215; %UMultiV-MHKS
    64.16	67.35	69.66	68.29; %MultiV-MHKS
    65.43	67.68	70.01	70.43; %MatMHKS
    66.0156	67.56	70.09	69.219; %MHKS 

    %Housing
    89.67	90.34	92.91	91.57; %UMultiV-MHKS
    90.23	92.59	92.91	91.45; %MultiV-MHKS
    88.55	89.49	93.25	93.59; %MatMHKS
    87.17	91.9	92.01	90.21; %MHKS 

   
    %Sonar
    71.49	75.68	76.87	75.24; %UMultiV-MHKS
    69.33	74.757	75.63	74.85; %MultiV-MHKS
    64.592	73.47	74.75	73.88; %MatMHKS
    68.0388	72.09	73.59	74.27; %MHKS 

    %BCW
    92.215	95.36	96.32	93.19; %UMultiV-MHKS
    89.387	93.387	95.15	94.84; %MultiV-MHKS
    87.13	89.501	94.38	93.029; %MatMHKS
    87.27	95.501	95.5	93.71; %MHKS 
  
    %IoS
    87.13	84.04	89.94	86.59; %UMultiV-MHKS
    84.37	90.36	87.17	86.24; %MultiV-MHKS
    85.06	86.21	87.05	83.84; %MatMHKS
    81.84	83.28	86.34	83.99; %MHKS 
 
    
    %TRA
    83.27	87.43	88.75	88.69; %UMultiV-MHKS
    84.38	85.26	87.59	88.04; %MultiV-MHKS
    84.75	87.94	88.23	88.19; %MatMHKS
    71.67	73.24	77.06	75.35; %MHKS 
    
    %Secom
    89.73	90.19	93.79	93.28; %UMultiV-MHKS
    85.35	91.88	93.26	92.01; %MultiV-MHKS
    84.26	87.325	93.15	92.63; %MatMHKS
    88.27	92.55	92.34	85.31; %MHKS

    
    %HC
    65.64	69.59	70.99	71.84; %UMultiV-MHKS
    62.97	67.301	69.94	67.59; %MultiV-MHKS
    61.344	65.88	65.46	65.43; %MatMHKS
    66.25	67.97	70.03	69.17; %MHKS 

    %Cmc
    45.14	49.25	52.48	51.68; %UMultiV-MHKS
    46.45	47.73	49.31	46.17; %MultiV-MHKS
    49.55	50.074	51.59	51.07; %MatMHKS
    45.292	46.12	47.07	46.28; %MHKS 

    %HV
    86.32	92.03	93.87	93.91; %UMultiV-MHKS
    90.29	94.51	92.33	92.09; %MultiV-MHKS
    85.12	92.39	92.83	91.2; %MatMHKS
    87.71	90.57	92.12	91.691; %MHKS 

];