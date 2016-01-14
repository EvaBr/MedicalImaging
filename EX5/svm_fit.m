function  [ estclas, mse, model ] = svm_fit( X, y, kern, siz, C )
%X...matrix of samples
%y...outcomes for samples
%kern...kernelfunction
%
%OUT: estclas...estimated class
%     mse ... mean squared error
%     model...model SVM
switch (kern)
    case 'rbf'
        SVMModel = fitcsvm(X, y,'KernelFunction', 'rbf', 'KernelScale', siz, 'BoxConstraint', C);
    case 'linear'
        SVMModel = fitcsvm(X, y,'KernelFunction', 'rbf', 'BoxConstraint', C);
end
model=SVMModel;

[estclas, score] = predict(SVMModel,X);
mse = sum((y-estclas).^2)/size(X,1);

end