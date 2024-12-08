% ��ȡͼ��
signature = imread('signature2.jpg'); % ��������ǩ��ͼƬ��Ϊsignature1.jpg

% ת��Ϊ�Ҷ�ͼ��
graySignature = rgb2gray(signature);

% ����ȫ����ֵ
level = graythresh(graySignature);

% ʹ��ȫ����ֵ���ж�ֵ��
binarySignature = im2bw(graySignature, level);

% ʹ����̬ѧ����ȥ�����
se = strel('disk', 2); % ����һ���ṹԪ��
cleanSignature = imopen(binarySignature, se); % ��ʴ����
cleanSignature = imclose(cleanSignature, se); % ���Ͳ���

% ��ʾ������ͼ��
imshow(cleanSignature);

% ���洦����ͼ��
imwrite(cleanSignature, 'processed_signature2.jpg');


