function  [ estclas, mse] = svm_predict( Xt, model, X, y, kern)
%X...matrix of samples
%y...outcomes for samples
%kern...kernelfunction
%
%OUT: estclas...estimated class
%     mse ... mean squared error

[estclas, score] = predict(model,X);
mse = sum((y-estclas).^2)/size(X,1);
end