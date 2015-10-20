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
        function obj=BoxFeature(img,params)
            %params is a structure
            %params.type can be 'LBP', 'longRangeOffset' or 'longRangeDoubleOffset'
            %params.sizes box size(s) - one size for each box!
            %params.offsets1 significant only for longRangeOffset and longRangeDoubleOffset - two numbers for each box
            %params.offsets2 significant only for longRangeDoubleOffset
            
            %...
            
            switch params.type
                case 'LBP'
                    %...
                case 'longRangeOffset'
                    %...

                case 'longRangeDoubleOffset'
                    %...   
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

