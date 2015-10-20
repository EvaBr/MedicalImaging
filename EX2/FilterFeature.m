classdef FilterFeature
    %FILTERFEATURE extract features from a image by using filters
    
    properties
       image;
       featureImg;
       filter;
    end
    
    methods
        function obj=FilterFeature(img,filterName,siz,sigma)
           %... 
           
           switch filterName
               case 'gaussian'
                   %... here you should also produce a filtered version of
                   %the image
               case 'LoG'
                   %... here you should also produce a filtered version of
                   %the image
               case 'mean'
                   %... here you should also produce a filtered version of
                   %the image
               case 'horizontalDerivative'
                   %... here you should also produce a filtered version of
                   %the image
               case 'verticalDerivative'
                   %... here you should also produce a filtered version of
                   %the image
               case 'diagonalDerivative'
                   %... here you should also produce a filtered version of
                   %the image
               case 'std'
                   %... here you should also produce a "filtered" version of
                   %the image. in practice you do this by looping the image
                   %and performing std(...) for each of its overlapping
                   %patches.
           end      
                   
        end
        
        function value=lookup(obj,x)
            %each row of x is a lookup point. the first column of x is the
            %row coordinate the second is the column coordinate 
            %x=[row, col]. This function is compatible with coords. form
            %x=[row,col,width, height] 
            
            %remember to address the case the coordinates are out of range!!
              
            %...
        end

    end
    
end

