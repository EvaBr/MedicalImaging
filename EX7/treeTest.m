function [Yhard, Ysoft] = treeTest(model, X, opts)
% Test a tree
% X is NxD, each D-dimensional row is a data point
% model comes from treeTrain()
% Yhard are hard assignments to X's, Ysoft is NxK array of
% probabilities, where there are K classes.
    
if nargin < 3, opts= struct; end

d = model.depth;

[N, D] = size(X);
nd = 2^d - 1;
numInternals = (nd-1)/2; % Enter number of internal/split nodes
numLeafs = (nd+1)/2; % Enter number of leaf nodes

Yhard = zeros(N, 1);
u = model.classes;
if nargout>1, Ysoft= zeros(N, length(u)); end
dataix = sparse(N, nd); 


% Propagate data down the tree using weak classifiers at each node
for n = 1: numInternals
    
    % get relevant data at this node
    if n==1 
        reld = ones(N, 1)==1;
        Xrel= X;
    else
        % Get testing data that reaches a particular node n
        % Hint: use dataix
        reld = logical(dataix(:, n));
        Xrel = X(reld, :);
    end
    if size(Xrel,1)==0, continue; end % empty branch, ah well
    
    yhat = weakTest(model.weakModels{n}, Xrel, opts); % Fill in arguements that sends the weakmodel at node n to split the test data
    
    dataix(reld, 2*n)= yhat;
    dataix(reld, 2*n+1)= 1 - yhat; % since yhat is in {0,1} and double
end

% Go over leafs and assign class probabilities
nd= 2^d - 1;
numInternals = (nd-1)/2; % Enter number of internal/split nodes
numLeafs= (nd+1)/2; % Enter number of leaf nodes


for n = 1 : numLeafs
    ff = find(dataix(:, n+numInternals)==1);
    
    hc =  model.leafdist(n, :); % Get leafdist from appropriate leaf model
    vm = max(hc);
    miopt = find(hc==vm);
    mi = miopt(randi(length(miopt), 1)); %choose a class arbitrarily if ties exist
    Yhard(ff) = u(mi);
    
    if nargout > 1
        Ysoft(ff, :)= repmat(hc, length(ff), 1);
    end
end
