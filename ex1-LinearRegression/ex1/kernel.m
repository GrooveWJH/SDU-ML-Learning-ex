clear; clc
rng(0)
n = 300;
x1 = rand(n,1);
x2 = rand(n,1);
x1 = x1*10-5;
x2 = x2*10-5;
x = [x1, x2, zeros(n,1)];
a = 2;
b = 3;
for i = 1:n
    if x(i,1)^2/a^2 + x(i,2)^2/b^2 < 1
        x(i, 3 ) = 1;
    end
end
k0 = find(x(:,3) == 0);
k1 = find(x(:,3) == 1);

% xx0 = x(:,k0);
% xx1 = x(:,k1);
figure,scatter(x(k0,1),x(k0,2), 'r*');
hold on
scatter(x(k1,1),x(k1,2), 'b*');
hold off;
z1 = x(:,1).^2;
z2 = x(:,1).*x(:,2)*sqrt(2);
z3 = x(:,2).^2;
figure,scatter3(z1(k0), z2(k0), z3(k0), 'r*');
hold on;
scatter3(z1(k1), z2(k1), z3(k1), 'b*');
hold off;
xlabel('z1');ylabel('z2');zlabel('z3');


kkk = 1;