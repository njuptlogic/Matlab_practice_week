% 加载 Indian_pines 数据集
load('Indian_pines_data.mat'); % 假设文件包含变量 X 和 Y

% 检查数据格式
if ~exist('X', 'var') || ~exist('Y', 'var')
    error('数据集文件中必须包含 X (样本) 和 Y (类别标签) 两个变量');
end

% 删除类别为 0 的背景样本
valid_idx = Y > 0; % 类别标签大于 0 的索引
X = X(valid_idx, :);
Y = Y(valid_idx);

% 测试 1：按比例划分 (20%)
disp('测试 1: 按比例划分 (20%)');
partition1 = 0.2;
D_samp1 = data_partition(X, Y, partition1);
disp(['训练集样本数: ', num2str(length(D_samp1.Train_idx))]);
disp(['测试集样本数: ', num2str(length(D_samp1.Test_idx))]);

% 测试 2：每类固定数量划分 (10 个样本)
disp('测试 2: 每类固定数量划分 (10 个样本)');
partition2 = 10;
D_samp2 = data_partition(X, Y, partition2);
disp(['训练集样本数: ', num2str(length(D_samp2.Train_idx))]);
disp(['测试集样本数: ', num2str(length(D_samp2.Test_idx))]);

% 测试 3：按二维向量划分
disp('测试 3: 按二维向量划分');
partition3 = [1, 5; 2, 8; 3, 7; 4, 9; 5, 10; 6, 12; 7, 11; 8, 20; ...
              9, 20; 10, 18; 11, 15; 12, 15; 13, 20; 14, 16; 15, 20; 16, 20];
D_samp3 = data_partition(X, Y, partition3);
disp(['训练集样本数: ', num2str(length(D_samp3.Train_idx))]);
disp(['测试集样本数: ', num2str(length(D_samp3.Test_idx))]);

