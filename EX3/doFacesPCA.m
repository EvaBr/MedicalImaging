function doFacesPCA()
    %doFacesPCA - performs PCA on the yale dataset. 
    
    %load dataset from file (this is done)
    k=load('dataPCA.mat');
    
    data=k.data;
    

    %arrange the dataset in a big matrix column-wise (each face is one
    %column of the matrix)
    
    %...
    D=zeros(numel(data.images{1}),length(data.images));
    
    for i=1:length(data.images)
        D(:,i)=data.images{i}(:);
    end
    
    %perform PCA on the resulting matrix

    pcaObject=myPCA(D);

    %show K modes of variation usign the function showModesOfVariation that
    %takes size(data.images{1}) as argument
    

    pcaObject.showModesOfVariation(size(data.images{1}),1)

    input('c');
    
    close all;

    %find number of modes of variation that capture 95% variance
    

    
    numberModes=pcaObject.findNecessaryEigenmodesForPercentageOfVariation(95);
    display(sprintf('we need %d eigenmodes to keep 95% of variance',numberModes));
    
    %reconstruct data that was previously unseen during training
    [~,weights]=pcaObject.projectData(data.images{20}(:),numberModes);
    legalD=pcaObject.synthetize(weights);
    legalImg=reshape(legalD,size(data.images{20}));
    
    %show this data (original vs. reconstruction)
    subplot(1,2,1);
    title('Original Image')
    imagesc(data.images{20});
    colormap gray;
    subplot(1,2,2);
    title('Reconstructed Image');
    imagesc(legalImg);
    colormap gray;
    
    
    input('c');
    
    %synthetize faces as linear combination of the weights used to reconstruct
    %two faces from the dataset
    %FACE1 --X-- FACE2 <- we want to find X, the face that is in the middle
    %between these two!
    
    subplot(1,3,1);
    face1=data.images{101};
    imagesc(face1);
    colormap gray
    subplot(1,3,3)
    face2=data.images{90};
    imagesc(face2);
    colormap gray
    [~,weightsFace1]=pcaObject.projectData(face1(:),numberModes);
    [~,weightsFace2]=pcaObject.projectData(face2(:),numberModes);
    
    for i=0:0.05:1
        legalD=pcaObject.synthetize(weightsFace1*i+(1-i)*weightsFace2);
        subplot(1,3,2);
        imagesc(reshape(legalD,size(face2)));
        colormap gray
        drawnow;
        pause(0.2);
    end

    
    input('c');
    
    %project dataset in a 2 dimensional space. each data that belongs to
    %class 1 (people with glasses) will be plotted as a green cross
    %otherwise it will be plotted as a red circle.
    figure();
    hold on;
    for i=1:length(data.images)
        [~,weights]=pcaObject.projectData(data.images{i}(:),2); 
        legalD=pcaObject.synthetize(weights);
        if(data.classes(i)==0)
            plot(weights(1),weights(2),'ro');
            hold on;
        else
            plot(weights(2),weights(2),'gx');
            hold on;
        end
    end
    
    input('c');
    
    close all;

end

