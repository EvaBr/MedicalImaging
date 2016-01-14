function compareMnistPCA_LDA()
    load('dataMNIST.mat');
    
    %create PCA object -- use a reduced dataset having only 5000 samples
    %for computational reasons ---
    N = 200;
    obj=myPCA(data.trainImages(:,1:N));
    
    %project data2
    [Dnew,~]=projectData(obj,data.testImages,3);
    
    %visualize DO NOT MODIFY THIS PART
    figure();    
    title('data in 3D PCA subspace');
    scatter3(Dnew(data.testLabels==0,1),Dnew(data.testLabels==0,2),Dnew(data.testLabels==0,3),'rx');
    hold on;
    scatter3(Dnew(data.testLabels==1,1),Dnew(data.testLabels==1,2),Dnew(data.testLabels==1,3),'cx');
    scatter3(Dnew(data.testLabels==2,1),Dnew(data.testLabels==2,2),Dnew(data.testLabels==2,3),'yx');
    scatter3(Dnew(data.testLabels==3,1),Dnew(data.testLabels==3,2),Dnew(data.testLabels==3,3),'kx');
    scatter3(Dnew(data.testLabels==4,1),Dnew(data.testLabels==4,2),Dnew(data.testLabels==4,3),'gx');
    scatter3(Dnew(data.testLabels==5,1),Dnew(data.testLabels==5,2),Dnew(data.testLabels==5,3),'mx');
    scatter3(Dnew(data.testLabels==6,1),Dnew(data.testLabels==6,2),Dnew(data.testLabels==6,3),'ro');
    scatter3(Dnew(data.testLabels==7,1),Dnew(data.testLabels==7,2),Dnew(data.testLabels==7,3),'co');
    scatter3(Dnew(data.testLabels==8,1),Dnew(data.testLabels==8,2),Dnew(data.testLabels==8,3),'yo');
    scatter3(Dnew(data.testLabels==9,1),Dnew(data.testLabels==9,2),Dnew(data.testLabels==9,3),'ko');
    title('data in 3D PCA subspace');
    
    
    %create LDA object -- use a reduced dataset having only 5000 samples
    %for computational reasons ---
    
    obj=myLDA(data.trainImages(:,1:N),data.trainLabels(1:N)');

    %project data
    [Dnew]=projectData(obj,data.testImages,3);

    %visualize
    figure();
    title('data in 3D LDA subspace');
    scatter3(Dnew(data.testLabels==0,1),Dnew(data.testLabels==0,2),Dnew(data.testLabels==0,3),'rx');
    hold on;
    scatter3(Dnew(data.testLabels==1,1),Dnew(data.testLabels==1,2),Dnew(data.testLabels==1,3),'cx');
    scatter3(Dnew(data.testLabels==2,1),Dnew(data.testLabels==2,2),Dnew(data.testLabels==2,3),'yx');
    scatter3(Dnew(data.testLabels==3,1),Dnew(data.testLabels==3,2),Dnew(data.testLabels==3,3),'kx');
    scatter3(Dnew(data.testLabels==4,1),Dnew(data.testLabels==4,2),Dnew(data.testLabels==4,3),'gx');
    scatter3(Dnew(data.testLabels==5,1),Dnew(data.testLabels==5,2),Dnew(data.testLabels==5,3),'mx');
    scatter3(Dnew(data.testLabels==6,1),Dnew(data.testLabels==6,2),Dnew(data.testLabels==6,3),'ro');
    scatter3(Dnew(data.testLabels==7,1),Dnew(data.testLabels==7,2),Dnew(data.testLabels==7,3),'co');
    scatter3(Dnew(data.testLabels==8,1),Dnew(data.testLabels==8,2),Dnew(data.testLabels==8,3),'yo');
    scatter3(Dnew(data.testLabels==9,1),Dnew(data.testLabels==9,2),Dnew(data.testLabels==9,3),'ko');
    title('data in 3D LDA subspace');
    
    
    
    
    %create LDA object DO NOT MODIFY HERE!
    
    obj=myLDA(data.trainImages(:,:),data.trainLabels(:)');

    %project data
    [Dnew]=projectData(obj,data.testImages,3);

    %visualize
    figure();
    title('data in 3D LDA subspace');
    scatter3(Dnew(data.testLabels==0,1),Dnew(data.testLabels==0,2),Dnew(data.testLabels==0,3),'rx');
    hold on;
    scatter3(Dnew(data.testLabels==1,1),Dnew(data.testLabels==1,2),Dnew(data.testLabels==1,3),'cx');
    scatter3(Dnew(data.testLabels==2,1),Dnew(data.testLabels==2,2),Dnew(data.testLabels==2,3),'yx');
    scatter3(Dnew(data.testLabels==3,1),Dnew(data.testLabels==3,2),Dnew(data.testLabels==3,3),'kx');
    scatter3(Dnew(data.testLabels==4,1),Dnew(data.testLabels==4,2),Dnew(data.testLabels==4,3),'gx');
    scatter3(Dnew(data.testLabels==5,1),Dnew(data.testLabels==5,2),Dnew(data.testLabels==5,3),'mx');
    scatter3(Dnew(data.testLabels==6,1),Dnew(data.testLabels==6,2),Dnew(data.testLabels==6,3),'ro');
    scatter3(Dnew(data.testLabels==7,1),Dnew(data.testLabels==7,2),Dnew(data.testLabels==7,3),'co');
    scatter3(Dnew(data.testLabels==8,1),Dnew(data.testLabels==8,2),Dnew(data.testLabels==8,3),'yo');
    scatter3(Dnew(data.testLabels==9,1),Dnew(data.testLabels==9,2),Dnew(data.testLabels==9,3),'ko');
    title('data in 3D LDA subspace');
end