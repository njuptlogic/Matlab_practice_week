% 定义目标函数 f(x, y)
f = @(x, y) sin(x) .* cos(y) + (x-1).^2 / 4 + (y-2).^2 / 6;

% 设置随机游走的参数
max_iter = 1000;                % 最大迭代次数
convergence_threshold = 1e-6;   % 收敛阈值
step_size = 1;                % 初始步长
x_min = -5;                     % x的最小值
x_max = 5;                      % x的最大值
y_min = -5;                     % y的最小值
y_max = 5;                      % y的最大值

% 初始化
x_current = rand * (5) ;  % 随机初始化x
y_current = rand * (5) ;  % 随机初始化y
%x_current = -1.3;
%y_current = -4;
%x_current = 3;
%y_current = 4;
f_current = f(x_current, y_current);         % 计算初始的函数值
path_x = x_current;                         % 路径记录x坐标
path_y = y_current;                         % 路径记录y坐标
path_f = f_current;                         % 路径记录函数值

% 随机游走算法
for iter = 1:max_iter
    % 随机扰动
   
    x_new = x_current + step_size * randn;  % 在x方向扰动
    y_new = y_current + step_size * randn;  % 在y方向扰动

    % 确保新点在定义域范围内
    x_new = max(min(x_new, x_max), x_min);
    y_new = max(min(y_new, y_max), y_min);

    % 计算新点的函数值
    f_new = f(x_new, y_new);

    % 如果新点的函数值更小，接受新解
    if f_new < f_current
        x_current = x_new;
        y_current = y_new;
        f_current = f_new;
        
        % 记录新的解和函数值
        path_x = [path_x, x_current];
        path_y = [path_y, y_current];
        path_f = [path_f, f_current];
    end

     if iter > 1 && abs(f_new - f_current) < 0.01 * f_current
         step_size = step_size * 0.95; % 当变化小于一定比例时减小步长
     end

    % 收敛判断：如果函数值变化小于设定阈值，停止迭代
    if length(path_f) > 1 && abs(path_f(end) - path_f(end-1)) < convergence_threshold
        disp('Convergence achieved. Stopping.');
        break;
    end
end
% 输出最优解和对应的函数值
disp(['Optimal solution: x = ', num2str(x_current), ', y = ', num2str(y_current)]);
disp(['Optimal function value: f(x, y) = ', num2str(f_current)]);

% 可视化搜索路径和函数曲面
[x_grid, y_grid] = meshgrid(linspace(x_min, x_max, 100), linspace(y_min, y_max, 100));
z_grid = f(x_grid, y_grid);

% 绘制函数曲面
figure;
surf(x_grid, y_grid, z_grid);
hold on;

% 绘制搜索路径
plot3(path_x, path_y, path_f, 'r-o', 'MarkerFaceColor', 'r', 'MarkerSize', 5);

xlabel('x');
ylabel('y');
zlabel('f(x, y)');
title('Random Walk Search for Global Minimum');













