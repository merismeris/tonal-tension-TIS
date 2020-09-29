function value=key_dist(chord,key),

%     xc=real(chord);
%     yc=imag(chord);
%     
%     xk=real(key);
%     yk=imag(key);
%     
%     xp = xc.*xk;
%     yp= yc.*yk;
%     p=0;
%     [M,N]=size(xp);
%     for i=1:N,
%         p=p+xc(i)*xk(i)+yc(i)*yk(i);
%     end
%     value=1/(1+real((dot(chord,key))/pi));
    value=acos(real(dot(chord,key))/(norm(chord)*(norm(key))));
%     value=acos(p/(norm(chord)*(norm(key))));
%    value=value/pi;
%     value=1/real(dot(chord,key));
%     value=p;
    % value=complex_dist(key,chord);  

end