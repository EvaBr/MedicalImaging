function [ C ] = calculateC( ys, yt, label )
%CalculateC Summary of this function goes here
%   Calculate C as explained by (Fernando et al., 2013)
%   with C parameter set to the mean similarity value obtained from the
%   training set
%   ys : source data
%   yt : test data
%   Xs : eigenvector source space
%   Xt : eigenvector test data
%   C : parameter researched
addpath('../EX3');

% Find d
    % Find dMax
[dMax, DS, DT] = calculateD(ys, yt);
    % Calculate dOpt
d = calculateDOpt( dMax, ys, label ) ;

% Use eigenmodes through PCA
%%% BEWARE : ys and yt needs to have samples as columns
pcaObject = myPCA(ys);
pcaObject2 = myPCA(yt);
[Xs,weights]=projectData(pcaObject,ys,d);
[Xt,weights]=projectData(pcaObject2,yt,d);


A = Xs * Xs' * Xt * Xt';
sim =  ys' * A * yt;
C = mean(sim);

end

