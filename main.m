close all; 
clear; 
clc;
rng(11207330);

data = readtable('data.csv', 'VariableNamingRule', 'preserve');
disp('First few rows of the data:');
head(data)
disp('Summary statistics of the data:');
summary(data)

disp('Missing values in each column:');
disp(sum(ismissing(data)))
data = fillmissing(data, 'linear');

inputs = data{:, {'d_a_k-3', 'd_b_k-3', 'd_c_k-3', ...
             'd_a_k-2', 'd_b_k-2', 'd_c_k-2', ...
             'i_a_k-1', 'i_b_k-1', 'i_c_k-2', ...
             'i_a_k', 'i_b_k', 'i_c_k', ...
             'u_dc_k-1', 'u_dc_k'}}';
targets = data{:, {'u_a_k-1', 'u_b_k-1', 'u_c_k-1'}}';

[inputsNorm, inputSettings] = mapminmax(inputs);

trainRatio = 0.7;
valRatio = 0.15;
testRatio = 0.15;
[trainInd, valInd, testInd] = dividerand(size(inputsNorm, 2), trainRatio, valRatio, testRatio);
trainInputs = inputsNorm(:, trainInd);
trainTargets = targets(:, trainInd);
valInputs = inputsNorm(:, valInd);
valTargets = targets(:, valInd);
testInputs = inputsNorm(:, testInd);
testTargets = targets(:, testInd);
out_name = '22.mat';    

hiddenLayerSize = [16. 16, 16, 16];
net = feedforwardnet(hiddenLayerSize);
net.layers{1}.transferFcn = 'poslin';
net.layers{2}.transferFcn = 'poslin';
net.layers{3}.transferFcn = 'poslin';
net.layers{4}.transferFcn = 'poslin';

net.divideFcn = 'divideind';
net.divideParam.trainInd = trainInd;
net.divideParam.valInd = valInd;
net.divideParam.testInd = testInd;

net.trainFcn = 'trainlm';
net.trainParam.epochs = 1000;
net.trainParam.goal = 0;
net.trainParam.max_fail = 1000;
net.trainParam.min_grad = 1e-7;
net.trainParam.mu = 0.001;
net.trainParam.mu_dec = 0.1;
net.trainParam.mu_inc = 10;
net.trainParam.mu_max = 1e10;

net.trainParam.show = 25;
net.trainParam.showWindow = true;
net.trainParam.showCommandLine = false;
net.performFcn = 'mse';

[net, tr] = train(net, inputsNorm, targets);

testOutputs = net(testInputs);
testErrors = gsubtract(testTargets, testOutputs);
testPerformance = perform(net, testTargets, testOutputs);
save(out_name, 'net', 'tr', 'testOutputs', 'testErrors', 'testPerformance');

load(out_name, 'net', 'tr', 'testOutputs', 'testErrors', 'testPerformance');

mseValue = mse(testErrors);
rmseValue = sqrt(mseValue);
maeValue = mean(abs(testErrors), 'all');
SStot = sum((testTargets - mean(testTargets, 2)).^2, 2);
SSres = sum(testErrors.^2, 2);
r2Value = mean(1 - (SSres ./ SStot));

fprintf('Test Set Mean Squared Error (MSE): %f\n', mseValue);
fprintf('Test Set Root Mean Squared Error (RMSE): %f\n', rmseValue);
fprintf('Test Set Mean Absolute Error (MAE): %f\n', maeValue);
fprintf('Test Set R-squared (R²): %f\n', r2Value);

total_parameters = sum(cellfun(@numel, net.IW)) + sum(cellfun(@numel, net.LW)) + sum(cellfun(@numel, net.b));
fprintf('Number of parameters: %d\n', total_parameters(1));

figure;
plotperform(tr);
title('Performance Plot');
figure;
plottrainstate(tr);
title('Training State Plot');
figure;
ploterrhist(testErrors);
title('Error Histogram');
figure;
plotregression(targets, net(inputsNorm));
title('Regression Plot');
figure;
plotregression(testTargets, testOutputs);
title('Test Set Regression Plot');
figure;
histogram(testErrors);
title('Test Error Histogram');
xlabel('Error');
ylabel('Frequency');

testPredict = net(testInputs);
numSamples = 100;

figure;
plot(testTargets(1, 1:numSamples), 'b-', 'LineWidth', 1.5);
hold on;
plot(testPredict(1, 1:numSamples), 'r--', 'LineWidth', 1.5);
title('Comparison of Actual and Predicted Values for u_a_k-1', 'FontSize', 14);
xlabel('Sample', 'FontSize', 12);
ylabel('Value', 'FontSize', 12);
legend('Actual', 'Predicted', 'Location', 'Best');
grid on;

figure;
plot(testTargets(2, 1:numSamples), 'b-', 'LineWidth', 1.5);
hold on;
plot(testPredict(2, 1:numSamples), 'r--', 'LineWidth', 1.5);
title('Comparison of Actual and Predicted Values for u_b_k-1', 'FontSize', 14);
xlabel('Sample', 'FontSize', 12);
ylabel('Value', 'FontSize', 12);
legend('Actual', 'Predicted', 'Location', 'Best');
grid on;

figure;
plot(testTargets(3, 1:numSamples), 'b-', 'LineWidth', 1.5);
hold on;
plot(testPredict(3, 1:numSamples), 'r--', 'LineWidth', 1.5);
title('Comparison of Actual and Predicted Values for u_c_k-1', 'FontSize', 14);
xlabel('Sample', 'FontSize', 12);
ylabel('Value', 'FontSize', 12);
legend('Actual', 'Predicted', 'Location', 'Best');
grid on;
