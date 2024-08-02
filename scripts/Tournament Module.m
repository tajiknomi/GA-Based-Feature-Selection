% Tournament Selection

% Tournament b/w Random 2 Chromes, Function will Return the Best of Two Chromes


function [Best] = Tournament(pop,total_images,feature_set,training_set,group,Image_class,pop_size)
f_count = 1;
Best = 0;
True1 = 0;  
True2 = 0;
while(f_count < total_images)
    random = randperm(pop_size);
    
    p1 = pop(random(1),:);
    p2 = pop(random(2),:);
 
    % Getting Index of 1's...........
    
    index1 = find(p1 == 1);
    index2 = find(p2 == 1);
    
    % Getting Feature Values at Index 1's
    f1 = feature_set(f_count,:);
    sample1 = f1(index1);
    %f2 = feature_set(f_count,:);
    sample2 = f1(index2);
    
    % Evaluating Training matrix according to Selected features.....
    Training1 = training_set(:,[index1]);
    Training2 = training_set(:,[index2]);
    
    % KNN CLASSIFICATION............................
    if(sum(index1) || sum(index2) ~= 0)
    res1 = knnclassify(sample1,Training1,group);
    res2 = knnclassify(sample2,Training2,group);
    end
        if(res1 == Image_class(f_count))
            True1 = True1+1;
        end
        if(res2 == Image_class(f_count))
            True2 = True2+1;
        end
        f_count = f_count+1;
end

    if(True1 > True2)
        Best = p1;
    
    else
        Best = p2;
     end
end

