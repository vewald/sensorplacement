clc
clear all
close all

for j = 1:8
    
D00 = strcat('D00_Step', num2str(j), '.png');% Load the file
img_D00 = imread(D00);
%D28 = strcat('D28_Step', num2str(j), '.png');% Load the file
%img_D28 = imread(D28);
%D30 = strcat('D30_Step', num2str(j), '.png');% Load the file
%img_D30 = imread(D30);
D60 = strcat('D60_Step', num2str(j), '.png');% Load the file
img_D60 = imread(D60);

% Make image subtraction for both component
diff_pos_60 = img_D00 - img_D60;
diff_neg_60 = img_D60 - img_D00;

% Fused the subtracted images and make inverse
composite_60 = imcomplement(imfuse(diff_pos_60,diff_neg_60));

% Optional: Output file if necessary
%diff_img_60 = strcat('Fused_INV_Diff_00-60_Step', num2str(j), '.png')
%imwrite(composite_60,diff_img_60)

% Show images
subplot(2,4,j)
imshow(composite_60)

end