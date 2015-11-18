
function [alpha, mse] = kernel_ridge_fit(X, y, kern, lambda)
% KERNEL_RIDGE_FIT(X, Y, KERN):
% X ... matrix of samples,
% y ... vector of outcomes for each sample,
% kern ... kernel function
% lambda ... amount of regularization
%
%Function returns the estimated vector alpha
%  and the mean squared error on the training
%  set.


% x vektor z m stolpci (features) in n vrsticami (samples)
% y je stolpični vektor
n = size(X, 1);
K = zeros(n, n);
for i=1:n
    for j=1:n
        K(i, j) = kern(X(i, :), X(j, :));
    end
end
alpha = (K + lambda*eye(n))\y;

temp = K*alpha;
mse = sum((y-temp).^2)/n; %lambda*dot(temp, alpha); for the objective function

end