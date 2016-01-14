function [Yhard, Ysoft] = forestTest(model, X, opts)
    % X is NxD, where rows are data points
    % model comes from forestTrain()
    % Yhard are hard assignments to X's, Ysoft is NxK array of
    % probabilities, where there are K classes.
    
    if nargin<3, opts= struct; end
    
    numTrees= length(model.treeModels);
    u= model.treeModels{1}.classes; % Assume we have at least one tree!
    Ysofties= zeros(size(X,1), length(u), numTrees);
    Ysoft= zeros(size(X,1), length(u));
    Yhard = zeros(size(X,1), 1);
    for i=1:numTrees
        % Write code to generate tree-wise predictions use treeTest
        % function
        [~, Ysofties(:,:,i)] = treeTest(model.treeModels{i}, X, opts); %only need probabilities; yhard will be produced from them
    end
    
 % Aggregate the tree wise predictions to get Yhard and Ysoft
    for i=1:numTrees
        Ysoft = Ysoft + Ysofties(:,:,i);
    end
    Ysoft = Ysoft./numTrees; %need to normalize, so we wont have probabilities, bigger than 1!
    [~, indx] = max(Ysoft'); %need maximum by rows; so we get to which class each row should belong
    
    if min(size(Ysoft))==1 %can happen cs of random resampling :S
        Yhard = ones(size(Ysoft)).*u;
        disp('lame resampling...');
    else
        Yhard = u(indx);
    end
end
