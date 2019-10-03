% Aytala IDFT using DIT ifft algorithm
clc;
clear all;
close all;
xk = input('Enter X(k) :');
x = conj(xk);
t = nextpow2(length(x));
j = [x zeros(1,(2^t)-length(x))];

N = length(j);
s = log2(N);
j = bitrevorder(j);

for stage=1:s
    a =1;
    b= 1+2^(stage-1);
    n=0;
    while(n<=2^(stage-1)-1&&a<=N&&b<=N)
            w=exp((-1j)*2*pi*n/(2^stage));
            y = j(a)+w*j(b);
            z = j(a)-w*j(b);
            j(a)= y;
            j(b)=z;
            a= a+1;
            b=b+1;
            n=n+1;
            if(rem(b,2^stage)==1)
                a=a+2^(stage-1);
                b= b+2^(stage-1);
                n=0;
            end
    end
end
j = (conj(j))/N;
disp(j);
disp(angle(j))
inbuilt_Idft = ifft(xk);

subplot(3,2,1);
stem(abs(x));
title(['Given X(k):' ' ' num2str(xk)]);
xlabel('K');
ylabel('Magnitude');

subplot(3,2,3);
stem(abs(inbuilt_Idft));
title(['IDFT from Direct computation:' ' ' num2str(inbuilt_Idft)]);
xlabel('N');
ylabel('Magnitude');


subplot(3,2,4);
stem(abs(j));
title(['IDFT from DIT fft algorithm:' ' ' num2str(abs(j))]);
xlabel('N');
ylabel('Magnitude');

subplot(3,2,5);
stem(angle(round(inbuilt_Idft)));
title('Phase plot for dft from direct computation');
xlabel('angle');
ylabel('Magnitude');

subplot(3,2,6);
stem(angle(round(j)));
title('Phase plot for dft from algorithm');
xlabel('angle');
ylabel('Magnitude');

                