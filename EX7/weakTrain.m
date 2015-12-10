function model = weakTrain(X, Y, opts)
% weak random learner
% can currently train:
% 1. decision stump: look along random dimension of data, choose threshold
% that maximizes information gain in class labels
% 2. 2D linear decision learner



classifierID= 1; % by default use decision stumps only
numSplits= 30; 

if nargin < 3, opts = struct; end
if isfield(opts, 'classifierID'), classifierID = opts.classifierID; end
if isfield(opts, 'numSplits'), numSplits = opts.numSplits; end

u= unique(Y);
[N, D]= size(X);

if N == 0
    % edge case. No data reached this leaf. Don't do anything...
    model.classifierID= 0;
    return;
end
        
bestgain= -100;
model = struct;
% Go over all applicable classifiers and generate candidate weak models
for classf = classifierID

    modelCandidate= struct;    
    maxgain= -1;

    if classf == 1
        % Decision stump
        
        % proceed to pick optimal splitting value t, based on Information Gain  
        for q= 1:numSplits
            
            % define an axis-aligned decision split
           r = randi(D); % choose a feature at random
           col= X(:, r);
           
           tmin= min(col);
           tmax= max(col);
           
           t = (tmax-tmin)/2; % get threshold for the split between tmin and tmax
           dec = col<t;
           Igain = evalDecision(Y, dec, u); % evaluate information gain for this split
            if Igain>maxgain
                maxgain = Igain;
                modelCandidate.r= r;
                modelCandidate.t= t;
            end
        end

    elseif classf == 2
        % Linear classifier using 2 dimensions

        % Repeat some number of times: 
        % pick two dimensions, pick 3 random parameters, and see what happens
        for q= 1:numSplits
            %siz = size(X,2); = D
            r = datasample(1:D,2,'Replace',false);
            r1 = r(1); % randomly select 1st dimension,
            r2 = r(2); % randomly select 2nd dimension
            
            w = normrnd([mean(X(:,r1)), mean(X(:,r2))], 0.1, [1,2]); % randomly select weights for the two dimensions, sigma=0.1?
            
            dec = w*[X(:,r1)'; X(:,r2)'] < 0; % implement 2D linear decision classifier
            Igain = evalDecision(Y, dec, u);
            
            if Igain>maxgain
                maxgain = Igain;
                modelCandidate.r1= r1;
                modelCandidate.r2= r2;
                modelCandidate.w= w;
            end
        end

   
        
    else
        fprintf('Error in weak train! Classifier with ID = %d does not exist.\n', classf);
    end

    % see if this particular classifier has the best information gain so
    % far, and if so, save it as the best choice for this node
    if maxgain >= bestgain
        bestgain = maxgain;
        model= modelCandidate;
        model.classifierID = classf;
    end

end

end

function Igain = evalDecision(Y, dec, u)
% Implement code that gives Information Gain provided a boolean decision array for what goes
% left or right. u is unique vector of class labels at this node
    N = length(dec);
    NL = sum(dec);
    NR = N-NL;
    Igain = classEntropy(Y, u) - NL/N* classEntropy(Y(dec), u) - NR/N*classEntropy(Y(~dec), u); % abi mogu bit unique(Y(~dec)) ?!
end

% Helper function for class entropy used with Decision Stump
function H = classEntropy(y, u)
% Implement code to generate class entropy
    Nc = zeros(length(u),1);
    N = size(y,1);
    for i = 1:length(u)
        Nc(i) = sum(y == u(i));
    end
    if min(Nc) == 0
        %stop learning? HOW?
    end
    Nc = Nc(Nc>0); %just bcs I dont stop the learning yet...
    H = - sum(Nc/N.*log(Nc/N)); 
end
