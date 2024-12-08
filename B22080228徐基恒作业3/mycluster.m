
% 假设数据集 X 和真实标签 true_labels
% 使用内置的示例数据集 Iris 数据集作为演示
load fisheriris  % 使用MATLAB自带的鸢尾花数据集
X = meas;         % X 是 150 x 4 矩阵，每一行是一个样本
true_labels = grp2idx(species);  % Y 是 150 x 1 数值标签，表示每个样本的类别（1=Setosa, 2=Versicolor, 3=Virginica）

% 使用 kmeans 进行聚类
num_clusters = 3;  % 设定聚类的数量
[idx, C] = kmeans(X, num_clusters);  % idx 为聚类结果，C 为聚类中心

% 调整聚类标签以匹配真实标签
% 首先，找到每个聚类中的大多数真实标签
cluster_labels = zeros(num_clusters, 1);

for i = 1:num_clusters
    cluster_members = true_labels(idx == i);  % 当前聚类的真实标签
    % 找到当前聚类中最常见的标签
    cluster_labels(i) = mode(cluster_members);
end

% 通过聚类标签的模式来生成预测标签
predicted_labels = cluster_labels(idx);



% 计算聚类准确率
accuracy = calculate_accuracy(true_labels, predicted_labels);
disp(['Clustering accuracy: ', num2str(accuracy)]);

% 可视化聚类结果
figure;
gscatter(X(:,1), X(:,2), idx, 'rbg', 'o', 8);  % 使用不同颜色绘制聚类
xlabel('花萼长度');
ylabel('花萼宽度');
title('K-means 聚类结果');

% calculate_accuracy 函数
function accuracy = calculate_accuracy(true_labels, predicted_labels)
    % 检查输入是否有效
    if length(true_labels) ~= length(predicted_labels)
        error('真实标签和预测标签的长度必须相同');
    end
    
    % 计算正确预测的数量
    correct_predictions = sum(true_labels == predicted_labels);
    
    % 计算总的预测数量
    total_predictions = length(true_labels);
    
    % 计算准确度
    accuracy = correct_predictions / total_predictions;
end





