classdef BoxFeature
    %BOXFEATURE implements box features, in particular, LBP,
    %longRangeOffset, longRangeDoubleOffset
    
    properties
        II; %for the integral image
        boxesPos;
        boxesNeg;
        params;
    end
    
    methods
        function obj=BoxFeature(img, params)
            %params is a structure
            %params.type can be 'LBP', 'longRangeOffset' or 'longRangeDoubleOffset'
            %params.sizes box size(s) - one size for each box!
            %params.offsets1 significant only for longRangeOffset and longRangeDoubleOffset - two numbers for each box
            %params.offsets2 significant only for longRangeDoubleOffset
            
            obj.params = params;
            obj.II = IntImage(img);
            s = size(img);
            
            switch params.type
                case 'LBP'
                    obj.boxesPos = round(s/2, 0); %the middle one
                    obj.boxesNeg = 1; %all others... which ones are that??
                case 'longRangeOffset'
                    obj.boxesPos = params.offsets1(1);
                    obj.boxesNeg = params.offsets1(2:end);
                case 'longRangeDoubleOffset'
                    obj.boxesPos = params.offsets1;
                    obj.boxesNeg = params.offsets2;
            end
            
        end
        
        function value=lookup(obj,x)
            %this looks up the value of the features in the specified point
            %or vector of points - x can be multiple points!!! (a matrix
            %with n rows and 2 columns)
            
            %...
            
        end
    end
    
end

