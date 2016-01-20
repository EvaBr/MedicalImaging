function [ dOpt, minErrorValue ] = calculateDOpt( dMax, ys, label )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

% Create the two domains

% BEWARE!! ys has samples as columns!
% label has to be a raw vector
select = randsample(size(ys, 2), floor(size(ys, 2)/2));

dom1 = ys(:, select);
lab1 = label(select);

scnd = setdiff(1:size(ys,2), select);
dom2 = ys(:, scnd);
lab2 = label(scnd);

pcaObject1 = myPCA(dom1);
pcaObject2 = myPCA(dom2);


meanError = zeros(1, dMax);
for d = 1:dMax
    % do the cross validation
    [Xs1, weights] = projectData(pcaObject1, dom1, d);
    [Xs2, weights] = projectData(pcaObject2, dom2, d);

    model1 = SVMTrain(Xs1, lab1, 10^6);
    [acc1, err1] = SVMLinear(Xs1, Xs2, lab2, model1);

    model2 = SVMTrain(Xs2, lab2, 10^6);
    [acc2, err2] = SVMLinear(Xs2, Xs1, lab1, model2);
    
    
    % Obtain the mean error
    meanError(d) = (err1 + err2)/2;
end

[minErrorValue, dOpt] = min(meanError);

end

