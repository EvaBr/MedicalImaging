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
                    obj.boxesPos = [-floor(siz/2), -floor(siz/2), siz, siz]; %[floor(siz/2), floor(siz/2), siz, siz];
                    %middle box, izmed devetih (neodv od slike): vrneš pa [x_ulc, y_ulc, siz_x, siz_y] 1+siz-siz/2, ne pa siz+1 (centered)
                    obj.boxesNeg = [-siz-floor(siz/2), -siz-floor(siz/2), siz, siz; %[ -floor(siz/2),      -floor(siz/2), siz, siz;
                                    -siz-floor(siz/2),     -floor(siz/2), siz, siz; %floor(siz/2),      -floor(siz/2), siz, siz; 
                                    -siz-floor(siz/2),    1+floor(siz/2), siz, siz; %siz + floor(siz/2),       floor(siz/2), siz, siz; 
                                        -floor(siz/2), -siz-floor(siz/2), siz, siz; %-floor(siz/2),       floor(siz/2), siz, siz; 
                                    %tu manjka middle
                                        -floor(siz/2),    1+floor(siz/2), siz, siz; %siz + floor(siz/2),       floor(siz/2), siz, siz;
                                       1+floor(siz/2), -siz-floor(siz/2), siz, siz; %-floor(siz/2), siz + floor(siz/2), siz, siz;
                                       1+floor(siz/2),     -floor(siz/2), siz, siz; %floor(siz/2), siz + floor(siz/2), siz, siz;
                                       1+floor(siz/2),    1+floor(siz/2), siz, siz]; %siz + floor(siz/2), siz + floor(siz/2), siz, siz];
                                                    
                    %for negative ones vrnes isto kot za poz-; isti sistem
                    %, vrnes pa [P1 P2 P3 P4 P6 P7 P8 P9]' , torej Pi po
                    %vrsticah
                case 'longRangeOffset'
                    obj.boxesPos = [params.offsets1(1, :)-[floor(siz/2), floor(siz/2)], siz, siz];
                    sizes = params.size(2:end)'; %bcs sizes is a row vector
                    obj.boxesNeg = [params.offsets1(2:end, :)-[floor(sizes./2), floor(sizes./2)], sizes, sizes];
                case 'longRangeDoubleOffset'
                    sizes = params.size';
                    obj.boxesPos = [params.offsets1-[floor(sizes./2), floor(sizes./2)], sizes, sizes];
                    obj.boxesNeg = [params.offsets2-[floor(sizes./2), floor(sizes./2)], sizes, sizes];
            end
            
        end
        
        function value=lookup(obj,x)
            %this looks up the value of the features in the specified point
            %or vector of points - x can be multiple points!!! (a matrix
            %with n rows and 2 columns)
            sizes = size(obj.II.integralImage)-1;
            numBoxP = size(obj.boxesPos,1);
            numBoxN = size(obj.boxesNeg,1);
            value=[];
            for i=x'    
                %positions, at which our boxes start:
                searchPos = obj.boxesPos+repmat([i(1:2)', 0 , 0], numBoxP, 1);
                searchNeg = obj.boxesNeg+repmat([i(1:2)', 0 , 0], numBoxN, 1);

                %disp('positions, where boxes start:');
                %disp(searchPos);
                %disp(searchNeg);
                
                outsidePos = searchPos(:, 1:2) + searchPos(:, 3:4) - 1; %indexOfStart + sizes -1
                outsideNeg = searchNeg(:, 1:2) + searchNeg(:, 3:4) - 1; %indexOfStart + sizes -1
                %calclulate new boxes sizes:
                newSizesPos = min(max(outsidePos, 0.*outsidePos), searchPos(:, 3:4)); %min(max(indexOfStart+size-1, 0), size)
                newSizesNeg = min(max(outsideNeg, 0.*outsideNeg), searchNeg(:, 3:4)); %min(max(indexOfStart+size-1, 0), size)
                %get new starting points of boxes:
                % if (indexOfStart-1+size <=0 on any place) { box is completely outside: set starting point to
                %     be out of the picture 8lower and more right, so that
                %     IntImg can handle the case and output 0)} 
                % else {indexOfStart = max(indexOfStart, 1)}
                searchPos(any(outsidePos'<=0), 1) = sizes(1)+1;
                searchPos(any(outsidePos'<=0), 2) = sizes(2)+1;
                searchNeg(any(outsideNeg'<=0), 1) = sizes(1)+1;
                searchNeg(any(outsideNeg'<=0), 2) = sizes(2)+1;
                %the else part:
                searchPos = max(searchPos, searchPos.*0 + 1);
                searchNeg = max(searchNeg, searchNeg.*0 + 1);
                
                %now set the new sizes, but first
                %correct them also for the case of overflowing on the
                %right or bottom (sizes have to be exact for averaging!) :
                overflowPos = max(newSizesPos + searchPos(:, 1:2) - 1 - repmat(sizes, numBoxP,1), repmat([0, 0], numBoxP,1) );
                newSizesPos = newSizesPos - overflowPos; 
                overflowNeg = max(newSizesNeg + searchNeg(:, 1:2) - 1 - repmat(sizes, numBoxN,1), repmat([0, 0], numBoxN,1) );
                newSizesNeg = newSizesNeg - overflowNeg; 
                
                searchPos(:, 3:4) = newSizesPos;
                searchNeg(:, 3:4) = newSizesNeg;
                
                %get now the true sizes of squares, with which we will average:
                boxesPosSizes = newSizesPos(:,1).*newSizesPos(:,2);
                boxesNegSizes = newSizesNeg(:,1).*newSizesNeg(:,2);
                 
                positive = obj.II.lookup(searchPos)./max(boxesPosSizes, 1); %returns sums over given squares, in col. vector 
                negative = obj.II.lookup(searchNeg)./max(boxesNegSizes, 1);  %and is than veraged by sizes of boxes
                
                %disp('final positions and sizes of boxes:');
                %disp(searchPos);
                %disp(searchNeg);
                
                value = [value; (positive-negative)']; %convert to row vector, and store in the next row of VALUE.
            end
            
        end
    end
    
end

