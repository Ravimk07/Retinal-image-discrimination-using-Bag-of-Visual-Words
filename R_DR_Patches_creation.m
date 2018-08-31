%%%%%% Author: Ravi Kamble, SGGSIE & T, Nanded, India.
%%%%%% Contact:  ravikamble07@gmail.com

clear;close all;clc; 

% Run macular patch extraction on all 1200 MESSIDOR images

addpath('D:\Ravi\Database\Graded_messidor_images');

for k=949:1200
filename=strcat(int2str(k),'.tif');
y=double(imread(filename));
% crop the image
gh = R_fov_extract2(y);
[row,col] = size(gh(:,:,2));

x = row/2;
y = col/2; 

gh = uint8(gh);
% figure, imshow(gh) 


center     = [x, y]; % [x, y]
patchsize  = 371;         % odd number

angle      = 0;         % degree
rpatch1 = extractRotatedPatch(gh, center, patchsize, patchsize, angle); 
rpatch1 = uint8(rpatch1);
% angle      = 45;         % degree
% rpatch2 = extractRotatedPatch(gh, center, patchsize, patchsize, angle); 
% rpatch2 = uint8(rpatch2);
% angle      = -45;         % degree
% rpatch3 = extractRotatedPatch(gh, center, patchsize, patchsize, angle); 
% rpatch3 = uint8(rpatch3);

% figure, imshow(uint8(rpatch));

% % Resize accordingly the patch
% I2= imresize(I2,[400, 400]);
% % write all patches to the given folder
imwrite( rpatch1,['D:\Ravi\Database\DR data\DR with grading\Grade 2\','2_',int2str(k), '.tif']);
% imwrite( rpatch2,['/home/bukhari/Desktop/Ravi/Database/DR data/DR patches with grading/Grade 3/',int2str(k),'_2', '.tif']);
% imwrite( rpatch3,['/home/bukhari/Desktop/Ravi/Database/DR data/DR patches with grading/Grade 3/',int2str(k),'_3', '.tif']);
 
disp(['image no :',num2str(k)]);


end
