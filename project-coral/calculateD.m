function [ dMax, DS, DT ] = calculateD( ys, yt )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% Change this if you want to test new parameters
gamma = 10^5;
delta = 0.1;

% On source data because it is written in the article
B = max(rowfun(norm(), ys'));
n = min(size(ys, 1), size(yt, 1));


%%%% Sorted the eigenvalues of ys and yt
[DS , lambdaS] = eig(ys);
[lambdaS, order] = sort(diag(lambdaS),'descend');
DS = DS(:,order);
[DT, lambdaT] = eig(yt);
[lambdaT, order] = sort(diag(lambdaT),'descend');
DT = DT(:,order);

% Calculate other side of the inequation
a = (1+sqrt(log(2/delta)/2)) * 16 * B / (sqrt(n) * gamma);

% Calculate the difference between consecutives eigenvalues
d = 1:n-1;
deltaLambda = min( lambdaS(d)-lambdaS(d+1), lambdaT(d)-lambdaT(d+1));

% Find dMax
m = (deltaLambda/a >= d^(3/2));
dMax = find(m, 1, 'last');

end

