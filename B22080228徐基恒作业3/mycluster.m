
% �������ݼ� X ����ʵ��ǩ true_labels
% ʹ�����õ�ʾ�����ݼ� Iris ���ݼ���Ϊ��ʾ
load fisheriris  % ʹ��MATLAB�Դ����β�����ݼ�
X = meas;         % X �� 150 x 4 ����ÿһ����һ������
true_labels = grp2idx(species);  % Y �� 150 x 1 ��ֵ��ǩ����ʾÿ�����������1=Setosa, 2=Versicolor, 3=Virginica��

% ʹ�� kmeans ���о���
num_clusters = 3;  % �趨���������
[idx, C] = kmeans(X, num_clusters);  % idx Ϊ��������C Ϊ��������

% ���������ǩ��ƥ����ʵ��ǩ
% ���ȣ��ҵ�ÿ�������еĴ������ʵ��ǩ
cluster_labels = zeros(num_clusters, 1);

for i = 1:num_clusters
    cluster_members = true_labels(idx == i);  % ��ǰ�������ʵ��ǩ
    % �ҵ���ǰ����������ı�ǩ
    cluster_labels(i) = mode(cluster_members);
end

% ͨ�������ǩ��ģʽ������Ԥ���ǩ
predicted_labels = cluster_labels(idx);



% �������׼ȷ��
accuracy = calculate_accuracy(true_labels, predicted_labels);
disp(['Clustering accuracy: ', num2str(accuracy)]);

% ���ӻ�������
figure;
gscatter(X(:,1), X(:,2), idx, 'rbg', 'o', 8);  % ʹ�ò�ͬ��ɫ���ƾ���
xlabel('���೤��');
ylabel('������');
title('K-means ������');

% calculate_accuracy ����
function accuracy = calculate_accuracy(true_labels, predicted_labels)
    % ��������Ƿ���Ч
    if length(true_labels) ~= length(predicted_labels)
        error('��ʵ��ǩ��Ԥ���ǩ�ĳ��ȱ�����ͬ');
    end
    
    % ������ȷԤ�������
    correct_predictions = sum(true_labels == predicted_labels);
    
    % �����ܵ�Ԥ������
    total_predictions = length(true_labels);
    
    % ����׼ȷ��
    accuracy = correct_predictions / total_predictions;
end





