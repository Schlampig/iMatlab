function RSamples = SMOTE_Fuc(data, k, beta)
%
% data without class label
% k is the k-NN parameter
% beta is the number of samples over-sampled for a pattern
%
    [len, dim] = size(data) ;
    RSamples = [] ; % the Synthetic generated samples
    
    for i = 1 : len
        TempRS = [] ;
        
        tmp = data(i,:) ;
        dis = getDis(tmp, data) ;
        tmpDis = [dis, [1:len]'] ;
        a = sortrows(tmpDis, 1) ;
        ind = a(2:k+1,2) ;
        
 % generate the sythetic samples
        alpha = rand(beta, 1) ;
        selectInd = randi(k, beta, 1) ;
        for j =1 : beta
            TempRS = [TempRS; tmp - alpha(j)* (tmp - data(ind(selectInd(j)),:))];
        end
        RSamples = [RSamples; TempRS] ;
    end
end

function dis = getDis(x, data)
%
% calculate the distance of x to data
%
    [len, dim] = size(data) ;
    tmpX = repmat(x, len, 1) ;
    dis = sum((data - tmpX).^2,2).^(1/2) ;
end