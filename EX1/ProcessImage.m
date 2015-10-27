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

            im = im2double(img);
            obj.image = im;
            obj.lastOperation = cell(); %[];
            obj.stackPointer = 1;
          %  obj = class(obj, 'ProcessImage'); %??
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

            obj.lastOperation{obj.stackPointer}={'normalise',obj.image};

            obj.image = (obj.image - mean2(obj.image))/std2(obj.image);

            obj.stackPointer = obj.stackPointer+1;

        end

        function obj=makeGrayscale(obj)
            %this member function makes obj.image grayscale and stores this
            %operation as last operation in the stack of operations

            channels = size(obj.image);
            %if (channels==3)
            if (length(channels)==3)
                %channels = channels(3); need to check again, if this==3?

                obj.lastOperation{obj.stackPointer}={'makeGrayscale', obj.image};

                obj.image = 0.21*obj.image(:,:,1) + 0.72*obj.image(:,:,2) + 0.07*obj.image(:,:,3);

                obj.stackPointer = obj.stackPointer+1;
            end

        end

        function obj=undo(obj)
            %this member function reads the last operation pointed by the
            %stack pointer and undoes it.

	          if (obj.stackPointer>1){
	            lastop = obj.lastOperation{obj.stackPointer-1};
              %undo-ing by changing the stack pointer and rewriting image
              obj.stackPointer = obj.stackPointer-1;
              obj.image = lastop{2};   %% stckPint-1?? Nope - kaže na tisto, ki je bila zdajle narejena; slika je izzid te na ktero kaže
 	          end
	      end

        function obj=redo(obj)
            %this member function reads the next operation (if any) in the
            %stack and redoes it.

            if(length(obj.lastOperation)>obj.stackPointer)
              obj.stackPointer = obj.stackPointer +1;
              nextop = obj.lastOperation{obj.stackPointer};
              obj.image = nextop{2};  %%or should you read name of operation and actually redo it manually (as in, call it again)?
            end
        end

        function obj=visualise(obj)
            %this member function visualises the image as it appears right
            %now

            imshow(obj.image);

        end
    end

end
