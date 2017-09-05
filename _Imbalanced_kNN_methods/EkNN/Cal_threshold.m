function [delta] = Cal_threshold(z,f,N)

%根据置信度、z-score、负类分布和总体样本数计算置信边界

delta = ( f + z*z/(2*N) + z*sqrt(f*(1-f)/N + z*z/(4*N*N)) )/(1 + z*z/N);

end