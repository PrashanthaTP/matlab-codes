%LPF using Impulse Invariance method | Bilinear Transformation
clc;

close all;
s2z = input('a :Bilinear Transformation  | b : Impulse Invariance Transformation \n');
As_que = input('Stop band attenuation in  As : ');
Ap_que = input('pass band attenuation in  Ap :');
ws = input('Stop band frequency: Ws :');
wp = input('passband frequency: Wp :');
fs = input('Sampling Frequency Fs: ');
que  = input('Are attenuations are in dB?');
disp(que);
if(isempty(que))
    str = 'N';
end

if que ==1
    disp('--------entered dB section---------------------');
    x = 10^(0.1*As_que);
    y = 10^(0.1*Ap_que);
    As = 10^(-As_que/20);
    Ap = 10^(-Ap_que/20);
    
else
    x = 1/(As_que)^2;
    y = 1/(Ap_que)^2;
    
end

N = ceil(   log10((x-1)/(y-1))/(2*log10(ws/wp))   );   
disp(['Order N = ' num2str(N)]);


wcp = wp/((y-1)^(1/(2*N)) ) ;
wcs = ws/((x-1)^(1/(2*N)) ) ; 
wc = (wcp+wcs)/2;
disp(['cutoff frequency :' num2str(wc)]);
thepoles = zeros(1,2*N);
% Get the poles
for k = 1 : 2*N
    thepoles(k) = exp(1j*pi*((2*(k-1)+N+1)/(2*N)));
    if (real(thepoles(k)) >= 0)
        thepoles(k) = 0;
    end
end
non_zero_poles = find(thepoles);
stable_poles  = thepoles(non_zero_poles);
disp(['Stable poles:' num2str(stable_poles)]);

den = real(poly(stable_poles));
disp(['Denominator coefficients:' num2str(den)]);
Hs = tf(1,den);
disp('Normalized filter Transfer Function:' );
disp(Hs);
[numt,dent] = lp2lp(1,den,wc);
disp('Frequency Transformed TF');
disp(['numt:' num2str(numt)]);
disp(['dent:' num2str(dent)]);
if(s2z == a)
    [b,a] = bilinear(numt,dent,fs);
else
     [b,a] = impinvar(numt,dent,fs);
end
freqz(b,a,512);
xlabel('Frequency (Hz)');
ylabel('Magnitude(dB)');
