classdef ProcessImage
    %IMAGEPROCESSING Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        image;
        lastOperation;
        stackPointer;
    end
    
    methods
        function obj=ProcessImage(img)
            %constuctor of the class ProcessImage
            %you must normalise the image to have only values comprised
            %between 0 and 1 - use im2double
            
            %...

        end
        
        function obj=makeNegative(obj)
            %this member function makes obj.image negative and stores this
            %operation as last operation in the stack of operations
            obj.lastOperation{obj.stackPointer}={'makeNegative',obj.image};
            
            if(length(obj.lastOperation)>obj.stackPointer)
                %if there are other operation memorised after this one,
                %this means that the current requested operation comes
                %after more than one undo! in this case we erase the
                %history after the current operation
                obj.lastOperation=obj.lastOperation(1:obj.stackPointer);
            end
            
            obj.stackPointer=obj.stackPointer+1;
            
            obj.image=abs(obj.image-1);

        end
        
        function obj=normalise(obj)            
            %this member function normalises obj.image to have zero mean
            %and unit standard deviation and adds this operation as 
            %last operation in the stack of operations

            %...
        end
        
        function obj=makeGrayscale(obj)
            %this member function makes obj.image grayscale and stores this
            %operation as last operation in the stack of operations

            %...
        end
        
        function obj=undo(obj)
            %this member function reads the last operation pointed by the
            %stack pointer and undoes it. 

            %...
        end
        
        function obj=redo(obj)
            %this member function reads the next operation (if any) in the 
            %stack and redoes it. 

            %...
        end
        
        function obj=visualise(obj)
            %this memeber function visualises the image as it appears right
            %now
    
            %...
            
        end
    end
    
end

