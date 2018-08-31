clear;clear all;
addpath('D:\Ravi\Bag_Of_Visual_Words_new\Codes\BoVW\R_bag-of-words\code\data_grading\');

queryFile = './Xception_queryImgs.txt';
classesFile = './databaseClasses1.txt';
load feat_norm_lrtn_1000.mat
% load('feat_all_xception.mat');
trainingFeatures = feat_norm_lrtn_1000; 
imagefiles = dir('D:\Ravi\Bag_Of_Visual_Words_new\Codes\BoVW\R_bag-of-words\code\data_grading\*.tif'); 

nfiles = length(imagefiles);    % Number of files found
for ii=1:nfiles
   currentfilename = imagefiles(ii).name;
%    currentimage = imread(currentfilename);
   images{ii} = currentfilename;
end
 
imgNamList = images';


N = 5; % 如果用于论文中，把这个值设为你所用数�?�库的大�?

fid = fopen(queryFile,'rt');
queryImgs = textscan(fid, '%s');
fclose(fid);

fid = fopen(classesFile,'rt');
classesAndNum = textscan(fid, '%s %d');
fclose(fid);

for i = 1:length(classesAndNum{1, 1})
    classes{i,1} = classesAndNum{1, 1}{i,1}(1:3);
end

[numImg,d] = size(trainingFeatures);
querysNum = length(queryImgs{1, 1});

ap = zeros(querysNum,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i =1:querysNum
    queryName = queryImgs{1, 1}{i, 1};
    queryClass = queryName(1:3);
    
    [row,col]=ind2sub(size(imgNamList),strmatch(queryName,imgNamList,'exact'));
    queryFeat = trainingFeatures(row, :);
    
    [row1,col1]=ind2sub(size(classesAndNum{1, 1}),strmatch(queryClass,classes,'exact'));
    queryClassNum = double(classesAndNum{1, 2}(row1,1));
     
    %dist = distMat(queryFeat,feat_norm);
    %dist = dist';
    %[~, rank] = sort(dist, 'ascend');
    
    dist = zeros(numImg, 1);
    for j = 1:numImg
        VecTemp = trainingFeatures(j, :);
%       dist(j) = queryFeat*VecTemp';
        AS1 = (queryFeat)-(VecTemp);
        AS2 = 1+abs(queryFeat)+abs(VecTemp);
        AS = abs(AS1.^1)./abs(AS2.^1);
        b1w=(sum(sum(AS)));
        dist(j) = b1w;
%        
%         dist(j) = pdist2(queryFeat,VecTemp,'cityblock');
    end
    [~, rank] = sort(dist, 'ascend');
    
    similarTerm = 0;
    
    precision = zeros(N,1);
    
  k = N;
        topkClass = imgNamList{rank(k, 1), 1}(1:3);        
        if strcmp(queryClass,topkClass)==1;
            similarTerm = similarTerm+1;
            precision = similarTerm/k;
        end
    
    
    ima_analysis = similarTerm;
%     for k = 1:N
%         topkClass = imgNamList{rank(k, 1), 1}(1:3); 
%         % use for configure
%         subplot(4,3,k);
%         im = imread(imgNamList{rank(k, 1), 1});
%         imshow(im);
%     end
    

    ap(i,1) = sum(precision)/N;

    
    fprintf('%s ap is %f \n',queryName,ap(i,1));
    
end

mAP = sum(ap)/querysNum;
fprintf('mAP is %f \n',mAP*100);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

mAP1 = sum(ap(1:546))/546;
fprintf('mAP of normal is %f \n',mAP1*100);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% mAP2 = sum(ap(547:1200))/654;
% fprintf('mAP of DR is %f \n',mAP2*100);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mAP2 = sum(ap(547:701))/155;
fprintf('mAP of Grade1 is %f \n',mAP2*100);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mAP3 = sum(ap(702:948))/247;
fprintf('mAP of Grade2 is %f \n',mAP3*100);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mAP4 = sum(ap(949:1200))/252;
fprintf('mAP of Grade3 is %f \n',mAP4*100);




%  AS1=(query)-(feat_mmodified{ia,1});
%         AS2=1+abs(query)+abs(feat_mmodified{ia,1});
% 
%         AS=abs(AS1.^1)./abs(AS2.^1);
%         b1w=(sum(sum(AS)));
%     %     b2w=(sum(sum(AS(5:8,:))));
%     %     b3w=(sum(sum(AS(9:12,:))));
% 
%         eclu_dist_mean1(1,ia)=b1w; % weight given 0.5*b1w+0.5*b2w+0.5*b3w;






