clc;
clear;
data = load('ex1data1.txt');
X = data(:,1);
y = data(:,2);
figure(1),
plot(X, y, 'r*', 'MarkerSize', 5, 'LineWidth',0.8); % 5控制*的大小
% x加了一列,变成 (97,2)
m = length(y); 
X = [ones(m, 1), X]; 

% 初始化参数
theta = zeros(2, 1);

% Some gradient descent settings
iterations = 1500;
alpha = 0.001;
% 梯度下降，找到最佳参数
theta = gradientDescent(X, y, theta, alpha, iterations);

hold on; 
% keep previous plot visible
% figure(1)
plot(X(:,2), X*theta, '-b','LineWidth',2.5)
legend('Training data', 'Linear regression')
hold off 
 
function theta = gradientDescent(X, y, theta, alpha, num_iters)

m = length(y); 
% 样本数量

for iter = 1:num_iters
    H = X * theta;
    %(97,2)*(2*1)=(97,1)
    Sum = [0 ; 0]; %(2,1)，记录偏导，求和
    
    % theta_0更新
    for i = 1 : m
        Sum(1,1) = Sum(1,1) + (H(i) - y(i));    
    end
    
    % theta_1更新
    for i = 1 : m
        Sum(2,1) = Sum(2,1) + (H(i) - y(i)) * X(i,2);   
    end

    theta = theta - (alpha * Sum) / m;

end
end