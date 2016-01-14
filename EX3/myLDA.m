classdef myLDA
    %MYLDA Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        dataset;
        class;
        averageWholeDataset;
        numClasses;
        numObservationsEachClass;
        
        eigenModes;
        eigValues;
        
        S_w;
        S_b;
       
    end
    
    methods
        function obj=myLDA(data,class)
           %recover the class indices by using unique(class) 
           class = class+1; %the labels are starting from 1 in this implementation!
           
           classIdx = unique(class); %this will be useful in the later checks
           
           %check that the datapoints belong to more than one class
           %... if length(classIdx)>1
           
           %check that there are no holes in the class labels, like some
           %points of class 1, some other of class 3 and none of class 2
           %for example
           
           if (length(classIdx)>1 && max(classIdx)-min(classIdx)+1==length(classIdx))
             %only then we do stuff
           
            %assign the dataset and class to the class members. 
            obj.dataset = data;
            obj.class = class;
            obj.numClasses = length(classIdx);
            
           
            %compute average whole dataset
            obj.averageWholeDataset = mean(obj.dataset, 2);
           
           
            %now we create a cell (D) that, for each class, stores all the
            %data-points (columnwise) that belong to that class. We also
            %store the mean of the data of each class in the cell M and
            %additionally we store a centered version of the data D
            %(DCentered) containing the same datapoints that D contains but
            %substracting their respective mean M from them.
            D = cell(0);
            M = cell(0);
            Dcentered = cell(0);
            obj.numObservationsEachClass = [];
            for i=1:obj.numClasses
               %store in the cell D the observation of each class
               D{i} = {classIdx(i), obj.dataset(:, obj.class == classIdx(i))};
               
               %store number observations each class
               %obj.numObservationsEachClass(i)=...
               obj.numObservationsEachClass(i) = size(D{i}{2}, 2); 
               
               %compute the mean of each of such datasets which contain
               %observations belonging only to one class
               M{i} = {classIdx(i), mean(D{i}{2}, 2)};
               
               %compute version of D that is centered around the mean value
               %M. Be aware of the fact that you have to subtract the M{i}
               %from D{i} and to do so they must have same dimensionality.
               %You have therefore to use repmat!
               Dcentered{i} = {classIdx(i), D{i}{2} - repmat(M{i}{2}, 1, size(D{i}{2}, 2))};
               
            end
           
            %we compute the within class scatter matrix obj.S_w. refer to the
            %slides. it is a square matrix having same dim as the data
           
            obj.S_b = zeros(size(obj.dataset, 1));
            obj.S_w = zeros(size(obj.dataset, 1));
            for i=1:obj.numClasses
                for j=1:obj.numObservationsEachClass(i)
                   dc = Dcentered{i}{2}(:, j);
                   obj.S_w = obj.S_w + dc*dc';  
                end
                
                temp = (M{i}{2} - obj.averageWholeDataset);
                %compute between class scatter matrix S_b:
                obj.S_b = obj.S_b + obj.numObservationsEachClass(i)*temp*temp';
            end    
            %compute inverse of obj.S_w this has to be done as specified
            %here below!!!
            invS_w = inv(obj.S_w+eye(size(obj.S_w,1))*0.0001); %add the identity scaled by a small constant to avoid badly conditioned matrices
           
           
            v = invS_w*obj.S_b; %compute matrix v
           
       
            %[obj.eigenModes, evaluesmat] = svd(v);
            [obj.eigenModes, evaluesmat, ~] = svd(v);
           
            %convert evaluesmat to a vector (using diag()) and store in obj.eigValues;
            obj.eigValues = diag(evaluesmat);
        
           
           end
           
        end
        
        
        function [Dnew]=projectData(obj,D, numEigenmodes) %can process data in from of matrices (given the data project it into subspace using numEigenmodes eigen modes)
            %select current eigenmodes! please check that numEigenmodes
            %is smaller than the total number of eigenvectors. In case it is
            %bigger, currEigenmodes should comprise all the eigenvectors
            currEigenmodes = obj.eigenModes(:, 1:min(numEigenmodes, size(obj.eigenModes, 2)) ); %prej obratno, : na drugem mestu
            
            %project
            Dnew = (D'*currEigenmodes); %have to transpose this, if you want same num of cols as before. but the tryout files use it this way... so no transp.
        end
    end
    
end

