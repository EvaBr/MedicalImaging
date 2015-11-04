classdef myKMeans
    %KMEANS implements K means:
    %-- Usage --
    %   + obj-myKMeans(D,K,num_rand_init) instanciates the object. for a
    %   detailed description of the parameter refer to the comments of the
    %   constructor
    %
    %   + assignDatapoints(D) given one or more datapoints D organised in a
    %   matrix column-wise, returns the cluster number each datapoint
    %   belongs to.
    %
    %-- End Of Description --
    
    properties
        means;
        k;
    end
    
    methods
        function obj=myKMeans(D,K,num_rand_init)
            %this function realises the constructor of the class myKMeans
            %and takes three arguments, the data D which is organised
            %column-wise (each datapoint is one column), the number of
            %clusters K to be discovered and the number or random
            %initialisations num_rand_init that you want to perform in
            %order to ensure convergence. 
            
            obj.k=K;
            
            for i=1:num_rand_init              
               %choose the means that should be used at the beginning. in
               %order to make a sensible choice of means we suggest to use
               %random elements withdrawn from D
               
               %...
               
               %create a while cycle that terminates when the k-means have
               %been updated only by a very very small quantity, for
               %example 0.0001 

               %add variable to keep track of changes of means ...
               
               %...
               
               
               while sum(double(sqrt(sum(lastMeanMovement.^2,1))>=0.0001))>1
                  %assign points to the means by evaluating distance of
                  %each point to the means. compute euclidean distances
                  
                  %...
                  
                  %recompute means
                  
                  %...
                  
                  %--------------- OPTIONAL ------------------
                  %this part does visualisation of data and means ONLY if the data is 2D
                  %IF YOU WANT TO USE IT YOU MUST CHANGE THIS LINE
                  %scatter(meansRightNow(1,:),meansRightNow(2,:),'rx')
                  %THAT SHOULD CONTAIN THE COORDINATES OF YOUR MEANS IN
                  %THIS ITERATION OF THE ALGORITHM. then you can uncomment
                  %the visualisation part.
%                   if(size(D,1)==2)
%                     scatter(D(1,:),D(2,:),'kx')
%                     hold on;
%                     scatter(meansRightNow(1,:),meansRightNow(2,:),'rx')
%                     drawnow
%                     pause(0.1);
%                     hold off;
%                   end
                  %--------------------------------------------
                  
                  %take differences between the new means and the old ones
                  %and store it in a variable which you will use to
                  %dertermine if the algorithm should terminate or not
                  
                  %...

               end
            end
            
            %now we have to find the agreement between all candidate means
            %of the clusters, in order to merge together the results of the
            %num_rand_init runs. 
            
            %we should remember that the k-means are not sorted! for
            %example the first mean of the first run might be the same as
            %the fifth mean of the second run and the third mean of the
            %third run. We must sort the means such that they correspond
            %across the runs. We will use the k-means of the first run as
            %reference and we will match the k-means of the other runs to
            %those of the first run. We stack the sorted k-means belonging 
            %to different runs in the third dimension of a matrix of k means,
            %and we take their mode using the command mode(matrix,3) (see help mode).
            
            for i=2:num_rand_init
                %...
            end
            
            %...
            
        end
        
        function clusterNum=assignDatapoints(obj,D)
           %this function returns the cluster the datapoints D (which is 
           %a matrix organised columnwise) belong to. 
           %we have to take the distance between each datapoint of D to
           %each of the k-means and then return the index of the mean that 
           %is closest to each datapoint
           
           %...
           
        end
    end
    
end

