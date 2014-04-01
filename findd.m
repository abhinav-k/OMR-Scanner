function findd(name111,count,fileId)
clear all;
close all;
%ImageVariable='scan0018.jpg';
ImageVariable=name111;
main=imread(ImageVariable);
main=imresize(main,[2360,1700]);
MainPattern=imread('C:\Users\konda\Desktop\images\pattern.jpg');
zsize=size(size(main));
if zsize(1,2)==3
    meinn=main;
    main=rgb2gray(main);
end
zsize=size(main);
InitialSplit=zsize(1,2)/2;
temp1=imcrop(main,[0,0,InitialSplit,zsize(1,1)]);
temp2=imcrop(main,[InitialSplit+1,0,InitialSplit,zsize(1,1)]);
%figure(1),imshow(temp1);
%figure(2),imshow(temp2);
sceneImage=temp1;
boxImage=MainPattern;
newBoxPolygon=matchPattern(sceneImage,boxImage);
if newBoxPolygon(1,2)>(zsize(1,1)/2)

    main=imrotate(main,180,'nearest','crop');
    
InitialSplit=zsize(1,2)/2;
temp1=imcrop(main,[0,0,InitialSplit,zsize(1,1)]);
temp2=imcrop(main,[InitialSplit+1,0,InitialSplit,zsize(1,1)]);
sceneImage=main;
newBoxPolygon=matchPattern(sceneImage,boxImage);
%close all;
%figure(3),imshow(temp1);
%figure(4),imshow(temp2);
end
m=(newBoxPolygon(2,2)-newBoxPolygon(1,2))/(newBoxPolygon(2,1)-newBoxPolygon(1,1));
tiltedAngle=double(radtodeg(atan(m)));

main=imrotate(main,tiltedAngle,'bilinear','crop');
    
InitialSplit=zsize(1,2)/2;

temp1=imcrop(main,[0,0,InitialSplit,zsize(1,1)]);
temp2=imcrop(main,[InitialSplit+1,0,InitialSplit,zsize(1,1)]);
%figure(5),imshow(temp1);
%figure(6),imshow(temp2);

% left side    
sceneImage=temp1;
newBoxPolygon=matchPattern(sceneImage,boxImage);
Ybase=newBoxPolygon(1,2);
Yoffset=((newBoxPolygon(3,2)-newBoxPolygon(1,2))*2/3);
Xbase=newBoxPolygon(1,1);
Xoffset=(newBoxPolygon(2,1)-newBoxPolygon(1,1))/2;
Xoffset=Xoffset+((newBoxPolygon(2,1)-newBoxPolygon(1,1))/12);
CropStartX=Xbase+Xoffset;
CropStartY=Ybase+Yoffset;
NormalvalueHeight=newBoxPolygon(3,2)-newBoxPolygon(1,2);
HeightRatio=11.756;
NormalValueWidth=(newBoxPolygon(2,1)-newBoxPolygon(1,1));
WidthRatio=1.1;
WidthRatio=1/WidthRatio;
ActionPart1=imcrop(temp1,[CropStartX,CropStartY,NormalValueWidth*WidthRatio,NormalvalueHeight*HeightRatio]);
ResizedActionPart1=imresize(ActionPart1,[1500,245]);
%figure(1111),imshow(ActionPart1);
solution1 = findsolution(ResizedActionPart1);

%right side

sceneImage=temp2;
newBoxPolygon=matchPattern(sceneImage,boxImage);
Ybase=newBoxPolygon(1,2);
Yoffset=((newBoxPolygon(3,2)-newBoxPolygon(1,2))*2/3);
Xbase=newBoxPolygon(1,1);
Xoffset=(newBoxPolygon(2,1)-newBoxPolygon(1,1))/2;
Xoffset=Xoffset+((newBoxPolygon(2,1)-newBoxPolygon(1,1))/12);
CropStartX=Xbase+Xoffset;
CropStartY=Ybase+Yoffset;
NormalvalueHeight=newBoxPolygon(3,2)-newBoxPolygon(1,2);
HeightRatio=11.756;
NormalValueWidth=(newBoxPolygon(2,1)-newBoxPolygon(1,1));
WidthRatio=1.1;
WidthRatio=1/WidthRatio;
ActionPart2=imcrop(temp2,[CropStartX,CropStartY,NormalValueWidth*WidthRatio,NormalvalueHeight*HeightRatio]);
ResizedActionPart2=imresize(ActionPart2,[1500,245]);
figure(1111),imshow(ActionPart2);
solution2 = findsolution(ResizedActionPart2);
Line2='';
Line2=strcat(line2,count);
Line2=strcat(line2,',');
Line2=strcat(line2,name111);
Line2=strcat(line2,',');
Line2=strcat(line2,'1');
Line2=strcat(line2,',');
for i=1:25
    temp=strcat(solution1{i},',');
    Line2=strcat(Line2,temp);
    
end
for i=1:25
    temp=strcat(solution2{i},',');
    Line2=strcat(Line2,temp);
    
end
%Line1=strcat(Line1,Line2);

fprintf(fileId, '%s\n',Line2);



end
