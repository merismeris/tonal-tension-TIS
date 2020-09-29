function I=harmotion2(chord,key,tonic,dom,subd)
    vtonic=substract_vectors(key,tonic);
    vsub=substract_vectors(key,subd);
    vdom=substract_vectors(key,dom);
    
    vchord=substract_vectors(key,chord);
    modc=norm(vchord);
    xc=real(vchord);
    yc=imag(vchord);
    
 %   modc=norm(xc)+norm(yc)
            
%Calculate the value over the tonic
    xt=real(vtonic);
    yt=imag(vtonic);
    modt=norm(vtonic);
    xpt = xc.*xt;
    ypt= yc.*yt;
    pt=0;
    [M,N]=size(xpt);
    for i=1:N,
        pt=pt+xpt(i)+ypt(i);
    end
           
    temp=pt/(modt*modc);
    value=acos(temp);

            
    %Calculate the value over the Subdominant function
            
    xs=real(vsub);
    ys=imag(vsub);
    mods=norm(vsub);
    xps = xc.*xs;
    yps= yc.*ys;
    ps=0;
    [M,N]=size(xps);
    for i=1:N,
        ps=ps+xps(i)+yps(i);
    end
    temp=ps/(mods*modc);
    value=[value,acos(temp)];
           
     %Calculate the value over the Dominant function
    xd=real(vdom);
    yd=imag(vdom);
    modd=norm(vdom);
    xpd = xc.*xd;
    ypd= yc.*yd;
    pd=0;
    [M,N]=size(xpd);
    for i=1:N,
        pd=pd+xpd(i)+ypd(i);
    end
    temp=pd/(modd*modc);
    value=[value,acos(temp)];
            
    [M,I]=min(value);
    
end