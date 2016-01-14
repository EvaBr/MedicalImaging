%two-moons.mat
%  This dataset is already split in training and testing data.
%Aqua-all.csv
%  Here, the first column denotes the outcomes y, the remaining columns
%  the features. Use the first 100 samples as training data for the
%  kernel_ridge_fit function. Use the remaining 97 samples for testing in
%  kernel_ridge_predict.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       EX1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
lambdas = [0.001, 0.01, 0.1, 1, 10, 20, 50, 100, 200, 500, 1000, 10000];
%kernels:
names = {'Linear', 'Polynomial(c=1,d=2)', 'Sigmoid(\gamma=−0.001,c=1)', 'RBF(\gamma= 0.001)'};
lin = inline('x*transpose(y)');
poly = inline('(x*transpose(y)+1)^2');
sig = inline('tanh(-0.001*x*transpose(y) + 1)');
rbf = inline('exp(-0.001*norm(x-y))');
kernels = {lin, poly, sig, rbf};

% %load the dataset
% aqua = csvread('Aqua-all.csv');
%  aqua_xtrain = aqua(1:100, 2:end);
%  aqua_ytrain = aqua(1:100, 1);
%  aqua_xtest = aqua(101:end, 2:end);
%  aqua_ytest = aqua(101:end, 1);

% %training:
% %mses1 = zeros(4, 12);
% mses2 = zeros(4, 12);
% mses3 = zeros(4, 12);
% %alphas1 = zeros(4, 12, size(moons.xtrain, 1));
% alphas2 = zeros(4, 12, size(aqua_xtrain, 1));
% predict = zeros(4, 12, size(aqua_xtest, 1));
% 
% figure(1);
% set(gcf, 'name', 'Aqua Data');
% hold on;
% 
% for k = 1:4
%     for i=1:12
%         %twomoons data
%         %[alphas1(k,i,:), mses1(k, i)] = kernel_ridge_fit(moons.xtrain, moon.ytrain, kernels{k}, lambdas(i));
%         %aqua data
%         [alphas2(k,i,:), mses2(k, i)] = kernel_ridge_fit(aqua_xtrain, aqua_ytrain, kernels{k}, lambdas(i));
%         [predict(k,i,:), mses3(k, i)] = kernel_ridge_predict(aqua_xtrain, alphas2(k,i,:), aqua_xtest, aqua_ytest, kernels{k});
%     end
%     %figure(1);
%     %subplot(2,2,k);
%     %title(names{k});
%     %plot(lambdas, mses1(k,:));
%     %ylabel('mse');
%     %xlabel('\lambda');
%     
%     %figure(2);
%     subplot(2,2,k);
%     %plot(lambdas, mses2(k,:));
%     semilogx(lambdas, mses2(k,:));
%     hold on;
%     semilogx(lambdas, mses3(k,:));
%     legend(' train',' test');
%     title(names{k});
%     ylabel('mse');
%     xlabel('\lambda');
% end
% print -djpeg;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%       EX2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%second, svm exercise:
%load the dataset
moons = load('two-moons.mat');


C = [0.001,0.01,0.1,1,10,20,50,100,200,500,1000,10000];
siz = [0.01, 0.05, 0.1, 0.5, 1, 5, 10, 50, 100];
ly = length(moons.ytrain);
lyp = length(moons.ytest);
mseL = zeros(12, 9);
mseR = zeros(12, 9);
estL = zeros(12, 9, ly);
estR = zeros(12, 9, ly);
mseLp = zeros(12, 9);
mseRp = zeros(12, 9);
estLp = zeros(12, 9, lyp);
estRp = zeros(12, 9, lyp);
for c=1:12
    for s=1:9
        %fit data, at the same time see what computed model would classify
        %your train data to...
        [estL(c,s,:), mseL(c,s), modelL] = svm_fit( moons.xtrain, moons.ytrain, 'linear', siz(s), C(c) );
        [estR(c,s,:), mseR(c,s), modelR] = svm_fit( moons.xtrain, moons.ytrain, 'rbf', siz(s), C(c) );
        %predict class for test data
        [estLp(c,s,:), mseLp(c,s)] = svm_predict(moons.xtrain, modelL, moons.xtest, moons.ytest, 'linear');
        [estRp(c,s,:), mseRp(c,s)] = svm_predict(moons.xtrain, modelR, moons.xtest, moons.ytest, 'rbf');
    end
end
 

%ploting of the surface plots:
figure(2);
set(gcf, 'name', 'Two Moons Data, test predictions');
hold on;

subplot(1,2,1);
title('linear');
hold on;
surf(siz, C, mseLp);
hold on;
xlabel('kernel size');
ylabel('C');
zlabel('MSError');

subplot(1,2,2);
title('rbf');
hold on;
surf(siz, C, mseRp);
xlabel('kernel size');
ylabel('C');
zlabel('MSError');

hold off;
print -djpeg



input('Start with animation for rbf?');

%creating the animation:
figure(3);
set(gcf, 'name', 'AnimationRBF');
hold on;

%for s=1:9
s=2; %0.05
    for c=1:12
        drawnow;
        title(sprintf('RBF, size=%d , C=%d', siz(s), C(c)));
        hold on;
        
        plot(moons.xtest(moons.ytest(:)==1,1), moons.xtest(moons.ytest(:)==1,2), 'r.'); hold on;
        plot(moons.xtest(moons.ytest(:)==2,1), moons.xtest(moons.ytest(:)==2,2), 'g.'); hold on;
        
        plot(moons.xtest(estRp(c,s,:)==1,1), moons.xtest(estRp(c,s,:)==1,2), 'ro'); hold on;
        plot(moons.xtest(estRp(c,s,:)==2,1), moons.xtest(estRp(c,s,:)==2,2), 'go'); hold off;
        
        pause(0.2);
    end
%end





input('Start with animation for linear?');
close all;

figure(4);
set(gcf, 'name', 'AnimationLinear');
hold on;
%for s=1:9
s=5;
    for c=1:12
        title(sprintf('Linear, size=%d , C=%d', siz(s), C(c)));
        hold on;
        
        plot(moons.xtest(moons.ytest(:)==1,1), moons.xtest(moons.ytest(:)==1,2), 'r.'); hold on;
        plot(moons.xtest(moons.ytest(:)==2,1), moons.xtest(moons.ytest(:)==2,2), 'g.'); hold on;
        
        plot(moons.xtest(estLp(c,s,:)==1,1), moons.xtest(estLp(c,s,:)==1,2), 'ro'); hold on;
        plot(moons.xtest(estLp(c,s,:)==2,1), moons.xtest(estLp(c,s,:)==2,2), 'go'); hold off;
        
        pause(0.5);
    end
%end


