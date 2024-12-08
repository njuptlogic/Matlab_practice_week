% 假设数据已经加载，类别标签存储在 ClassLabel 中，大小为 145x145
load('Indian_pines_data.mat')
% ClassLabel 是 Indian Pines 数据集的类别标签矩阵，包含16种类别，值从 0 到 16
ClassLabel = reshape(Y, 145, 145);
% 自定义的 colormap，包含17种颜色
myColormap = [
    0 0 0;       % 类别 0：背景（黑色）
    0.5 0 0;     % 类别 1
    0 0.5 0;     % 类别 2
    0 0 0.5;     % 类别 3
    1 0 0;       % 类别 4
    0 1 0;       % 类别 5
    0 0 1;       % 类别 6
    0.5 0.5 0;   % 类别 7
    0.5 0 0.5;   % 类别 8
    0 0.5 0.5;   % 类别 9
    1 1 0;       % 类别 10
    1 0 1;       % 类别 11
    0 1 1;       % 类别 12
    0.5 0.5 0.5; % 类别 13
    0.5 1 0;     % 类别 14
    1 0 0.5;     % 类别 15
    1 0.5 0;     % 类别 16
];

% 绘制类别标签图像
figure;
imagesc(ClassLabel);  % 显示类别标签图像
axis equal tight;     % 保证图像比例一致，并去除坐标轴的空白

% 应用自定义的 colormap
colormap(myColormap);

% 设置颜色条，并标记类别
caxis([0, 16]);  % 设置类别标签的范围为 [0, 16]
colorbar;  % 显示颜色条

% 为 colorbar 添加标签，使其对应每个类别
set(gca, 'Color', 'w');  % 设置图像背景为白色

% 添加标题和轴标签
title('Indian Pines 类别图');
xlabel('像素列');
ylabel('像素行');

% 设置颜色条的标签，使其从 0 到 16 显示
cb = colorbar;  
ylabel(cb, '类别标签');  % 给颜色条添加标签

