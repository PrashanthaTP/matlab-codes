
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

figure(1);
m = fir1(N,[2*fc1/fs 2*fc2/fs],'bandpass',hamming(N+1));
freqz(m);
title({['magnitude,' 'and', 'Phase plots'];['Hamming BPF', '( builtin Function)']})

figure(2);
m = fir1(N,[2*fc1/fs 2*fc2/fs],'bandpass',hann(N+1));
freqz(m);
title({['magnitude,' 'and', 'Phase plots'];['Hanning BPF', '( builtin Function)']})


figure(3);
m = fir1(N,[2*fc1/fs 2*fc2/fs],'stop',hamming(N+1));
freqz(m);
title({['magnitude,' 'and', 'Phase plots'];['hamming BEF', '( builtin Function)']})

figure(4);
m = fir1(N,[2*fc1/fs 2*fc2/fs],'stop',hann(N+1));
freqz(m);
title({['magnitude,' 'and', 'Phase plots'];['Hanning BEF', '( builtin Function)']})


figure(5);
m = fir1(N,[2*fc1/fs 2*fc2/fs],'bandpass',rectwin(N+1));
freqz(m);
title({['magnitude,' 'and', 'Phase plots'];['Rectangular window BPF', '( builtin Function)']})

figure(6);
m = fir1(N,[2*fc1/fs 2*fc2/fs],'stop',rectwin(N+1));
freqz(m);
title({['magnitude,' 'and', 'Phase plots'];['Rectangular window BEF', '( builtin Function)']})
