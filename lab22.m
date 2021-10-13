%%aoiwm 2. laby INTERPOLACJA
clear;
close all;

x = 0:0.01*pi:pi*2;
xq = 0:pi/4:2*pi;
y=sin(1./x);

figure(1);
subplot(2,1,1);
plot(x,y);
title('sygnal sin(1/x))');

subplot(2,1,2);
v1=interp1(x,y,xq,'linear');
plot(x,y,'.g',xq,v1,':.r');
xlim([0 2*pi]);
title('interpolacja linearna');


figure(2);
subplot(2,1,1);
v1=interp1(x,y,xq,'cubic');
plot(x,y,'.g',xq,v1,':.r');
xlim([0 2*pi]);
title('interpolacja "cubic"');


subplot(2,1,2);
v1=interp1(x,y,xq,'spline');
plot(x,y,'.g',xq,v1,':.r');
xlim([0 2*pi]);
title('interpolacja "test"');
