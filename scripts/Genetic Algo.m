
load('feature_set');
load('training_set');

% ............ Feature Selection by Genetic Algorithm ...............


%group = [ones(1,10) zeros(1,10)]';
group = [ones(1,15) zeros(1,39)]'; % 10_fold_validation(Training)
%group = [ones(1,14) zeros(1,16)]';

% Declaring Variable Needed in GA-Process.............................

pop_count = 1; f_count=1;  best_chrom_percentage=0;
pop_size = 400; total_features = length(feature_set);
total_images = 6;              % Number of Testing Images
mutation_percent=0.2;          % 0.2 = 20
cross_percent = 0.5;
Genome_Size = total_features; % Maximum Gnome Size at Initial
Generation = 0;
Generation_limit = 40;
Image_class = [ones(1,5) zeros(1,1)]; % Labels of Test Images
True = 0;   % Used to Calculate Number of True Guesses
percentage=0; % Initial Percentage
highest_percentage = 0;
best_chrome = [zeros(1,total_features)];
child_count = 1;


% Initialze Population..............

pop = rand(pop_size,total_features);
pop = (pop > 0.45 & pop < 0.81);

while(Generation < Generation_limit)
    
    while(child_count < pop_size)
        
    % It will Randomly pick two parents , Evaluate them , The best will be
    % Returned. So here we Pick Two Parents.
    p1 = Tournament(pop,total_images,feature_set,training_set,group,Image_class,pop_size);
    p2 = Tournament(pop,total_images,feature_set,training_set,group,Image_class,pop_size);

    % Cross Over............................

    [c1 c2] = cross2(p1,p2,cross_percent);

    % Mutation..............................

    [c1 c2] = mutation2(c1,c2,mutation_percent);

    % Replacing Parents by New Born................

    pop(child_count,:) = c1;  pop(child_count+1,:) = c2;
    child_count = child_count + 2;
    end
    

% Fitness of New Born (........via KNN...........)

while(pop_count <= pop_size)
    while(f_count <= total_images)
        %values = feature_set(f_count,:) .* pop(pop_count,:);
        
        p = pop(pop_count,:);
        index = find(p == 1);
        
        % If we get Chrome = [0 0 0 0 0..0], flip the bits and don't go to classifier      
         if(isempty(index)) 
             pop_count = pop_count + 1;
             f_count = f_count+1;
             continue;
         end
        
        % Getting Feature Values at Index 1's
        f = feature_set(f_count,:);
        sample = f(index);
        
        % Evaluating Training matrix according to Selected features.....
        Training = training_set(:,[index]);
        
        res = knnclassify(sample,Training,group);
        
        if(res == Image_class(f_count))
            True = True+1;
        end
        f_count = f_count+1;
    end
    percentage = True/total_images;    % Normalized.............
    temp = pop(pop_count,:);
    temp = sum(temp(:));
    if(percentage > highest_percentage)
        highest_percentage = percentage;
        best_chrome = pop(pop_count,:);
        Genome_Size = temp;
    elseif(percentage == highest_percentage && temp < Genome_Size)
            best_chrome = pop(pop_count,:);
            Genome_Size = temp;   
    end
       True = 0; f_count = 1; 
       pop_count = pop_count+1;
end
% Reset the child_count for another Generation
child_count = 1;
pop_count = 1;
Generation = Generation+1
highest_percentage
Genome_Size

end % End of External While Loop...........
