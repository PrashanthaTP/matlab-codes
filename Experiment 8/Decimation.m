clc;
clear all;
close all;
fm = 10;
fs = 140;
t = 0:1/fs:0.2; % given no of samples is 80 hence common difference is 1/140 ie 0.007 hence 0.57 = 0+(80-1)0.007 ie AP formula to find nth term an = a1+(n-1)d
x = sin(2*pi*fm*t);
% decimation of input sequence
M = 2;
xd = decimate(x,M);
subplot(2,1,1);
stem(x);
xlabel('No. of samples');
ylabel('Amplitude');
title('input discrete sinusoidal sequence');
subplot(2,1,2);
stem(xd);
xlabel('No. of samples');
ylabel('Amplitude');
title('Decimated Sinusoidal Sequence');



