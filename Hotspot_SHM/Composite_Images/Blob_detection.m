clc;
clear all;
close all;

j = 4; % Step number, can be set from 1 to 8, here for instance j = 6
composite = strcat('Fused_INV_Diff_00-60_Step', num2str(j), '.png');% Load the file
img = imread(composite); % Read image into 'composite' matrix
I = mat2gray(rgb2gray(img));% Convert the RGB image into greyscale
BW =  I < 0.9; % Sort out any pixels which have more than 80% intensity (0.8*256), save in logical matrix BW
B = bwboundaries(BW,'noholes',8); % From image processing toolbox, trace region boundaries in binary image, save in cell 'B' (= blobs)
s = regionprops(BW,'Area'); % Read the properties of the matrix BW, we are interested in the areas

for k = 1:length(B) % For all blobs:
    S(k) = s(k).Area; % Save the area information from the region properties into matrix S
    [val ind] = sort(S,'descend'); % Sort from the largest area into smallest area. Area = unit of pixel
end

imshow(I); % Show the image
N = length(B); % Count how many blobs are detected
boundary = {}; % Prepare the empty cell for all blobs
X = []; Y = []; % Prepare the empty array for the blob centroid coordinates

for m = 1:N % For all blobs:
    boundary{m}(:,:,1) = B{ind(m)}; % Fill the cell 'boundary' with blob boundaries
    centroids = round(mean(boundary{m})); % Calculate the centroid (mean) of the blob boundaries
    X = [X centroids(2)]; % Store the X-coordinate centroid in array X
    Y = [Y centroids(1)]; % Store the Y-coordinate centroid in array Y
    hold on
    plot(boundary{m}(:,2), boundary{m}(:,1), 'r', 'LineWidth', 2) % plot the blob boundaries
end

fprintf('X-Y Coordinate of the largest centroid is:');
[X(1) Y(1)]
fprintf('X-Y Coordinate of the second largest centroid is:');
[X(2) Y(2)]

plot(X(1),Y(1),'r.','MarkerSize',100); % Show the largest centroid in the image
plot(X(2),Y(2),'g.','MarkerSize',75); % Show the second largest centroid in the image
plot(X(3:N),Y(3:N),'b.','MarkerSize',25); % Show the remaining centroids in the image
hold off