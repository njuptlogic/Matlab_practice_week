% 读取图像
signature = imread('signature2.jpg'); % 假设您的签名图片名为signature1.jpg

% 转换为灰度图像
graySignature = rgb2gray(signature);

% 计算全局阈值
level = graythresh(graySignature);

% 使用全局阈值进行二值化
binarySignature = im2bw(graySignature, level);

% 使用形态学操作去除噪点
se = strel('disk', 2); % 创建一个结构元素
cleanSignature = imopen(binarySignature, se); % 腐蚀操作
cleanSignature = imclose(cleanSignature, se); % 膨胀操作

% 显示处理后的图像
imshow(cleanSignature);

% 保存处理后的图像
imwrite(cleanSignature, 'processed_signature2.jpg');


