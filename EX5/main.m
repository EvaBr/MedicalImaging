%two-moons.mat
%  This dataset is already split in training and testing data.
%Aqua-all.csv
%  Here, the first column denotes the outcomes y, the remaining columns
%  the features. Use the first 100 samples as training data for the
%  kernel_ridge_fit function. Use the remaining 97 samples for testing in
%  kernel_ridge_predict.

lambdas = [0.001, 0.01, 0.1, 1, 10, 20, 50, 100, 200, 500, 1000, 10000];
%kernels:
names = {'Linear', 'Polynomial(c=1,d=2)', 'Sigmoid(\gamma=−0.001,c=1)', 'RBF(\gamma= 0.001)'};
lin = inline('x*transpose(y)');
poly = inline('(x*transpose(y)+1)^2');
sig = inline('tanh(-0.001*x*transpose(y) + 1)');
rbf = inline('exp(-0.001*norm(x-y))');
kernels = {lin, poly, sig, rbf};

%load the datasets
moons = load('two-moons.mat');
aqua = csvread('Aqua-all.csv');
 aqua_xtrain = aqua(1:100, 2:end);
 aqua_ytrain = aqua(1:100, 1);
 aqua_xtest = aqua(101:end, 2:end);
 aqua_ytest = aqua(101:end, 1);

%training:
%mses1 = zeros(4, 12);
mses2 = zeros(4, 12);
mses3 = zeros(4, 12);
%alphas1 = zeros(4, 12, size(moons.xtrain, 1));
alphas2 = zeros(4, 12, size(aqua_xtrain, 1));
predict = zeros(4, 12, size(aqua_xtest, 1));

figure(1);
set(gcf, 'name', 'Aqua Data');
hold on;

for k = 1:4
    for i=1:12
        %twomoons data
        %[alphas1(k,i,:), mses1(k, i)] = kernel_ridge_fit(moons.xtrain, moon.ytrain, kernels{k}, lambdas(i));
        %aqua data
        [alphas2(k,i,:), mses2(k, i)] = kernel_ridge_fit(aqua_xtrain, aqua_ytrain, kernels{k}, lambdas(i));
        [predict(k,i,:), mses3(k, i)] = kernel_ridge_predict(aqua_xtrain, alphas2(k,i,:), aqua_xtest, aqua_ytest, kernels{k});
    end
    %figure(1);
    %subplot(2,2,k);
    %title(names{k});
    %plot(lambdas, mses1(k,:));
    %ylabel('mse');
    %xlabel('\lambda');
    
    %figure(2);
    subplot(2,2,k);
    %plot(lambdas, mses2(k,:));
    semilogx(lambdas, mses2(k,:));
    hold on;
    semilogx(lambdas, mses3(k,:));
    legend(' train',' test');
    title(names{k});
    ylabel('mse');
    xlabel('\lambda');
end
print -djpeg;

%second, svm exercise:
%figure(2);
%set(gcf, 'name', 'Two Moons Data');
C = [0.001,0.01,0.1,1,10,20,50,100,200,500,1000,10000];
%for c=C
   %case linear kernel
   %[a, mse1L] = svm_fit(moons.xtrain, moons.ytrain, lin);
   %[y, mse2L] = svm_predict(moons.xtrain, moons.xtest, moons.ytest, lin, a);
   
   
   %case rbf kernel
 %svm_fit(moons.xtrain, moons.ytrain, rbf);
%end

