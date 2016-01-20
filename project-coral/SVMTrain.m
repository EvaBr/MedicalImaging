function [ model ] = SVMTrain( X, y, C )
%SVMTrain Summary of this function goes here
%   Calculate the model for the prediction
% input
%	x : Data matrix n*m
%	y : vector of n*1? Or 1*n
%	C : controls the trade-off between the slack variable penalty and the margin
% output
%	model :


K = zeros(size(X,1), size(X,1));
for i=1:size(X, 1)
    for j=1:size(X,1)
        K(i,j) = X(i,:)*transpose(X(j,:));
    end
end
K1 = [(1:size(X,1))', K];
model = svmtrain(y, K1, ['-c ' num2str(C) ' -b 1 -t 4']);


end

