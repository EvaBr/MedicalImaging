function model = treeTrain(X, Y, opts)
% Train a random tree
% X is NxD, each D-dimensional row is a data point
% Y is Nx1 discrete labels of classes
% returned model is to be directly plugged into treeTest

d= 5; % max depth of the tree

if nargin < 3, opts= struct; end
if isfield(opts, 'depth'), d= opts.depth; end

u=unique(Y);  % Find number of classes from Y
[N, D]= size(X);
nd= 2^d - 1;
numInternals = (nd-1)/2; % Enter number of internal/split nodes
numLeafs= (nd+1)/2; % Enter number of leaf nodes

weakModels= cell(1, numInternals); 

dataix= zeros(N, nd); % boolean indicator of data at each node

leafdist= zeros(numLeafs, length(u)); % leaf distribution

% Propagate data down the tree while training weak classifiers at each node
for n = 1: numInternals
    
    % get relevant data at this node
    if n==1 
        reld = logical(ones(N, 1)==1);
        Xrel= X;
        Yrel= Y;
    else
        % Get data reaching a particular node n
        % Hint: Use dataix boolean indicator
        reld = logical(dataix(:, n));
        Xrel = X(reld, :);
        Yrel = Y(reld, :);
    end
    
    % train weak model
    weakModels{n}= weakTrain(Xrel, Yrel, opts); % Fill arguements to generate a weaklearner at a particular node n
    
    % split data to child nodes
    yhat= weakTest(weakModels{n}, Xrel, opts); % Fill arguements to test the weaklearner and split data to reach children nodes 2n and 2n+1
    
    dataix(reld, 2*n) =  yhat==1; % Binary indicator for points reaching node 2n
    dataix(reld, 2*n+1)= yhat==0; % Binary indicator for points reaching node 2n+1
end

% Go over leaf nodes and assign class statistics
for n= (nd+1)/2 : nd
    
   % Generate leaf node histogram based on data that reached a particular
   % leaf node and save it in leafdist
   all = Y(logical(dataix(:, n)));
   for i = 1:length(u)
       leafdist(n - (nd+1)/2 + 1, i) = sum(all==u(i));
   end
end

model.leafdist= leafdist;
model.depth= d;
model.classes= u;
model.weakModels= weakModels;
end
