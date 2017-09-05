function [j] = J_objective_fun(Result,train_binary_data,train_binary_label,universum_data,C,zet,gama,M,N,Nu,Row,Col,k)

%Ä¿±êº¯Êý

tempt4 = 0;
for k_M = 1:M
    tempt1 = 0;
    tempt2 = 0;
    tempt3 = 0;
    for k_N =1:N
        A = reshape(train_binary_data(k_N,:),Row(k_M),Col(k_M));
        tempt1 = tempt1 + (train_binary_label(k_N)*(Result(k_M).U(:,k)'*A*Result(k_M).V(1:Col(k_M),k) + Result(k_M).V(Col(k_M)+1,k)) - 1 - Result(k_M).B(k_N,k+1))^2;
        tempt2 = tempt2 + train_binary_label(k_N)*Result(k_M).U(:,k)'*A*Result(k_M).V(1:Col(k_M),k) + Result(k_M).V(Col(k_M)+1,k);
    end%end_for_k_N
    
    for k_Nu = 1:Nu
        Au = reshape(universum_data(k_Nu,:),Row(k_M),Col(k_M));
        tempt3 = tempt3 + (Result(k_M).U(:,k)'*Au*Result(k_M).V(1:Col(k_M),k) + Result(k_M).V(Col(k_M)+1,k))^2;
    end%end_for_k_Nu
    tempt4 = tempt4 + tempt1 + C*( Result(k_M).U(:,k)'*Result(k_M).S1*Result(k_M).U(:,k) + Result(k_M).V(1:Col(k_M),k)'*Result(k_M).S2(1:Col(k_M),1:Col(k_M))*Result(k_M).V(1:Col(k_M),k) ) + zet*tempt3 + gama*tempt2 - SumuAv(Result,train_binary_data,M,N,Row,Col,k_M,k);
end%end_for_k_M

j = tempt4;