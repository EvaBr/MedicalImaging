function [ DsStar ] = coral( Ds, Dt )
%CORAL Summary of this function goes here
%   The Coral function aims at alining original (sources) and target
%   dataset in order to obtain a better classification while changing the
%   domain of application.
%   Ds : Source data
%   Dt : Target data
%   DsStar : Source data in the target data space

lambda = 1; % regularization factor, value does not have any influence

% Regularization
Cs = cov(Ds) + lambda * eye(size(Ds, 2));
Ct = cov(Dt) + lambda * eye(size(Dt, 2));
% Whitening data
Ds = Ds * Cs^(-1/2);
% Re-coloring data
DsStar = Ds * Ct^(1/2);

end

