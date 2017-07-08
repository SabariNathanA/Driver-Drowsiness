%% -------------------------------------------------------------------- %%

clc;
clear all;
close all;
run_function;
warning off;

frames =50; 
vid=videoinput('winvideo',1,getResolution()); 
triggerconfig(vid,'manual'); 
set(vid,'ReturnedColorSpace','rgb' ); 

start(vid);                               

 
 for jjj=1:frames     
     
    snapshot = getsnapshot(vid);
    x=snapshot;
    frame=rgb2gray(snapshot);
    scale=1;
    Img = double (frame);
    Face = FaceDetect('haarcascade_frontalface_alt2.xml',Img);

if Face~=-1   
    f = figure(1);    
    subplot(2,3,2),imshow(x),title('Input Image: Face Detected')
    out=zeros(5,4);
    pos = find( Face(:,3)==max(Face(:,3)));
    pos=pos(1);
    out(1,:)=(Face(pos,:)*scale);
    ret=out(1,:);                                                                                                                                                                                                          
    siz=out(1,3);     
    hold on
    rectangle('Position',[ret(1,1),ret(1,2),ret(1,3),ret(1,4)],'EdgeColor','r','LineWidth',2)
    
    left=0.2;
    right=0.58;
    oben=.35;
    unten=0.5;
    out(3,:)=[out(1,1)+siz*left,out(1,2)+siz*oben,siz*(1-right-left),siz*(1-oben-unten)];
    ret2=out(3,:);
    RECT2=[ret2(1,1),ret2(1,2),ret2(1,3),ret2(1,4)];  
    snapshot=imcrop(x,RECT2); 
    
    left=0.58;
    right=0.2;
    oben=0.35;
    unten=0.5;
    out(4,:)=[out(1,1)+siz*left,out(1,2)+siz*oben,siz*(1-right-left),siz*(1-oben-unten)];
    ret3=out(4,:);     
    RECT4=[ret3(1,1),ret3(1,2),ret3(1,3),ret3(1,4)];
    snapshot1=imcrop(x,RECT4); 
    subplot(2,3,6),imshow(snapshot),title('Right Eye')
    [r c rad] = circlefinder(snapshot, [], [], [], [], snapshot);
    peaks=[c,r,rad];
    if ~isempty(peaks)
    hold on;
for peak = peaks(:)
    if peaks(3)<15
    [xx, y] = circlepoints(peak(3));    
    plot(xx+peak(1), y+peak(2), 'g-');
    end
end
    end
    
    subplot(2,3,4),imshow(snapshot1),title('Left Eye')
    [r1 c1 rad1] = circlefinder(snapshot1, [], [], [], [], snapshot1);
    peaks1=[c1,r1,rad1];
    if ~isempty(peaks1)
    hold on;
for peak1 = peaks1(:)
    if peaks1(3)<15
    [xx1, y1] = circlepoints(peak1(3));    
    plot(xx1+peak1(1), y1+peak1(2), 'g-');
    end
end
    end
else
close all;    
disp('Face Not Detected')
end
hold off
 end
stop(vid)