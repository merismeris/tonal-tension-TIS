function distance = complex_dist(n1,n2)
    r_n1=real(n1);
    i_n1=imag(n1);
    r_n2=real(n2);
    i_n2=imag(n2);
    
    [J,K]=size(n1);
    distance=0;
   for k=1:K,
 
       distance=distance+((r_n2(k)-r_n1(k))^2+(i_n2(k)-i_n1(k))^2);
   end
   
   distance = sqrt(distance);
   
end