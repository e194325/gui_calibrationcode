%POD calibration code
clear

%%calibration folder
calibration_folder = uigetdir


%%Part to select ROI
folder = calibration_folder;
fileList = dir(fullfile(folder, '/*.tiff'));
randomIndex = randi(length(fileList), 1, 1) % Get random number.
fullFileName = fullfile(folder, fileList(randomIndex).name)
img_roi = imread(fullFileName);
img_roi(:,:,4) = [];

figure
subplot(2, 2, 1);
imshow(img_roi, []);
% Enlarge figure to full screen.
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
% Prompt user to draw a region on the image.
message = sprintf('Draw a box over the image.\nDouble click inside the box to finish drawing.');
uiwait(msgbox(message));
% Erase all previous lines.
hBox = imrect;
roiPosition = wait(hBox);
roiPosition
% Erase all previous lines.
xCoords = [roiPosition(1), roiPosition(1)+roiPosition(3), roiPosition(1)+roiPosition(3), roiPosition(1), roiPosition(1)];
yCoords = [roiPosition(2), roiPosition(2), roiPosition(2)+roiPosition(4), roiPosition(2)+roiPosition(4), roiPosition(2)];
% Plot the mask as an outline over the image.
hold on;
plot(xCoords, yCoords, 'linewidth', 2);
% Convert to integer
xCoords = int32(xCoords);
xCoords = int32(xCoords);
% Crop the image
croppedImage = imcrop(img_roi, roiPosition);
subplot(2, 2, 2);
imshow(croppedImage, []);
title('Cropped Image');

%%Calibration Windows Size
prompt = {'Width(px) :','Height(px):'};
dlgtitle = 'Calibration Windows Size';
dims = [1 20];
definput = {'128','64'};
window_size = inputdlg(prompt,dlgtitle,dims,definput);
window_size=str2num(cell2mat(window_size));

%Calibrationw

