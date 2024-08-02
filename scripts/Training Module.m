% This module is Exactly same as feature Extraction, We just Collect the features of those images, which...
% ....we want to use for training the Classifier

for read_image_count=1:54 

im=imread(['C:\Users\nomi\Desktop\Train 3 png\' num2str(read_image_count) '.png']);
  

a = im;   % Copying Skull_Stripped image
clc
gray_levels = 16;

% GLCM matrix
glcm = graycomatrix(a,'NumLevels',gray_levels,'G',[],'offset',[0 1; -1 1; -1 0;-1 -1]);
glcm_0_degre = glcm(:,:,1);
glcm_45_degre = glcm(:,:,2);
glcm_90_degre = glcm(:,:,3);
glcm_135_degre = glcm(:,:,4);

% Sum of All Elements in GLCM's And Evaluating Joint Probability Matrix

for i=1:4
    a = glcm(:,:,i);
    summ = sum(sum(a));
    glcm_prob(:,:,i) = (glcm(:,:,i)/summ);
end

% Show Joint Probabilty Matrices

for i=1:4
    glcm_prob(:,:,i);
end

% Copying Joint Prob Matrices to New Matrices
Joint_Prob_0 = glcm_prob(:,:,1);
Joint_Prob_45 = glcm_prob(:,:,2);
Joint_Prob_90 = glcm_prob(:,:,3);
Joint_Prob_135 = glcm_prob(:,:,4);


% Calculation Px_Plus_Py
Px_Plus_Py = zeros(2*gray_levels,4);
for k=1:4
    a = glcm_prob(:,:,k);
    for i=1:gray_levels
        for j=1:gray_levels
            Px_Plus_Py(i+j-1,k) = Px_Plus_Py(i+j-1,k) + a(i,j);
        end
    end
end
Px_Plus_Py;

% Calculating Px_Sub_Py

Px_Sub_Py = zeros(gray_levels,4);
for k=1:4
    a = glcm_prob(:,:,k);
    for i=1:gray_levels
        for j=1:gray_levels
            Px_Sub_Py(abs(i-j)+1,k) = Px_Sub_Py(abs(i-j)+1,k) + a(i,j);
        end
    end
end
Px_Sub_Py;

% ....................................................

Px = zeros(gray_levels,4);
Py = zeros(gray_levels,4);

for i=1:4
a = glcm_prob(:,:,i);
Px(:,i) = sum(a,2);
Py(:,i) = sum(a,1)';
end
Px;
Py;

% .................  Means and Standard Deviations   .................................
mean_x = zeros(1,4); dev_x = zeros(1,4);
mean_y = zeros(1,4); dev_y = zeros(1,4);
for k = 1:4
    a = Px(:,k);
    b = Py(:,k);
    for i=1:gray_levels
            mean_x(1,k) = mean_x(1,k) + (i)*a(i);
            mean_y(1,k) = mean_x(1,k) + (i)*b(i);
            dev_x(k)  = dev_x(k)  + (((i) - mean_x(k))^2)*glcm_prob(i,j,k);
            dev_y(k)  = dev_y(k)  + (((j) - mean_y(k))^2)*glcm_prob(i,j,k);
        end
    end

mean_x
mean_y
dev_x = sqrt(dev_x)
dev_y = sqrt(dev_y)


% ......................... Correlation ...............
 
Correlation = zeros(1,4);
for k = 1:4
    a = glcm_prob(:,:,k);
    for i=1:gray_levels
        for j=1:gray_levels
            Correlation(k) = Correlation(k) + ((((i*j)*a(i,j))-(mean_x(k)*mean_y(k)))/(dev_x(k)* dev_y(k)));
        end
    end
end
Correlation




% Energy Feature ( Working )

Energy_0=0; Energy_45=0; Energy_90=0; Energy_135=0;

 
      Energy_0 = sum(Joint_Prob_0(:).^2);
      Energy_45 = sum(Joint_Prob_45(:).^2);
      Energy_90 = sum(Joint_Prob_90(:).^2);
      Energy_135 = sum(Joint_Prob_135(:).^2);
  
      Energy = [Energy_0 Energy_45 Energy_90 Energy_135]
      
 % Contrast Feature ( Working )
 
 Contrast = zeros(1,4);
 for k=1:4
     a = glcm_prob(:,:,k);
     for i=1:gray_levels
         for j=1:gray_levels
             Contrast(1,k) = Contrast(1,k) + ((i-j)^2 * a(i,j));
         end
     end
 end
 
 Contrast

 % Local Homogeneity, Inverse Difference Moment (IDM)
 %  1.3 Percent Error from Matlab Built-in Function i-e graycoprops(glcm)
 
 IDM = zeros(1,4);
 for i=1:gray_levels
     for j=1:gray_levels
         IDM(1,1) = IDM(1,1) + (Joint_Prob_0(i,j)/(1+(i-j)^2));
         IDM(1,2) = IDM(1,2) + (Joint_Prob_45(i,j)/(1+(i-j)^2));
         IDM(1,3) = IDM(1,3) + (Joint_Prob_90(i,j)/(1+(i-j)^2));
         IDM(1,4) = IDM(1,4) + (Joint_Prob_135(i,j)/(1+(i-j)^2));
     end
 end
     IDM
 
 % Entropy " Measure of Randomness "
 Entropy = zeros(1,4);
 for i=1:4
     a = glcm_prob(:,:,i);
     log_matrix = log(a+eps);
     Entropy(1,i) = - sum(sum(a(:,:) .* log_matrix(:,:)));
 end
 Entropy
 


 % Sum of Squares, Variance ( Not CHECKED YET)
 % For all Joint_Probability, Variance is Same, So no Need to Evaluate for
 % all
 
 Variance = zeros(1,k);
 for k = 1:4
 a = glcm_prob(:,:,k);
 muo = mean(a(:));
 for i=1:gray_levels
     for j=1:gray_levels
         Variance(1,k) =  Variance(1,k) + (((i - muo)^2) * a(i,j));
     end
 end
 end
 Variance
 
 % Sum Average ()
 Px_Py = 0;
 Sum_Average = zeros(1,4);
 for k=1:4
     a = Px_Plus_Py(:,k);
     for i=1:2*gray_levels
         Sum_Average(1,k) = Sum_Average(1,k) + (i * a(i));
     end
 end
 Sum_Average
 
 % Sum Entropy
 
 Sum_Entropy=zeros(1,4);
 for k=1:4
     a = Px_Plus_Py(:,k);
     log_a = log(a + eps);
     Sum_Entropy(1,k) = - sum(sum(a(:,:) .* log_a(:,:)));
 end
 
 Sum_Entropy
 
 
 
 % Difference Entropy
diff_Entropy=zeros(1,4);
 for k=1:4
     a = Px_Sub_Py(:,k);
     log_a = log(a + eps);
     diff_Entropy(1,k) = - sum(sum(a(:,:) .* log_a(:,:)));
 end
 
 diff_Entropy
 
 % INERTIA
 Inertia = zeros(1,4);
 for k=1:4
     a = glcm_prob(:,:,k);
     for i=1:gray_levels
         for j=1:gray_levels
             Inertia(1,k) = Inertia(1,k) + (((i-j)^2) * a(i,j));
         end
     end
 end
 Inertia
 
 % Cluster Shade
 Shade = zeros(1,4);
 for k=1:4
     a = glcm_prob(:,:,k);
     for i=1:gray_levels
         for j=1:gray_levels
             Shade(1,k) = Shade(1,k) + (((i+j-mean_x(k)-mean_y(k))^3) * a(i,j));
         end
     end
 end
 Shade
 
 % Cluster Prominence
 Prom = zeros(1,4);
 for k=1:4
     a = glcm_prob(:,:,k);
     for i=1:gray_levels
         for j=1:gray_levels
             Prom(1,k) = Prom(1,k) + (((i+j-mean_x(1,k)-mean_y(1,k))^4) * a(i,j));
         end
     end
 end
 Prom
 
 % MAXIMUM Probability ( 13 )

 max_prob = zeros(1,4);
 for k=1:4
     a = glcm_prob(:,:,k);
     max_prob(1,k) = max(a(:));
 end
 max_prob
 
 % Homogeneity , Inverse Difference Moment (IDM)
 Homogeneity = zeros(1,4);
 for k=1:4
     a = glcm_prob(:,:,k);
     for i=1:gray_levels
         for j=1:gray_levels
             Homogeneity(1,k) = Homogeneity(1,k) + (a(i,j)/(1+abs(i-j)));
         end
     end
 end
     Homogeneity
     
 % Dissimilarity
 
 Dissimilarity = zeros(1,4);
 for k=1:4
     a = glcm_prob(:,:,k);
     for i=1:gray_levels
         for j=1:gray_levels
             Dissimilarity(1,k) = Dissimilarity(1,k) + (abs(i-j) * a(i,j));
         end
     end
 end
 Dissimilarity
 
 % Copying all Results to a Single Matrix to Calculate its Mean , Range &
 % Deviation. ------ I had Remove PROM & COREELATION from this Matrix -----
 
 textural_measures = [Dissimilarity;Homogeneity;max_prob;Shade;Inertia;diff_Entropy;Sum_Entropy;Sum_Average;Variance;Entropy;IDM;Contrast;Energy;dev_y;dev_x;mean_y;mean_x];
 
 % Calculating Mean------ Range ----- Variance suggested by Haralick to
 % Avoid Angle Dependency
 
Mean_Feature_Matrix     =    mean(textural_measures,2);
Range_Feature_Matrix    =    range(textural_measures,2);
Variance_Feature_Matrix =    (var((textural_measures)'))';

training_set(read_image_count,:) = [(Mean_Feature_Matrix)',(Range_Feature_Matrix)',(Variance_Feature_Matrix)'];
end

% 8 out of 51 feature selected......

training_set = [training_set(:,6) training_set(:,7) training_set(:,9) training_set(:,16) training_set(:,30) training_set(:,32) training_set(:,43) training_set(:,48)];

% 5 feature selected.......
%training_set = [training_set(:,2) training_set(:,9) training_set(:,10) training_set(:,13) training_set(:,16)];
