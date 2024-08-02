

for read_image_count=1:60 %suppose there are 60 images
x(:,:,read_image_count) = imread(['C:\Users\nomi\Desktop\png\' num2str(read_image_count) '.png']);

end

%% wavelet feature Extraction
ENGY=zeros(60,2);
for gk=1:60
    [CA CD]=dwt(x(:,:,gk),'haar');
    ENGY(gk,1)=sum(abs(CA(:)).^2);
    ENGY(gk,2)=sum(abs(CD(:)).^2);
end
ENGY=ENGY';
meann=mean(ENGY);
varnc=var(ENGY);
 
ENRGY=zeros(60,4);
for gk=1:60
    [CLL CLH CHL CHH]=dwt2(x(:,:,gk),'haar');
    ENRGY(gk,1)=sum(abs(CLL(:)).^2);
    ENRGY(gk,2)=sum(abs(CLH(:)).^2);
    ENRGY(gk,3)=sum(abs(CHL(:)).^2);
    ENRGY(gk,4)=sum(abs(CHH(:)).^2);
end
ENRGY=ENRGY';
meann1=mean(ENRGY);
varnc1=var(ENRGY);
ENGY1=zeros(60,2);
for gk=1:60
    [CA CD]=dwt(x(:,:,gk),'sym2');
    ENGY1(gk,1)=sum(abs(CA(:)).^2);
    ENGY1(gk,2)=sum(abs(CD(:)).^2);
end
ENGY1=ENGY1';
meann2=mean(ENGY1);
varnc2=var(ENGY1);
 
ENRGY1=zeros(60,4);
for gk=1:60
    [CLL CLH CHL CHH]=dwt2(x(:,:,gk),'sym2');
    ENRGY1(gk,1)=sum(abs(CLL(:)).^2);
    ENRGY1(gk,2)=sum(abs(CLH(:)).^2);
    ENRGY1(gk,3)=sum(abs(CHL(:)).^2);
    ENRGY1(gk,4)=sum(abs(CHH(:)).^2);
end
ENRGY1=ENRGY1';
meann3=mean(ENRGY1);
varnc3=var(ENRGY1);
ENGY2=zeros(60,2);
for gk=1:60
    [CA CD]=dwt(x(:,:,gk),'db5');
    ENGY2(gk,1)=sum(abs(CA(:)).^2);
    ENGY2(gk,2)=sum(abs(CD(:)).^2);
end
ENGY2=ENGY2';
meann4=mean(ENRGY1);
varnc4=var(ENRGY1);
ENRGY2=zeros(60,4);
for gk=1:60
    [CLL CLH CHL CHH]=dwt2(x(:,:,gk),'db5');
    ENRGY2(gk,1)=sum(abs(CLL(:)).^2);
    ENRGY2(gk,2)=sum(abs(CLH(:)).^2);
    ENRGY2(gk,3)=sum(abs(CHL(:)).^2);
    ENRGY2(gk,4)=sum(abs(CHH(:)).^2);
end
ENRGY2=ENRGY2';
meann5=mean(ENRGY2);
varnc5=var(ENRGY2);
feature_set = [meann' meann1' meann2' meann3' meann4' meann5' varnc' varnc1' varnc2' varnc3' varnc4' varnc5' ];


