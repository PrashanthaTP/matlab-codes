% ayatla DIF fft algo
clc;
clear all;
close all;
x = input('Enter x(n) :');
t = nextpow2(length(x));
j = [x zeros(1,(2^t)-length(x))];

N = length(j);
s = log2(N);


for stage=s:1:-1
    a =1;
    b= 1+2^(stage-1);
    n=0;
    while(n<=2^(stage-1)-1&&a<=N&&b<=N)
        l= (n).*(2^(s+1-stage))./2;
            w=exp((-lj)*2*pi*l/N);
            y = j(a)+j(b);
            z = j(a)-j(b).*w;
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
j= bitrevorder(j);

disp(j);
disp(angle(j));
inbuilt_dft = fft(x);
disp(inbuilt_dft)
disp(angle(inbuilt_dft))


subplot(3,2,1);
stem(abs(x));
title(['Given x(n):' ' ' num2str(x)]);
xlabel('N');
ylabel('Magnitude');

subplot(3,2,3);
stem(abs(inbuilt_dft));
title(['DFT from Direct computation:' ' ' num2str(inbuilt_dft)]);
xlabel('K');
ylabel('Magnitude');


subplot(3,2,4);
stem(abs(j));
title(['DFT from DIT fft algorithm:' ' ' num2str(j)]);
xlabel('K');
ylabel('Magnitude');

subplot(3,2,5);
stem(angle(inbuilt_dft));
title('Phase plot for dft from direct computation');
xlabel('angle');
ylabel('Magnitude');

subplot(3,2,6);
stem(angle(j));
title('Phase plot for dft from algorithm');
xlabel('angle');
ylabel('Magnitude');

              