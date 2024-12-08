
function D_samp = data_partition(X, Y, partition)
    % ����������
    if nargin < 3
        error('�����ṩ X��Y �� partition ��������');
    end
    
    % ��� X �� Y �ĳߴ��Ƿ�ƥ��
    if isempty(X) || isempty(Y)
        error('���ݼ� X �ͱ�ǩ Y ����Ϊ��');
    end
    if size(X, 1) ~= length(Y)
        error('X ������������ Y �ĳ���һ��');
    end
    
    % ������� 0
    unique_classes = unique(Y);
    unique_classes(unique_classes == 0) = [];
    
    % ��ʼ���������
    Train_idx = [];
    Test_idx = [];
    
    % ���� partition �����ʹ���
    if isscalar(partition) && partition > 0 && partition < 1
        % ��� 1������������
        for c = unique_classes'
            class_idx = find(Y == c);
            n_samples = length(class_idx);
            n_train = floor(partition * n_samples);
            
            if n_train == 0
                error('ѵ�������������㣬����� partition ����');
            end
            
            rand_idx = randperm(n_samples);
            Train_idx = [Train_idx; class_idx(rand_idx(1:n_train))];
            Test_idx = [Test_idx; class_idx(rand_idx(n_train+1:end))];
        end
        
    elseif isscalar(partition) && partition >= 1
        % ��� 2�����̶���������
        for c = unique_classes'
            class_idx = find(Y == c);
            n_samples = length(class_idx);
            
            if partition > n_samples
                error('��� %d �����������㣬�޷���ȡ %d ������', c, partition);
            end
            
            rand_idx = randperm(n_samples);
            Train_idx = [Train_idx; class_idx(rand_idx(1:partition))];
            Test_idx = [Test_idx; class_idx(rand_idx(partition+1:end))];
        end
        
    elseif ismatrix(partition) && size(partition, 2) == 2
        % ��� 3������ά����ָ����������
        if size(partition, 1) ~= length(unique_classes)
            error('partition ��������������ݼ��е����������һ��');
        end
        
        for i = 1:size(partition, 1)
            c = partition(i, 1);
            n_train = partition(i, 2);
            
            if ~ismember(c, unique_classes)
                error('��� %d �������ݼ���', c);
            end
            
            class_idx = find(Y == c);
            n_samples = length(class_idx);
            
            if n_train > n_samples
                error('��� %d �����������㣬�޷���ȡ %d ������', c, n_train);
            end
            
            rand_idx = randperm(n_samples);
            Train_idx = [Train_idx; class_idx(rand_idx(1:n_train))];
            Test_idx = [Test_idx; class_idx(rand_idx(n_train+1:end))];
        end
        
    else
        error('���� partition ��ʽ��������');
    end
    
    % ������
    D_samp.Train_idx = Train_idx;
    D_samp.Test_idx = Test_idx;
end

