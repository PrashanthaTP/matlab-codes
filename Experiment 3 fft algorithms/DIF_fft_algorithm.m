% DFT DIF FFT algorithm radix 2
clc;
close all;
clear all;
xn = input('Enter x(n): ');
xk1 = fft(xn);

[xk] = FFT_DIF_R2(xn);

 N = length(xn);
mul_dft  = N^2;
mul_dit_fft = (N/2)*log2(N);
disp(['DFT from direct computation :' ' ' num2str(xk1)]);
disp(['DFT from rad2 DIF FFT algorithm :' ' ' num2str(xk)]);

% disp('For  FFT DIF algorithm ');
% disp(['No of additions :' num2str( N*log2(N) )]);
% disp(['No of complex multiplications : '  ' ' num2str( (N/2)*log2(N) )]);
% disp(['Speed improvement factor is :' ' ' num2str(mul_dft/mul_dit_fft)]);

disp('                                   For  FFT DIF algorithm | For direct computation');
disp(['                 ' 'No of additions :' '  ' num2str( N*log2(N))  '                             '   num2str( N*(N-1))]);
disp(['   ' 'No of complex multiplications :' '  ' num2str( (N/2)*log2(N)) '                             '   num2str(mul_dft )]);
disp(['Speed improvement factor is :'  '    ' num2str(mul_dft/mul_dit_fft)]);


subplot(3,2,1);
stem(xn);
title(['Entered sequence x(n):' num2str(xn)]);
xlabel('N');
ylabel('Magnitude')

subplot(3,2,3);
stem(abs(xk1));
title(['DFT from direct computation :' num2str(xk1)]);
xlabel('k');
ylabel('Magnitude')

subplot(3,2,4);
stem(abs(xk));
title(['DFT from DIF fft algorithm :' num2str(xk)]);
xlabel('k');
ylabel('Magnitude')

subplot(3,2,5);
stem(angle(xk1));
title('phase plot for dft from direct computation ' );
xlabel('angle');
ylabel('Magnitude')

subplot(3,2,6);
stem(angle(xk));
title('Phase plot for dft from algorithm ' );
xlabel('angle');
ylabel('Magnitude')


function  [y]=FFT_DIF_R2(x)
         p = nextpow2(length(x));
         x = [x zeros(1,(2^p)-length(x))];
         N = length(x);
         s = log2(N);
         half = N/2;
         for stage = 1:s
             for index = 0: (N/2^(stage-1)) :N-1
                for n = 0: half-1
                    pos = n+index+1;
                    pow = 2^(stage-1)*n;
                    w= exp(-1j*(2*pi)*pow/N);
                    a = x(pos) + x(pos+half);
                    b = (x(pos) - x(pos+ half)).*w ;
                    x(pos)= a;
                    x(pos+half)=b;
                
                end
             end
                 half = half/2;
         end
     
         y = bitrevorder(x);
end

