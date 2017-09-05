function [P_train, P_test] = gen_empirical_ker_data(X1, X2, ker_type, ker_par)

% Mapping original data in feature space into data in kernel space through Empirical kernelization

% X1/X2: N1xD/N2xD without labels
% % Generate kernel matrix K
K = kernel_fun(X1, X1, ker_type, ker_par); 

% K in N1xN1% % SVDD K into QEQ'(UEV')
[pc,variances,~] = pcacov(K);
i=1;
label=0;
while variances(i)>=1e-3;
    if i+1>size(variances,1);
        label=1;
        break;
    end;
    i=i+1;    
end;

if label==0;
    i=i-1;
end;

index=[1:i];

% Obtain K_bar
U = pc(:,index);
E = diag(variances(index));
K_bar = E^(-1/2)*U';

P_train = K_bar*K;
P_test = K_bar*kernel_fun(X1, X2, ker_type, ker_par);

end