classdef FilterFeature
    %FILTERFEATURE extract features from a image by using filters
    
    properties
       image;
       featureImg;
       filter;
    end
    
    methods
        function obj=FilterFeature(img, filterName, siz, sigma)
           %... img is already in grayscale, right?
           obj.image = img;
           %obj.filter = filterName;
           
           switch filterName
               case 'gaussian'
                   %... here you should also produce a filtered version of
                   %the image
                   
                   filt = fspecial('gaussian', 6*sigma+1, sigma);
                   obj.featureImg = imfilter(img, filt, 'replicate', 'same');
               
               case 'LoG'
                   %... here you should also produce a filtered version of
                   %the image
               
                   filt = fspecial('log', 6*sigma+1, sigma);
                   obj.featureImg = imfilter(img, filt, 'replicate', 'same');
               
               case 'mean'
                   %... here you should also produce a filtered version of
                   %the image
                   
                   filt = fspecial('average', siz);
                   obj.featureImg = imfilter(img, filt, 'replicate', 'same');
               
               case 'horizontalDerivative'
                   %... here you should also produce a filtered version of
                   %the image
               
                   filt = fspecial('prewitt');
                   obj.featureImg = imfilter(img, filt, 'replicate', 'same');
                   
               case 'verticalDerivative'
                   %... here you should also produce a filtered version of
                   %the image
               
                   filt = fspecial('prewitt');
                   obj.featureImg = imfilter(img, filt', 'replicate', 'same');
                   
               case 'diagonalDerivative'
                   %... here you should also produce a filtered version of
                   %the image
                   
                   filt = [-1, 0; 0, 1];
                   obj.featureImg = imfilter(img, filt, 'replicate', 'same');
               
               case 'std'
                   %... here you should also produce a "filtered" version of
                   %the image. in practice you do this by looping the image
                   %and performing std(...) for each of its overlapping
                   %patches.
                   
                   filt = fspecial('average', siz);
                   obj.featureImg = sqrt(imfilter(img.^2, filt, 'replicate', 'same') - ...
                                         imfilter(img, filt, 'replicate', 'same').^2);
                   
           end
           obj.filter = filt;
                   
        end
        
        function value=lookup(obj,x)
            %each row of x is a lookup point. the first column of x is the
            %row coordinate the second is the column coordinate 
            %x=[row, col]. This function is compatible with coords. form
            %x=[row,col,width, height] 
            
            %remember to address the case the coordinates are out of range!!
              
            s = size(obj.featureImg);
            value = [];
            for i=x'
               if i(1)>s(1) || i(2)>s(2)
                   value = [value; 0];
               else
                   value = [value; obj.featureImg(i(1), i(2))];
               end
            end
        end

    end
    
end

