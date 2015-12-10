function [ output_args ] = main( input_args )
    %example of instantiation of integral image
    img=imread('./data/lena.jpg');
    img=rgb2gray(img);
    
    integralImage=IntImage(img);


    
    %example of instantiation of FilterFeature
    
    filterFeat=FilterFeature(img,'LoG',6,1);

    
    
    %example params for boxFilter
    
    params.type='LBP';
    params.size=3;
    
    %or
    
   % params.type='longRangeOffset';
   % params.size=[3,6,9];
   % params.offsets1=[-20,-20;7 20;-22 21];
    
    %or
    
   % params.type='longRangeDoubleOffset';
   % params.size=[3,6,9];
   % params.offsets1=[-20,-20;7 20;-22 21];
   % params.offsets2=[20,20;-7 -20;22 -21];
    
    
        
    %example of instantiation of boxFilter

    boxFeature=BoxFeature(img,params);
end

