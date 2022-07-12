function test1()
clc;  % Clear command window.
clear;  % Delete all variables.
close all;  % Close all figure windows except those created by imtool.
imtool close all;  % Close all figure windows created by imtool.
workspace;  % Make sure the workspace panel is showing.
fontSize = 16;
% Read in a standard MATLAB gray scale demo image.
folder = fullfile(matlabroot, '\toolbox\images\imdemos');
baseFileName = 'cameraman.tif';
% Get the full filename, with path prepended.
fullFileName = fullfile(folder, baseFileName);
% Check if file exists.
if ~exist(fullFileName, 'file')
  % File doesn't exist -- didn't find it there.  Check the search path for it.
  fullFileName = baseFileName; % No path this time.
  if ~exist(fullFileName, 'file')
    % Still didn't find it.  Alert user.
    errorMessage = sprintf('Error: %s does not exist in the search path folders.', fullFileName);
    uiwait(warndlg(errorMessage));
    return;
  end
end
grayImage = imread(fullFileName);
% Get the dimensions of the image.
% numberOfColorBands should be = 1.
[rows columns numberOfColorBands] = size(grayImage);
% Display the original gray scale image.
subplot(2, 2, 1);
imshow(grayImage, []);
title('Original Grayscale Image', 'FontSize', fontSize);
% Enlarge figure to full screen.
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
% Give a name to the title bar.
set(gcf,'name','Demo by ImageAnalyst','numbertitle','off')
% Prompt user to draw a region on the image.
message = sprintf('Draw a box over the image.\nDouble click inside the box to finish drawing.');
uiwait(msgbox(message));
% Erase all previous lines.
ClearLinesFromAxes();
hBox = imrect;
roiPosition = wait(hBox);
roiPosition
% Erase all previous lines.
ClearLinesFromAxes();
xCoords = [roiPosition(1), roiPosition(1)+roiPosition(3), roiPosition(1)+roiPosition(3), roiPosition(1), roiPosition(1)];
yCoords = [roiPosition(2), roiPosition(2), roiPosition(2)+roiPosition(4), roiPosition(2)+roiPosition(4), roiPosition(2)];
% Plot the mask as an outline over the image.
hold on;
plot(xCoords, yCoords, 'linewidth', 2);
% Convert to integer
xCoords = int32(xCoords);
xCoords = int32(xCoords);
% Crop the image
croppedImage = imcrop(grayImage, roiPosition);
subplot(2, 2, 2);
imshow(croppedImage, []);
title('Cropped Grayscale Image', 'FontSize', fontSize);
% Now read in image 2
% Read in a standard MATLAB gray scale demo image.
folder = fullfile(matlabroot, '\toolbox\images\imdemos');
baseFileName = 'moon.tif';
% Get the full filename, with path prepended.
fullFileName = fullfile(folder, baseFileName);
% Check if file exists.
if ~exist(fullFileName, 'file')
  % File doesn't exist -- didn't find it there.  Check the search path for it.
  fullFileName = baseFileName; % No path this time.
  if ~exist(fullFileName, 'file')
    % Still didn't find it.  Alert user.
    errorMessage = sprintf('Error: %s does not exist in the search path folders.', fullFileName);
    uiwait(warndlg(errorMessage));
    return;
  end
end
grayImage2 = imread(fullFileName);
% Get the dimensions of the image.
% numberOfColorBands should be = 1.
[rows2 columns2 numberOfColorBands2] = size(grayImage2);
% Make sure roiPosition doesn't go outside the image...
% Display the second gray scale image.
subplot(2, 2, 3);
imshow(grayImage2, []);
title('Second Grayscale Image', 'FontSize', fontSize);
% Crop the second image
croppedImage2 = imcrop(grayImage2, roiPosition);
subplot(2, 2, 4);
imshow(croppedImage2, []);
title('Cropped Second Grayscale Image', 'FontSize', fontSize);
%====================================================================================================================== 
% Erases all lines from the image axes.  The current axes should be set first using the axes()
% command before this function is called, as it works from the current axes, gca.
function ClearLinesFromAxes()
  axesHandlesToChildObjects = findobj(gca, 'Type', 'line');
  if ~isempty(axesHandlesToChildObjects)
    delete(axesHandlesToChildObjects);
  end
  return; % from ClearLinesFromAxes