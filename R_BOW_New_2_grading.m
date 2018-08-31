clear all; close all; clc;

% outputFolder = fullfile('J:/Bag Of Visual Words new/Codes/BoVW/R_bag-of-words/data/'); % define output folder
% 
% imds = imageDatastore(fullfile(outputFolder));

images = imageDatastore('D:\Ravi\Bag_Of_Visual_Words_new\Codes\BoVW\R_bag-of-words\data_grading\',...
    'IncludeSubfolders',true,...
    'LabelSource','foldernames');

images.ReadFcn = @(loc)imresize(imread(loc),[300,300]);
[trainingSet, validationSet] = splitEachLabel(images, 0.99999);
bag = bagOfFeatures(trainingSet);

img = readimage(images, 1);
featureVector = encode(bag, img);
feat = [];


for pp=1:length(images.Files)
    
    img = readimage(images, pp);
    featureVector = encode(bag, img);
    feat = [feat;featureVector];
    disp(['image no :',num2str(pp)]);
end;

feat_norm_messidor = normalize1(feat);

