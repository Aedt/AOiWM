clearvars;
close all;

x = 0:pi*0.01:2*pi;
y=sin(1./x);
y2=sign(sin(8*pi*x));
% fin = sinc()
x2 = linspace(-0.5,0.5);

subplot(221);
plot(x,y);
xlim([0 2*pi])
ylim([-1.1 1.1]);
subplot(223);
plot(x,y2);
xlim([0 2*pi])
ylim([-1.1 1.1]);
subplot(222);
t = linspace(-1,1);
y3 = sinc(t);
plot(t,y3);
