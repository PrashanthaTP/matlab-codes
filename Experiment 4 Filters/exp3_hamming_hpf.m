%Hamming HPF
clc;
close all;
clear all;
f1 = input('Frequency f1:');
f2 = input('Frequency f2:');
fc = input('cutoff frequency fc :');
N = input('Order of the filter: ');
fsamp = 5* max(f1,f2);
wc = 2*pi*fc/fsamp;
T = (N-1)/2;
hd = zeros(1,N);
wd = zeros(1,N);
for k = 1:N
    if k==T
        hd(1,k) = wc/pi;
    else
        hd(1,k) = (sin(pi*(k-T))-(sin(wc*(k-T))))/(pi*(k-T));
    end
    
    wd(1,k) = 0.54 -0.46*cos(2*pi*k/(N-1));
    
end

        
h = hd.*wd;
disp(h);


t = 0:1/fsamp:1-1/fsamp;
signal = sin(2*pi*f1*t)+cos(2*pi*f2*t);

filtered_out = conv(signal,h);

figure(1);
subplot(4,1,1);
plot((1:200),signal(1:200));
title('Input signal');
xlabel('Time-->');
ylabel('Amplitude');
grid on;

subplot(4,1,2);
plot(abs(fft(signal)));
title('FFT of Input signal');
xlabel('Frequency-->');
ylabel('Amplitude');
grid on;

subplot(4,1,3);
plot((1:200),filtered_out(1:200));
title('Filtered signal (Hamming HPF)');
xlabel('Time-->');
ylabel('Amplitude');
grid on;

subplot(4,1,4);
plot(abs(fft(filtered_out)));
title('FFT of filtered signal');
xlabel('Frequency-->');
ylabel('Amplitude');
grid on;

figure(2);
freqz(h);
title({'Hamming HPF';'Magnitude and Phase plots';'Without Inbuilt Function'});

figure(3)
m= fir1(N,2*fc/fsamp,'high',hamming(N+1));
freqz(m);
title({'Hamming HPF';'Magnitude and Phase plots';'Inbuilt Function'});


fvtool(h);

