clear all;
clc;

% Number of Principal component vectors
X = [1 2 3 4 5];

% Percentage of AA from BERFLD

% k
k_Abalone19 = [ 
    % k = 1 3 5 7 9
    75.15983945	69.82621849	66.78393485	63.20598374	62.16786087;
    77.43756353	76.21413129	69.48355465	70.39389505	68.63104708;
    75.97302245	79.29740864	74.61987012	73.22750143	71.00532292;
    76.03340892	77.64289211	77.78771766	74.61989925	74.5354019;
    75.98505604	76.06958253	76.06953883	76.19018066	77.63074197
    ];
    
k_WineR = [ 
    % k = 1 3 5 7 9
    69.46817375	68.00873122	66.74711727	66.4881132	66.13202175;
    68.44470385	68.50356367	68.98524234	67.23785933	68.92062181;
    69.06274141	68.47685752	67.6982604	67.56881056	67.43946512;
    69.70967742	69.25649859	68.38008333	68.54179123	68.67103228;
    69.8067648	69.70957302	69.64484811	69.74214427	69.70967742
    ];

k_WineW = [ 
    % k = 1 3 5 7 9
    65.2610507	66.36828602	66.23082898	66.23082898	66.23082898;
    65.50160053	65.5010121	65.3640258	65.3640258	65.39827237;
    65.5358471	65.39874312	65.39874312	65.39874312	65.39874312;
    65.3988608	65.43310738	65.43298969	65.43298969	65.43298969;
    65.77533776	65.91244175	65.91244175	65.67189192	65.67189192 
    ];
    
k_Yeast1 = [ 
    % k = 1 3 5 7 9
    71.12368955	69.4908228	69.43902075	69.53517547	69.18497027;
    71.38214872	71.21710829	70.50757581	70.17582225	69.72778963;
    71.54551643	71.85030569	71.42817409	71.17108292	70.5808702;
    71.42786937	71.26556493	71.87316602	71.82881335	71.77837929;
    71.24133661	71.3115903	71.42786937	71.52402409	71.26419694
    ];
    
k_Yeast3 = [ 
    % k = 1 3 5 7 9
    89.37971698	89.11528016	88.6231418	89.3141438	88.66073471;
    90.21247856	89.80585334	89.64458262	89.73038165	89.49363922;
    90.02294168	89.68217553	90.22194826	90.07086192	90.03312607;
    89.83397656	90.02294168	90.06096341	90.02322756	89.94732704;
    89.83383362	89.87185535	89.68260435	90.07086192	89.83383362
    ];

k_Yeast4 = [ 
    % k = 1 3 5 7 9
    84.62276748	82.85487683	82.71477303	82.43590556	82.0526303;
    83.0649107	83.69269755	84.55295924	84.41346458	82.78506859;
    83.41577934	83.37886504	83.58841159	83.55320289	84.13471894;
    83.31137156	83.52079628	83.06503253	83.41370824	83.44891694;
    83.10145952	83.27652835	83.34621476	83.416023	83.55576131 
    ];

k_Yeast5 = [ 
    % k = 1 3 5 7 9
    94.0625	    93.85416667	93.92361111	93.81944444	93.71527778;
    95.06944444	93.88888889	93.88888889	93.81944444	93.71527778;
    96.18055556	93.95833333	93.88888889	93.88888889	93.88888889;
    96.18055556	94.89583333	93.88888889	93.85416667	93.92361111;
    96.21527778	96.18055556	96.18055556	94.89583333	94.89583333
    ];

k_Yeast6 = [ 
    % k = 1 3 5 7 9
    87.33560605	87.85344401	87.75011506	87.54309919	87.68103022;
    86.57734331	87.33548673	87.50801984	87.50837779	87.6809109;
    87.66049057	87.06034057	87.33584468	87.26675985	87.47353708;
    87.76381952	87.66037125	86.88792677	86.92240953	87.23263504;
    87.86714848	87.76381952	87.76405816	87.59140573	87.66049057 
    ];


% a
a_Abalone19 = k_Abalone19';   
a_WineR = k_WineR';
a_WineW = k_WineW';    
a_Yeast1 = k_Yeast1';    
a_Yeast3 = k_Yeast3';
a_Yeast4 = k_Yeast4';
a_Yeast5 = k_Yeast5';
a_Yeast6 = k_Yeast6';


