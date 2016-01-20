classdef myPCA
    %MYPCA Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        dataset;
        eigenModes;
        variances;
        dataMean;
    end
    
    methods
        function obj=myPCA(D)
            %compute data mean and assign D to obj.dataset
            %...
            obj.dataset = D;
            obj.dataMean = mean(obj.dataset,2);
            n = size(obj.dataset, 2);

            obj.dataset = obj.dataset - repmat(obj.dataMean, 1, size(obj.dataset, 2));

            %compute eigenvalues and eigenvectors usign SVD for example
            %(refer to slides)
            %...
            [U, S, V] = svd(transpose(obj.dataset / sqrt(n-1)));

            %IMPORTANT!!! change sign (in order to respect the convention) 
            %here we change sign to respect the convention (see slides)
            changeSign=~(max(V,[],1)>abs(min(V,[],1)));
            V(:,changeSign)=-V(:,changeSign);

            %assign the eigenvectors to the eigenModes matrix and square and convert
            %the eigenvalues to a vector and assign it to obj.variances 
            %...
            obj.eigenModes = V;
            S = diag(S);
            obj.variances = S.*S; % actually, stored as a column vector
        end
        
        function legalD=synthetize(obj, weights) 
            %select the eigenmodes to be used according to the size of
            %weights
            %...
            E = obj.eigenModes(:, 1:size(weights, 1) );
            %synthetize the legal face from the weights
            %...
            legalD = repmat(obj.dataMean, 1, size(weights, 2)) + E * weights;
            %legalD = repmat(obj.dataMean, 1, size(obj.dataset, 2)) + E * weights;
        end
        
        function showModesOfVariation(obj,shape,num)
            %do not do anything. this function is here for your amusement.
            %the argument shape is size(data.images{1}) for the face
            %dataset and [28,28] for the MNIST dataset.
            
            colors=jet(21); %generate a bit of colors for the plot :)
            for i=1:min(num,size(obj.eigenModes,2)) %go through the eigenmodes such that we modifiy their weights one by one (one eigenmode at a time)
                display(sprintf('showing mode of variation %d',i));
                p=1; %p is used just for the colors... (not very elegant)
                for weight=-3*sqrt(obj.variances(i)):(6*sqrt(obj.variances(i)))/20:3*sqrt(obj.variances(i)) %vary the weights between -3sigma and 3sigma
                    weights=zeros(size(obj.eigenModes,2),1);
                    weights(i)=weight;
                    legalD=synthetize(obj,weights);
                    imagesc(reshape(legalD,shape));
                    colormap gray;
                    drawnow;
                    pause(0.2);
                    p=p+1;
                end
                input('c');
                hold off;
            end
        end
        
        function i=findNecessaryEigenmodesForPercentageOfVariation(obj,percentage)  
            %...
            k = 0;
            sumVarian = 0;
            while ((sumVarian <= percentage) && (k < size(obj.variances, 1)) )
                k = k+1;
                sumVarian = sumVarian + obj.variances(k);
            end
            i = k;
        end
        

        function [Dnew,weights]=projectData(obj,D,numEigenmodes)
            %can process data in from of matrices (given the data project it into subspace using numEigenmodes eigen modes)
            
            %select current eigenmodes! please check that numEigenmodes
            %is smaller than the total number of eigenvectors. In case it is
            %bigger, currEigenmodes should comprise all the eigenvectors
            %...
            if (numEigenmodes < size(obj.eigenModes, 2))
                currEigenmodes = obj.eigenModes(:, 1:numEigenmodes);
            else
                currEigenmodes = obj.eigenModes;
            end
           
            %project data into subspace Dnew is the projected data having
            %same dimension as a face image 
            %...
            Dnew = transpose(D-repmat(obj.dataMean, 1, size(D, 2))) * currEigenmodes;
            
            %get weights that are as many as the eigenmodes being used
            %here. the weights can be used to synthetize
            %... 
            weights = transpose(currEigenmodes) * (D-repmat(obj.dataMean, 1, size(D, 2)));
            
        end
    end
    
end

