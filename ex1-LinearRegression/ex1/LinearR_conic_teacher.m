%% 这个是主函数 
function LinearR_conic_teacher()
    % 装入数据
    data = load('ex1data1.txt');
    % figure, scatter(data(:,1), data(:,2));
    x = data(:,1);
    y = data(:,2);
    X = [ones(size(x,1), 1),x];
    t = eye(97,1);
    for i=1:97
        t(i,1)=X(i,2)*X(i,2);
    end
    X = [X,t];
    theta = zeros(3,1);
    % J = costF(X, y, theta);
    iter = 1500;
    alpha = 0.0001;
    theta = gradientD(X, y, theta, alpha, iter);
    pre = X*theta;
    figure, scatter(data(:,1), data(:,2));
hold on
% scatter(x, pre,'go');
xval = max(x);
X = 1:0.1:xval;
XX = [ones(size(X,2), 1),X', X'.^2];
prenew = XX*theta;
plot(X,prenew);
% plot(x,pre, 'rx', 'MarkerSize', 10)
end

function J = costF(X, y, theta)
    prediction = X*theta;
    k1 = (prediction - y);
    k2 = k1.^2;
    csum = sum(k2);
    J = csum/size(y,1)*0.5;
end

function theta = gradientD(X, y, theta, alpha, iter)
    for i = 1:iter
        pre = X*theta;
        m = size(y, 1);
        error = (pre - y)/m;
        pJ = (sum(error.*X))';
        theta = theta - alpha*pJ;
    end
end





