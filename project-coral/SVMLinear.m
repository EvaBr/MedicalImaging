function [ acc, mse ] = SVMLinear( X, Xt, yt, model )
%SVMLinear Summary of this function goes here
%   Use a linear SVM to classify datasets
%   X : source data
%   Xt : test data
%   yt : label of test data
%   model : model to predict
%   accuacy : accuracy of the method

addpath('../../../usr/local/MATLAB/R2015b/extern/lib/libsvm-3.20/matlab');


K = zeros(size(X,1), size(X,1));
for i=1:size(X, 1)
    for j=1:size(Xt,1)
        K(i,j) = X(i,:)*transpose(Xt(j,:));
    end
end
K1 = [(1:size(X,1))', K];
[predict, accuracy, prob_values] = svmpredict(yt, K1, model, '-b 1');

acc = accuracy(1);
mse = accuracy(2);

end

