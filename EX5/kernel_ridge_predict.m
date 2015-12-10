function [ predict, mse ] = kernel_ridge_predict( X, alphas, Xt, yt, kern )
%KERNEL_RIDGE_PREDICT(X, y, xt, yt, K)
%  X ... training set matrix
%  a ... estimated alpha
%  xt ... samples for testing and 
%  yt ... their respective outcomes
% kern ... kernel function
%
%The function returns a vector of predicted
%  outcomes and the mean squared error on 
%  the testing sample.   

n = size(X, 1);
m = size(Xt, 1);
K = zeros(n, m);
alpha = zeros(size(alphas,3),1);
alpha(:)= alphas(:,:,:);
for i=1:n
    for j=1:m
        K(i, j) = kern(X(i, :), Xt(j, :));
    end
end

predict = alpha'*K;

mse = 1/n * sum((yt'-predict).^2);
end

