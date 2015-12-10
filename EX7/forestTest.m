function [Yhard, Ysoft] = forestTest(model, X, opts)
    % X is NxD, where rows are data points
    % model comes from forestTrain()
    % Yhard are hard assignments to X's, Ysoft is NxK array of
    % probabilities, where there are K classes.
    
    if nargin<3, opts= struct; end
    
    numTrees= length(model.treeModels);
    u= model.treeModels{1}.classes; % Assume we have at least one tree!
    Ysoft= zeros(size(X,1), length(u));
    for i=1:numTrees
        % Write code to generate tree-wise predictions use treeTest
        % function
        
    end
    
 % Aggregate the tree wise predictions to get Yhard and Ysoft
 
end
