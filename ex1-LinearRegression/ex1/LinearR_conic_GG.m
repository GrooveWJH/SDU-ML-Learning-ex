%%
function LinearR_conic_fixed()
    % 装入数据
    data = load('ex1data1.txt');
    x = data(:,1);
    y = data(:,2);
    figure, plot(x, y,'bo','MarkerSize',5);
    hold on
    X = [ones(length(x),1),x,x.^2];
    theta = [0;0;0];
    iter = 1000;
    alpha = 0.001;
    theta = gradientD(X, y, theta, alpha, iter);
    %% 开始绘制二次曲线
    ConicX = (1:0.1:max(x))'; %x从1每次走0.1走到x的最大值,由单行转置为单列
    ConicY = theta(1,1) + theta(2,1)*ConicX + theta(3,1)*(ConicX.^2);
    plot(ConicX,ConicY,'r','LineWidth', 1.8);
    legend('Training data', 'Linear regression')
    hold off;
end
%%
function theta = gradientD(X, y, theta, alpha, iter)
    for i = 1:iter
        Y = X*theta;
        m = length(Y);
        cost = (Y - y)/m;
        offset = (sum(cost.*X));
        theta = theta - alpha*offset;
    end
end
%%



