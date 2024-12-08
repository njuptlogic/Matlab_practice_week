% ���� Indian_pines ���ݼ�
load('Indian_pines_data.mat'); % �����ļ��������� X �� Y

% ������ݸ�ʽ
if ~exist('X', 'var') || ~exist('Y', 'var')
    error('���ݼ��ļ��б������ X (����) �� Y (����ǩ) ��������');
end

% ɾ�����Ϊ 0 �ı�������
valid_idx = Y > 0; % ����ǩ���� 0 ������
X = X(valid_idx, :);
Y = Y(valid_idx);

% ���� 1������������ (20%)
disp('���� 1: ���������� (20%)');
partition1 = 0.2;
D_samp1 = data_partition(X, Y, partition1);
disp(['ѵ����������: ', num2str(length(D_samp1.Train_idx))]);
disp(['���Լ�������: ', num2str(length(D_samp1.Test_idx))]);

% ���� 2��ÿ��̶��������� (10 ������)
disp('���� 2: ÿ��̶��������� (10 ������)');
partition2 = 10;
D_samp2 = data_partition(X, Y, partition2);
disp(['ѵ����������: ', num2str(length(D_samp2.Train_idx))]);
disp(['���Լ�������: ', num2str(length(D_samp2.Test_idx))]);

% ���� 3������ά��������
disp('���� 3: ����ά��������');
partition3 = [1, 5; 2, 8; 3, 7; 4, 9; 5, 10; 6, 12; 7, 11; 8, 20; ...
              9, 20; 10, 18; 11, 15; 12, 15; 13, 20; 14, 16; 15, 20; 16, 20];
D_samp3 = data_partition(X, Y, partition3);
disp(['ѵ����������: ', num2str(length(D_samp3.Train_idx))]);
disp(['���Լ�������: ', num2str(length(D_samp3.Test_idx))]);

