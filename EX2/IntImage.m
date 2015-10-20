classdef IntImage
    %INTEGRALIMAGE implements integral image. 
    
    properties
        integralImage
    end
    
    methods
        function obj=IntImage(image)
            %this class implement integral images. A new integral image is
            %instantiated by calling obj=IntImage(image) with a NxN image
            %having only one channel as argument!
            
            %in this method we compute the integral image. remember that
            %the integral image will have a size that is size(image)+1 and
            %the first row and column are all zero. Please DO NOT USE
            %integralImage method from MATLAB.
            
            %...
            
        end

        
        function value=lookup(obj,x)
            %x is in the form [row col height width] where row col are the
            %coordinates of the upper left corner of the box and height and
            %width express the size of the box. x CAN HAVE MULTIPLE ROWS, 
            %EACH OF THESE ROWS IS A BOX COORDINATE, in this case value
            %must have multiple rows containing the appropriate values.
            %Refer to the exercise sheet to find the appropriate formula 
            %to compute the return value.
            
            %remember to address the case the boxes are out of range!!
            
            %...
        end
    end
    
end

