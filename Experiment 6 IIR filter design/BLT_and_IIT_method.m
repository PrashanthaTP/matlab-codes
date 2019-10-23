% LPF USING  IIR / BLT METHODS
clc;
close all;
clear all;
s2z = input('1 : Impulse invariance Transformation | 2: Bilinear Transformation\n');
if(isempty(s2z))
    str = 1;
end
As_que = input('Stop band attenuation :');
Ap_que = input('Passband band attenuation :');
ws = input('Stop band frequency :');
wp = input('Passband frequency :');
fs = input('sampling frequency :');
que = input('Are attenuations are in dB? If yes type 1 :');
if(isempty(que))
    str = 'q';
end
if que ==1
    x = 10^(0.1*As_que);
    y = 10^(0.1*Ap_que);
    As_dB = As_que;
    Ap_dB = Ap_que;
    As = 10^(-As_que/20);
    Ap = 10^(-Ap_que/20);
else
    x = 1/(As_que)^2;
    y = 1/Ap_que^2;
    As_dB = -20*log10( As_que);
    Ap_dB = -20*log10( Ap_que);
end
if s2z ==1
    ws = ws*fs;
    wp = wp*fs;
elseif s2z ==2
    ws = 2*fs*(tan(ws/2));
  
    wp =2*fs*(tan(wp/2));
else
    disp('Enter either a or b');
end
disp(ws);
disp(wp);

N = ceil(  (log10((x-1)/(y-1)))  /  (2*log10(ws/wp)) );
disp(['Order from equation N = ' num2str(N)]);
[order,omega_n] = buttord(wp,ws,Ap_dB,As_dB,'s') ;

disp(['Order from inbuilt function :' num2str(order)] );

wcp = wp/((y-1)^(1/(2*N)));
wcs = ws/((x-1)^(1/(2*N)));   
wc = (wcs+wcp)/2;
disp(['Cutoff frequency :' num2str(wc)]);
thepoles = zeros(1,2*N);
for k = 1:2*N
    thepoles(k) = exp((1j*pi*(2*(k-1)+N+1)/(2*N)));
    if (real(thepoles(k))>0)
        thepoles(k) = 0;
   
    end
end
non_zero_poles = find(thepoles);
stable_poles = thepoles(non_zero_poles);
disp(['Stable poles:' num2str(stable_poles)]);
den = real(poly(stable_poles));
disp(['Denominator coefficients of H(s) normalized :' num2str(den)]);

Hs = tf(1,den);
disp('Tranfer function of normalzed filter :' );
disp(Hs);

[numt ,dent] = lp2lp(1,den,wc);
[b_num, a_num] =butter(order,wc,'s');
disp(['Numerator of frequency transformed tf:' num2str(numt)]);
disp(['Denominator of frequency transformed tf:' num2str(dent)]);
if s2z ==1
    [b,a] = impinvar(numt,dent,fs);
    [b1,a1] = impinvar(b_num,a_num,fs);

elseif s2z ==2
     [b,a] = bilinear(numt,dent,fs);
     [b1,a1] = bilinear(b_num,a_num,fs);
else
    disp('Error');
end
disp(['Numerator of H(z):' num2str(b)]);
disp(['Denominator of H(z):' num2str(a)]);
figure(1);
freqz(b,a,512);
title('without using inbuilt function');
xlabel('Frequency (Hz)');
ylabel('magnitude (dB)');
figure(2);
freqz(b1,a1,512);
title('using inbuilt function');
xlabel('Frequency (Hz)');
ylabel('magnitude (dB)');
