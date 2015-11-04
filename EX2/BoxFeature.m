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
            siz = params.size(1);
            switch params.type
                case 'LBP'
                    obj.boxesPos = [siz+1-siz/2, siz+1-siz/2, siz, siz];
                    %middle box, izmed devetih (neodv od slike): vrneš pa [x_ulc, y_ulc, siz_x, siz_y] 1+siz-siz/2, ne pa siz+1 (centered)
                    obj.boxesNeg = [-siz/2, -siz/2, siz, siz;
                                    -siz/2, siz+1-siz/2, siz, siz; 
                                    -siz/2, 2*siz+1-siz/2, siz, siz; 
                                    siz+1-siz/2, -siz/2, siz, siz; 
                                    %tu manjka middle
                                    siz+1-siz/2, siz+1-siz/2, siz, siz;
                                    2*siz+1-siz/2, -siz/2, siz, siz;
                                    2*siz+1-siz/2, siz+1-siz/2, siz, siz;
                                    2*siz+1-siz/2, 2*siz+1-siz/2, siz, siz];
                                                    
                    %for negative ones vrnes isto kot za poz-; isti sistem
                    %, vrnes pa [P1 P2 P3 P4 P6 P7 P8 P9]' , torej Pi po
                    %vrsticah
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
            
            for i=x'
		value = obj.II(obj.boxesPos+repmat(i(1:2), 1, size(obj.boxesPos,1)));
	    end
            
        end
    end
    
end

