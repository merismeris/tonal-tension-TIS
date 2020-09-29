function c=inverse_fft(T,mod_c)
    K=12;
    N=2;
    W=[0.049, 0.132, 0.203, 0.221, 0.246, 0.121,1,1,1,1,1,1];
   
    %Calculates inverse FFT (T)
    for k=1:(K/2),
        T(k)=mod_c*T(k)/W(k);
    end
    c=ifft(T);
end
