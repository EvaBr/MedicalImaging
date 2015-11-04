classdef SegmentImageKMeans
    %SEGMENTIMAGEKMEANS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        img;
        features;
        
        kMeansObj;
        featObj;
    end
    
    methods
        function obj=SegmentImageKMeans(img,K,featParams)
           obj.img=img;
           
           %extract features at each pixel of the image using
           %obj.featureObj.lookup(x) where x is a matrix that contains
           %in each row the coordinate of a pixel of img, for every pixel
           %of img
           
           [X,Y]=meshgrid(1:1:size(img,1),1:1:size(img,2));
           
           %insantiate BoxFeature object and store it in obj.featureObj
           for i=1:length(featParams)
                obj.featObj{i}=FilterFeature(img,featParams{i}.filterName,featParams{i}.siz,featParams{i}.sigma);
                obj.features(i,:)=obj.featObj{i}.lookup([X(:),Y(:)])';
           end
           
           %create k-means object which runs k means 10 times in order to
           %ensure robustness
           
           %...
           
        end
        
        function [segmentation]=segment(obj)
            %use assignDatapoints to find the cluster of each of the
            %feature stored in obj.features. then reshape them into a
            %matrix havin same size as the image.
            
            %...
           
        end
    end
    
end

