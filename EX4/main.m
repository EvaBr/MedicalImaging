mri = load('./Data/mri.mat');
params = load('./Data/params.mat');
dum = load('./Data/dummyData.mat');

% tryout = myKMeans(dum.D, 5, 10);
% input('c');
% 
% klustri = assignDatapoints(tryout, dum.D);
% figure();
% plot(dum.D(1,klustri==1),dum.D(2,klustri==1), 'go');
% hold on;
% plot(dum.D(1,klustri==2),dum.D(2,klustri==2), 'b*');
% hold on;
% plot(dum.D(1,klustri==3),dum.D(2,klustri==3), 'rx');
% hold on;
% plot(dum.D(1,klustri==4),dum.D(2,klustri==4), 'y*');
% hold on;
% plot(dum.D(1,klustri==5),dum.D(2,klustri==5), 'mo');
% hold off;
% input('c');

klus = input('input number of clusters for mri pic: ');
mozgani = SegmentImageKMeans(mri.mri, klus, params.params);
ss = segment(mozgani);
for i=1:klus
    imshow(double(mri.mri).*(ss==i)) % je bolje ce naredis mri(ss==1) = 255...?
    input('c');
end


% mri4(mo==3)=25;
% imshow(mri4)
% mri4(mo==3)=0;
% imshow(mri4)