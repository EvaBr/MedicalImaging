function yhat = weakTest(model, X, opts)
% X is NxD as usual. 
% see weakTrain for more info.

if nargin < 3, opts = struct; end

[N, D]= size(X);

if model.classifierID== 1 % model.classifierID
    
    % Decision stump classifier
    yhat = X(:, model.r) < model.t; % Apply decision stump using model parameters model.r and model.t

elseif model.classifierID== 2 % model.classifierID
    
    % 2-D linear clussifier stump
    yhat = ( X(:, model.r1)*model.w(1) + X(:, model.r2)*model.w(2) ) < 0; % Apply decision stump using model parameters model.r1, model.r2 and model.w
    
elseif model.classifierID== 0 % model.classifierID
    
    %no classifier was fit because there was no training data that reached
    %that leaf. Not much we can do, guess randomly.
    yhat = double(rand(N, 1) < 0.5);
else
    fprintf('Error in weak test! Classifier with ID = %d does not exist.\n', classifierID);
end


end