clc; 
clear all;
close all;
ecg=load('ecg.dat');
f_s=200;
N=length(ecg);
L=N;
t=[0:N-1]/f_s; %time period(total sample/Fs )

w=100/(250/2);
bw=w;
[num,den]=iirnotch(w,bw); % notch filter implementation 
ecg_notch=filter(num,den,ecg);

N1=length(ecg_notch);
t1=[0:N1-1]/f_s;



figure(1);
subplot 211  % study useage of subplot under help section 

plot(t,ecg); 
title('Corrupted ECG signal with 60Hz Noise ')             
xlabel('time')
ylabel('amplitude')
legend(' ORIGINAL ECG SIGNAL')
subplot 212
plot(t1,ecg_notch,'r'); title('Filtered ECG signal ')             
xlabel('time')
ylabel('amplitude')
legend(' Flitered ECG SIGNAL')

figure(2)
z2=fft(ecg);
z3=abs(z2);
f=(0:L-1)*199/L;
plot(f,z3);
title("Magnitude Spectrum of the signal before filtering");
xlabel("Frequency");
ylabel("Magnitude");


figure(3)
z2=fft(ecg_notch);
z3=abs(z2);
f=(0:L-1)*199/L;
plot(f,z3);
title("Magnitude Spectrum of the signal after filtering");
xlabel("Frequency");
ylabel("Magnitude");
