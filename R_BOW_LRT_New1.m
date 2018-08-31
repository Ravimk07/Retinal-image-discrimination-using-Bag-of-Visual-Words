clear all; close all; clc;
%%%%%%%%%%%%%%%%%%%%%%%%% Input image  %%%%%%%%%%%%%%%%%%%%%%%%
run('J:/Bag Of Visual Words new/Codes/BoVW/R_bag-of-words/vlfeat-0.9.20-bin/vlfeat-0.9.20/toolbox/vl_setup')
data_path = 'J:/Bag Of Visual Words new/Codes/BoVW/R_bag-of-words/data/'; %change if you want to work with a network copy


% images = imageDatastore('J:/Bag Of Visual Words new/Codes/BoVW/R_bag-of-words/data/',...
%     'IncludeSubfolders',true,...
%     'LabelSource','foldernames');
% 
% images.ReadFcn = @(loc)imresize(imread(loc),[227,227]);
% 
% [train_image_paths,validationImages] = splitEachLabel(images,0.6,'randomized');

% categories = {'Grade 0', 'Grade 1', 'Grade 2', 'Grade 3', 'Grade 4'};
% %This list of shortened category names is used later for visualization.
% abbr_categories = {'Gra 0', 'Gra 1', 'Gra 2', 'Gra 3', 'Gra 4'};   

categories = {'Grade 0', 'Grade 1', 'Grade 2', 'Grade 3'};
%This list of shortened category names is used later for visualization.
abbr_categories = {'Gra 0', 'Gra 1', 'Gra 2', 'Gra 3'};
%number of training examples per category to use. Max is 100. For
%simplicity, we assume this is the number of test cases per category, as well.
num_train_per_cat = 50; 
fprintf('Getting paths and labels for all train and test data\n')
[train_image_paths, test_image_paths, train_labels, test_labels] = ...
    get_image_paths(data_path, num_train_per_cat);

%%%%%%%%%%%%%%%%%  Sift Features%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% train_image_paths1 = {'J:\Bag Of Visual Words new\Codes\BoVW\R_bag-of-words\data\train\Grade 0\10_left.jpeg'}
vocab_size = 100; %Larger values will work better (to a point) but be slower to compute
 
if ~exist(['vocab_size', num2str(vocab_size),'.mat'], 'file')
    fprintf('No existing visual word vocabulary found. Computing one from training images\n')
    vocab = build_vocabulary(train_image_paths, vocab_size);
    save(['vocab_size', num2str(vocab_size),'.mat'], 'vocab');
end

% YOU CODE get_bags_of_sifts.m
if ~exist(['train_image_feats_size', num2str(vocab_size),'.mat'], 'file')
    train_image_feats = get_bags_of_sifts(train_image_paths, vocab_size);
    save(['train_image_feats_size', num2str(vocab_size), '.mat'], 'train_image_feats');
else
    load(['train_image_feats_size', num2str(vocab_size),'.mat']);
end

% if ~exist(['test_image_feats_size', num2str(vocab_size), '.mat'])
%     test_image_feats  = get_bags_of_sifts(test_image_paths, vocab_size);
%     save(['test_image_feats_size', num2str(vocab_size), '.mat'], 'test_image_feats');
% else
%     load(['test_image_feats_size', num2str(vocab_size), '.mat']);
% end



























