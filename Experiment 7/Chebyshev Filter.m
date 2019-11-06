%Chebyshev Filter
clc;
% clear all;
close all;
choice = input('Enter your choice\n1:IIT \n2:BLT \n');

if(isempty(choice))
    choice = 1;
end

Ap_dB = input('Enter the value of Passband Attenuation in dB :');
As_dB = input('Enter the value of Stopband Attenuation in dB :');
ws1 = input('Stop band frequency :');
wp1 = input('Passband frequency :');
fs = input('sampling frequency :');

% As_dB = 20; Ap_dB = 1; ws1 =0.45*pi; wp1 = 0.15*pi; fs = 1;

x = 10^(0.1*As_dB);         % 1/As^2
y = 10^(0.1*Ap_dB);         %1/Ap^2

 
if choice ==1
    ws = ws1*fs;
    wp = wp1*fs;
elseif choice ==2
    ws = 2*fs*(tan(ws1/2));
 
    wp =2*fs*(tan(wp1/2));
else
    disp('Enter either 1 or 2 for S2Z transformation');
end

wp_N = 1;
ws_N = ws/wp;

disp([num2str(ws_N) ' ' num2str(wp_N)]);
ec = sqrt(y-1);
disp(['error coeffiicient :' num2str(ec)]);
N_num = (  ((-As_dB) -6+ (20*log10(ec)))  / (-6-(20*log10(ws_N)))  );


disp(['Order from equation N = ' num2str(ceil(N_num))]);
N_builtin = cheb1ord(wp,ws,Ap_dB,As_dB,'s');
disp(['Order from builtin function: ' num2str(N_builtin)]);

[b_num, a_num] =cheby1(N_builtin,Ap_dB,wp,'low','s');  %Corresponding to analog domain specs


if choice ==1
    [b,a] = impinvar(b_num,a_num,fs);
 

elseif choice ==2
     [b,a] = bilinear(b_num,a_num,fs);
 
else
    disp('Error');
end
disp(['Numerator of H(z):' num2str(b)]);
disp(['Denominator of H(z):' num2str(a)]);
disp('gain at Wp in dB:');
gain = sqrt(1/(1+ec^2));
disp(log(gain));

figure(1);
freqz(b,a,512);
title('Frequency Response of Chebyshev -I filter');
xlabel('Frequency (Hz)');
ylabel('magnitude (dB)');
