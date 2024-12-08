
function D_samp = data_partition(X, Y, partition)
    % 检查输入参数
    if nargin < 3
        error('必须提供 X、Y 和 partition 三个参数');
    end
    
    % 检查 X 和 Y 的尺寸是否匹配
    if isempty(X) || isempty(Y)
        error('数据集 X 和标签 Y 不能为空');
    end
    if size(X, 1) ~= length(Y)
        error('X 的行数必须与 Y 的长度一致');
    end
    
    % 忽略类别 0
    unique_classes = unique(Y);
    unique_classes(unique_classes == 0) = [];
    
    % 初始化输出变量
    Train_idx = [];
    Test_idx = [];
    
    % 根据 partition 的类型处理
    if isscalar(partition) && partition > 0 && partition < 1
        % 情况 1：按比例划分
        for c = unique_classes'
            class_idx = find(Y == c);
            n_samples = length(class_idx);
            n_train = floor(partition * n_samples);
            
            if n_train == 0
                error('训练集样本数不足，请调整 partition 比例');
            end
            
            rand_idx = randperm(n_samples);
            Train_idx = [Train_idx; class_idx(rand_idx(1:n_train))];
            Test_idx = [Test_idx; class_idx(rand_idx(n_train+1:end))];
        end
        
    elseif isscalar(partition) && partition >= 1
        % 情况 2：按固定数量划分
        for c = unique_classes'
            class_idx = find(Y == c);
            n_samples = length(class_idx);
            
            if partition > n_samples
                error('类别 %d 的样本数不足，无法抽取 %d 个样本', c, partition);
            end
            
            rand_idx = randperm(n_samples);
            Train_idx = [Train_idx; class_idx(rand_idx(1:partition))];
            Test_idx = [Test_idx; class_idx(rand_idx(partition+1:end))];
        end
        
    elseif ismatrix(partition) && size(partition, 2) == 2
        % 情况 3：按二维向量指定数量划分
        if size(partition, 1) ~= length(unique_classes)
            error('partition 的类别数量与数据集中的类别数量不一致');
        end
        
        for i = 1:size(partition, 1)
            c = partition(i, 1);
            n_train = partition(i, 2);
            
            if ~ismember(c, unique_classes)
                error('类别 %d 不在数据集中', c);
            end
            
            class_idx = find(Y == c);
            n_samples = length(class_idx);
            
            if n_train > n_samples
                error('类别 %d 的样本数不足，无法抽取 %d 个样本', c, n_train);
            end
            
            rand_idx = randperm(n_samples);
            Train_idx = [Train_idx; class_idx(rand_idx(1:n_train))];
            Test_idx = [Test_idx; class_idx(rand_idx(n_train+1:end))];
        end
        
    else
        error('输入 partition 格式错误，请检查');
    end
    
    % 输出结果
    D_samp.Train_idx = Train_idx;
    D_samp.Test_idx = Test_idx;
end

