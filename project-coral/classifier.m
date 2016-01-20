function [ accuracy ] = classifier( Ds, Dt, y, yt )
%MAIN Summary of this function goes here
%   Just put the dataset and this will classify
%   Ds : source data
%   Dt : target data
%   y : source target data
%   yt : label target data
%   accuracy : value wanted
%%% One sample = one image
Ds = double(Ds);
Dt = double(Dt);
ys = double(y);
yt = double(yt);

% CORAL on source (input) dataset
DsStar = coral(Ds, DT);

% Calculating C
C = calculateC( Ds, Dt, ys );

% Find the model
[ model ] = SVMTrain( DsStar, ys, C );

% Linear SVM
[accuracy, mse] = SVMLinear( DsStar, Dt, yt, model );





