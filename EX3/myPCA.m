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
        function obj = myPCA(D)
            %compute data mean and assign D to obj.dataset
            N = size(D, 2);
            obj.dataMean = mean(D); 
            obj.dataset = D - repmat(obj.dataMean, N, 1);

            %compute eigenvalues and eigenvectors usign SVD for example
            %(refer to slides)
            [U, S, V] = svd(obj.dataset);

            %IMPORTANT!!! change sign (in order to respect the convention) 
            %here we change sign to respect the convention (see slides)
            changeSign=~(max(V,[],1)>abs(min(V,[],1)));
            V(:,changeSign)=-V(:,changeSign);

            %assign the eigenvectors to the eigenModes matrix and square and convert
            %the eigenvalues to a vector and assign it to obj.variances 
            obj.variances = diag(S).*diag(S);
            obj.eigenModes = V';
        end
        
        function legalD = synthetize(obj, weights) 
            %select the eigenmodes to be used according to the size of
            %weights
            %...
            %synthetize the legal face from the weights
            %...
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
        end
        

        function [Dnew,weights]=projectData(obj,D,numEigenmodes) %can process data in from of matrices (given the data project it into subspace using numEigenmodes eigen modes)
            %select current eigenmodes! please check that numEigenmodes
            %is smaller than the total number of eigenvectors. In case it is
            %bigger, currEigenmodes should comprise all the eigenvectors
            %...
           
            %project data into subspace Dnew is the projected data having
            %same dimension as a face image 
            %...
            
            %get weights that are as many as the eigenmodes being used
            %here. the weights can be used to synthetize
            %... 
            
        end
    end
    
end

