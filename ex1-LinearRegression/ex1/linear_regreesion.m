function linear_regreesion()
    % % �ر����д��ڡ�������й�������������������д���
    % close all;
    % clear;
    % clc; 

    % װ������
    data = load('ex1data2.txt');
    X = data(:, 1); y = data(:, 2);     % ������data�еĵ�һ�У����Ա���x����ֵ��X���ڶ��У�����ǩy����ֵ��y
    m = length(y);                         % ȡ��������

    figure, scatter(X, y, 'rx');            % ����ɢ��ͼ��plot(X, y, 'rx')Ҳ����

    X = [ones(m, 1), data(:,1)];        % ����һ��x0������Ӧxita0��1����X
    theta = zeros(2, 1);                   % ��ʼ��xita��H_xita_(x) = xita_0 * x_0 + xita_1 * x_1

    iterations = 1500;                     % ��������
    alpha = 0.0001;                            % ѧϰ��
    
    theta = gradientDescent(X, y, theta, alpha, iterations);
    
    % Plot the linear fit
    hold on; % keep previous plot visible
    plot(X(:,2), X*theta, '-')
    legend('Training data', 'Linear regression')
    hold off % don't overlay any more plots on this figure
    
    Visualizing_cost(X, y, theta)
end

function [theta, J_history] = gradientDescent(X, y, theta, alpha, num_iters)

    m = length(y);                             % ȡ��������
    J_history = zeros(num_iters, 1);    % Ԥ���������������ֵ

    for iter = 1:num_iters
        predictions=X*theta;                % ����������ģ�����ֵ
        errors=(predictions-y);             %  ������������������������ʽ����
        delta=1/m * (X'*errors);            % ����xita_0��xita_1��ƫ����
        theta=theta-alpha*delta;          % ��������xita
        J_history(iter) = computeCost(X, y, theta);     % ���㵱ǰxita֮�µĴ���ֵ
    end
end

function J = computeCost(X, y, theta)
    m = length(y);                                % ��ȡ��������
    J = 0;                                              % Ԥ��һ���������ֹ�����ֵ
    prediction=X*theta;                        % ����H_xita_(x) = xita_0 * x_0 + xita_1 * x_1
    sqr=(prediction-y).^2;                     % H_xita_(x)ȡƽ��
    J=1/(2*m)*sum(sqr);  
end

% ���ۺ������ӻ�
function Visualizing_cost(X, y, theta)
    theta0_vals = linspace(-100, 100, 200);         % ��ʼ��x����
    theta1_vals = linspace(-100, 100, 200);         % ��ʼ��y����
    J_vals = zeros(length(theta0_vals), length(theta1_vals));    % ��ʼ�����ۺ���

    for i = 1:length(theta0_vals)
        for j = 1:length(theta1_vals)
          t = [theta0_vals(i); theta1_vals(j)];             % ����xita
          J_vals(i,j) = computeCost(X, y, t);              % ���㵱ǰ����xita��֮�µĴ���ֵ
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