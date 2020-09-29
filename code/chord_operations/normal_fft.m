function [T,mod_c]=normal_fft(chroma)
  %  K=12;  
     N=12;
 %    chroma=[chroma,0,0];
   % W=[0.0186519 0.041581 0.202943 0.220635 0.237581 0.120609];
   % W=[0.0486519 0.131581 0.202943 0.220635 0.245581 0.120609];
    W=[2, 11, 17, 16, 19, 7]; 
    T=zeros(N/2,1);
    %Calculates module of c ||c||
    temp=0;
    for i=1:N,
        temp=temp+chroma(i);
    end
    mod_c=temp;
    
    %Calculates normalized FFT (T)
%     for k=1:(K/2),
%         temp=0.0;
%         for n=1:N,
%             temp=temp+chroma(n)*exp(1i*-2*pi*k*n/N);
%             
%         end
%         
%         T(k)=temp*(W(k)/mod_c);
% 
%     end
% %    

    T=fft(chroma);
    T=T(2:7);
     for k=1:6,

           T(k)=(W(k)/mod_c)*T(k);
           %T(k)=(1/mod_c)*T(k);
     end
%       v=v';
%       v
  
end