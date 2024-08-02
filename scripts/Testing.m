load('3_feature_set');
load('group_set');
train = zeros(1,54);
group = zeros(54,1);
testing_images = 6;
% Variable Used to make the Train & Test Matrix in Running time.....
% Using 10_fold validation.....

for(k=1:2:9) % For KNN classifier, k = 1,3,5,7,9.....
    L = 1 ; H = 6; % Testing Matrix Variable
    M = 6; N = 13; % Training Matrix Variable
    True = 0;

for i=1:10
    if(i == 1 )
        % manually make the Training matrix
        train = feature_set(7:60,:);
        % manually make the Group matrix
        group = group_set(7:60,1);
        
    elseif(i == 10)
        % manually make the Training matrix
        train = feature_set(54:60,:);
        % manually make the Group matrix
        group = group_set(1:54,1);
    end
        % Making Testing Matrix......
        test = feature_set(L:H,:);
        image_class = group_set(L:H,1);
        L = H+1;
        H = L+5;
    
            if(i ~= 1)
                 % make the Training matrix
                train = feature_set([1:M,N:60],:);
                group = group_set([1:M,N:60],1);
                    M = M+6;
                    N = M+7;
            end
            
        %................. Testing Process Start ...............

        % Using KNN classifier......
        for j=1:testing_images   % Number of Images for testing is 6 here
        
        res = knnclassify(test(j,:),train,group,k);
            if(res == image_class(j))
                True = True+1;
            end
        end
        percentage(i) = True/testing_images;
        True = 0;
       
end
k
mean(percentage)
percentage = 0;
end