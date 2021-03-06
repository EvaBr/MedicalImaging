function [ output_args ] = main( input_args )
    %example of instantiation of integral image
    img=imread('./data/lena.jpg');
    img=rgb2gray(img);
    
    integralImage=IntImage(img);


    
    %example of instantiation of FilterFeature
    
    filterFeat=FilterFeature(img,'LoG',6,1);
    %to compare:
    imshow(filterFeat.image);
    imshow(filterFeat.featureImg);
    
    
    %example params for boxFilter
    
   % params.type='LBP';
   % params.size=3;
    
    %or
    
    %params.type='longRangeOffset';
    %params.size=[3,6,9];
    %params.offsets1=[-20,-20;7 20;-22 21];
    
    %or
    
    params.type='longRangeDoubleOffset';
    params.size=[3,6,9];
    params.offsets1=[-20,-20;7 20;-22 21];
    params.offsets2=[20,20;-7 -20;22 -21];
    
    
        
    %example of instantiation of boxFilter

    boxFeature=BoxFeature(img,params);
    boxFeature.lookup([1,3; 15, 5]) %first one is to check if it works, when not all boxes are in the pic
end

