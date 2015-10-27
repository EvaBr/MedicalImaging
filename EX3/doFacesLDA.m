function doFacesLDA( )
    %doFacesLDA - performs LDA on the yale dataset. 
    
    %load dataset from file (this is done)
    k=load('./Data/dataLDA.mat');
    
    data=k.data;
    

    %arrange the training dataset (which is in data.images and data.classes) in a big matrix column-wise (each face is one
    %column of the matrix)

    D=zeros(numel(data.images{1}),length(data.images));
    
    for i=1:length(data.images)
        D(:,i)=data.images{i}(:);
        class(i)=data.classes(i);
    end
    
    
    %arrange the test dataset (which is in data.imagesTest and data.classesTest) in a big matrix column-wise (each face is one
    %column of the matrix)

    Dtest=zeros(numel(data.imagesTest{1}),length(data.imagesTest));
    
    for i=1:length(data.imagesTest)
        Dtest(:,i)=data.imagesTest{i}(:);
        classTest(i)=data.classesTest(i);
    end
    
    %perform LDA on the resulting matrix

    obj=myLDA(D,class);

    %project training data data in LDA bi-dimensional subspace
    
    [DnewTrain]=projectData(obj,D,2);
    
    [DnewTest]=projectData(obj,Dtest,2);
    
    %YOU DON'T NEED TO IMPLEMENT ANYTHING MORE BELOW HERE!
    display('plot the training set in the new subspace');
    figure();
    title('plot the training set in the new subspace');
    scatter(DnewTrain(class==0,1),DnewTrain(class==0,2),'rx');
    hold on;
    scatter(DnewTrain(class==1,1),DnewTrain(class==1,2),'bx');
    title('plot the training set in the new subspace');

    input('c');
    
    display('plot the test set in the new subspace');
    figure()
    title('plot the training set in the new subspace');
    scatter(DnewTest(classTest==0,1),DnewTest(classTest==0,2),'ro');
    hold on;
    scatter(DnewTest(classTest==1,1),DnewTest(classTest==1,2),'bo');
    title('plot the test set in the new subspace');

end

