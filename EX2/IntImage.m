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
            image=double(image);
            s = size(image);
            imax = s(1)+1;
            jmax = s(2)+1;
            
            newIm = zeros(imax, jmax);
            for i=2:imax
                for j=2:jmax
                    newIm(i, j) = image(i-1, j-1) + newIm(i-1, j) + newIm(i, j-1) - newIm(i-1, j-1);
                end
            end
            
            obj.integralImage = newIm;
            
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
            int =  obj.integralImage;
            s = size(int);
            
            value = [];
            %row=0;
            for i=x' %for every row in x do...
                %row=row+1; %count rows of x just to know where into result
                %to write
                if i(1)>=s(1) || i(2)>=s(2)
                    value = [value; 0];  %add result 0, since patch is not contained in the image
                else
                    temp = int(min(i(1)+i(3), s(1)), min(i(2)+i(4), s(2)))-int(i(1),  min(i(2)+i(4), s(2))) - int(min(i(1)+i(3), s(1)), i(2)) + int(i(1), i(2)); 
                    %taking minimums in case patch is bigger than image 
                    value = [value; temp];
                end
            end
            
            
        end
    end
    
end
