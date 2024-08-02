
%........................... Skull Stripping......................

clear,clc

m = imread('Capture.png');
 m = rgb2gray(m);

[r c] = size(m);

n1 = m(:,1:c/2);
n2 = m(:,(c/2)+1:c);
% figure,imshow(n1),figure,imshow(n2)
flag = 0;
for i=1:r
    for j=1:floor(c/2)

         if(n1(i,j) > 32)
            n1(i,j) = 0;flag=1;
            
        else if (15 < n1(i,j) < 58 & flag == 1)
                flag=0;break;
            end
        end
    end
end

n1 = n1>58;
% figure,imshow(n1),title('1st');
%.................Part 2nd.....................

n2 = fliplr(n2);
flag = 0;
for i=1:r
    for j=1:floor(c/2)

         if(n2(i,j) > 32)
            n2(i,j) = 0;flag=1;
            
        else if (15 < n2(i,j) < 58 & flag == 1)
                flag=0;break;
            end
        end
    end
end
n2 = n2>58;
n2 = fliplr(n2);
% figure,imshow(n2),title('Part 2');

%................. Merging Both Sides....................

n = [n1 n2];
n(1,c)=0;
n = bwareaopen(n,1500);
figure,imshow(n) , title('Merged Result');

%................. Removing Holes.......................
n = uint8(n);
R=0;
for i=1:r-7
    for j=1:c-7
        
        if(n(i,j) == 0)
            
                R = sum(sum(n(i:i+6,j:j+6)));
                if(R > 25)
                n(i,j) = 1;
                end
                
        end
    end
end

final = n(:,:) .* m(:,:);
diff = m-final;
figure,imshow(m,[]),title('Orignial');
figure,imshow(final,[]),title('Brain Only');
figure,imshow(diff,[]),title('Stripped Part');