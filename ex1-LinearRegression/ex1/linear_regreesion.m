function linear_regreesion()
    % % 关闭所有窗口、清除所有工作区变量、清除命令行窗口
    % close all;
    % clear;
    % clc; 

    % 装入数据
    data = load('ex1data2.txt');
    X = data(:, 1); y = data(:, 2);     % 将数据data中的第一列（即自变量x）赋值给X，第二列（即标签y）赋值给y
    m = length(y);                         % 取样本个数

    figure, scatter(X, y, 'rx');            % 画出散点图，plot(X, y, 'rx')也可以

    X = [ones(m, 1), data(:,1)];        % 增加一个x0（即对应xita0的1）给X
    theta = zeros(2, 1);                   % 初始化xita：H_xita_(x) = xita_0 * x_0 + xita_1 * x_1

    iterations = 1500;                     % 迭代次数
    alpha = 0.0001;                            % 学习率
    
    theta = gradientDescent(X, y, theta, alpha, iterations);
    
    % Plot the linear fit
    hold on; % keep previous plot visible
    plot(X(:,2), X*theta, '-')
    legend('Training data', 'Linear regression')
    hold off % don't overlay any more plots on this figure
    
    Visualizing_cost(X, y, theta)
end

function [theta, J_history] = gradientDescent(X, y, theta, alpha, num_iters)

    m = length(y);                             % 取样本个数
    J_history = zeros(num_iters, 1);    % 预设迭代次数个代价值

    for iter = 1:num_iters
        predictions=X*theta;                % 所有样本的模型输出值
        errors=(predictions-y);             %  所有样本的误差，都是以向量形式计算
        delta=1/m * (X'*errors);            % 计算xita_0和xita_1的偏导数
        theta=theta-alpha*delta;          % 迭代更新xita
        J_history(iter) = computeCost(X, y, theta);     % 计算当前xita之下的代价值
    end
end

function J = computeCost(X, y, theta)
    m = length(y);                                % 获取样本数量
    J = 0;                                              % 预设一个输出，防止输出空值
    prediction=X*theta;                        % 计算H_xita_(x) = xita_0 * x_0 + xita_1 * x_1
    sqr=(prediction-y).^2;                     % H_xita_(x)取平方
    J=1/(2*m)*sum(sqr);  
end

% 代价函数可视化
function Visualizing_cost(X, y, theta)
    theta0_vals = linspace(-100, 100, 200);         % 初始化x坐标
    theta1_vals = linspace(-100, 100, 200);         % 初始化y坐标
    J_vals = zeros(length(theta0_vals), length(theta1_vals));    % 初始化代价函数

    for i = 1:length(theta0_vals)
        for j = 1:length(theta1_vals)
          t = [theta0_vals(i); theta1_vals(j)];             % 构造xita
          J_vals(i,j) = computeCost(X, y, t);              % 计算当前网格（xita）之下的代价值
        end
    end

    % Because of the way meshgrids work in the surf command, we need to
    % transpose J_vals before calling surf, or else the axes will be flipped
    J_vals = J_vals';
    % Surface plot
    figure;
    surf(theta0_vals, theta1_vals, J_vals)
    xlabel('\theta_0'); ylabel('\theta_1');

    % Contour plot
    figure;
    % Plot J_vals as 15 contours spaced logarithmically between 0.01 and 100
    contour(theta0_vals, theta1_vals, J_vals, logspace(-20, 30, 200))
    xlabel('\theta_0'); ylabel('\theta_1');
    hold on;
    plot(theta(1), theta(2), 'rx', 'MarkerSize', 10, 'LineWidth', 2);
end