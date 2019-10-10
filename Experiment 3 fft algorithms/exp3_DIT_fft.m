% ayatla DIT fft algo
clc;
clear all;
close all;
x = input('Enter x(n) :');
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

inbuilt_dft = fft(x);


mul_dft  = N^2;
mul_dit_fft = (N/2)*log2(N);

disp('                                   For  FFT DIT algorithm | For direct computation');
disp(['                 ' 'No of additions :' '  ' num2str( N*log2(N))  '                             '   num2str( N*(N-1))]);
disp(['   ' 'No of complex multiplications :' '  ' num2str( (N/2)*log2(N)) '                             '   num2str(mul_dft )]);
disp(['Speed improvement factor is :'  '    ' num2str(mul_dft/mul_dit_fft)]);

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

                
