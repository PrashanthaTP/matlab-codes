% DFT DIF FFT algorithm radix 2
clc;
xk_1 = input('Enter X(k): ');
ifft_xn = ifft(xk_1);
xn = conj(xk_1);

[xk] = FFT_DIF_R2(xn);

 N = length(x);

 
 xn_ans = (1/N)*(conj(xk));
disp('iDFT from direct computation :');
disp(ifft_xn)
disp('DFT from rad2 DIF FFT algorithm :' )
disp(xn_ans);


subplot(3,2,1);
stem(abs(xk_1));
title(['Entered sequence X(k) magnitude:' num2str(xk_1)]);
xlabel('k');
ylabel('Magnitude')

subplot(3,2,3);
stem(abs(ifft_xn));
title(['IDFT from direct computation :' num2str(ifft_xn)]);
xlabel('k');
ylabel('Magnitude')

subplot(3,2,4);
stem(abs(xn_ans));
title('IDFT from DIF ifft algorithm :');
xlabel('k');
ylabel('Magnitude')


subplot(3,2,6);
stem(angle(xn_ans));
title('phase plot for dft from direct computation ' );
xlabel('angle');
ylabel('Magnitude')

subplot(3,2,5);
stem(angle(ifft_xn));
title('Phase plot for dft from algorithm ' );
xlabel('k');
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

