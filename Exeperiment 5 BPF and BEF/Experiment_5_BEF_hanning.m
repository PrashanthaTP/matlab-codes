% BEF hanning
clc; 
close all;
clear all;

f1 = input('frequency f1 :');
f2 = input('frequency f1 :');
fc1 = input('Lower Cutoff frequency fc1 :');
fc2 = input('Upper Cutoff frequency fc2 :');
N = input('Order of the Filter :');
fs = 5* max(f1,f2);
wc1 = 2* pi* fc1 / fs;
wc2 = 2* pi* fc2 / fs;
T = (N-1)/2;
hd = zeros(1,N);
wd = zeros(1,N);
for k =1:N
    wd(k) = 0.5 - 0.5* cos(2*pi*k/(N-1));
    if k==T
        hd(k)=1-(wc2-wc1)/pi;
    else
        hd(k)= ( sin(wc1*(k-T)) - sin(wc2*(k-T) ) )/ (pi*(k-T)) ;
    end
end


h = hd.*wd;
disp(['Filter Coefficients h' num2str(h)]);

t = 0:1/fs: 1 -1/fs;
x = sin(2*pi*f1*t)+cos(2*pi*f2*t);
xk = abs(fft(x));

filter_out = conv(x,h);
filter_out_k = abs(fft(filter_out));


figure(1);
subplot(4,1,1);
plot((1:200),x(1:200));
title('Input Signal');
xlabel('Time');
ylabel('Amplitude');
grid on;

subplot(4,1,2);
plot(xk);
title('fft of Input Signal');
xlabel('frequency');
ylabel('Amplitude');
grid on;

subplot(4,1,3);
plot((1:200),filter_out(1:200));
title('Filtered Signal (Hanning BEF)');
xlabel('Time');
ylabel('Amplitude');
grid on;

subplot(4,1,4);
plot(filter_out_k);
title('fft of filtered Signal');
xlabel('Frequency');
ylabel('Amplitude');
grid on;

figure(2);
freqz(h);
title({['magnitude,' 'and', 'Phase plots'];['hanning BEF', '(Without builtin Function)']})

figure(3);
m = fir1(N-1,[2*fc1/fs 2*fc2/fs],'stop',hann(N));
freqz(m);
title({['magnitude,' 'and', 'Phase plots'];['Hanning BEF', '( builtin Function)']})

