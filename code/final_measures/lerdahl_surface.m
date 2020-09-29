function ls=lerdahl_surface(t_dist,mdom,m2,pnode,skey)
    m2=mod(m2,12);
    
    mdom=mod(mdom,12);
    
    % Equation of lerdahl Tension surface:
    % Tg=Tloc+Tinh
    % Tinh=sum(dxdom(xdom))
    % Tloc = d(xdom,y)+Tdiss
    
    tdiss=lerdahl_dissonance(m2,skey);
    m2=sort(m2);
    mdom=sort(mdom);
    [tloc1,tloc2,tloc3]=lerdahl_dist(mdom,m2,skey);%+tdiss;
    tloc=tloc1+tloc2+tloc3+tdiss;
    % To calculate Tinh we need the hierchical tree to know the distances
    % between the chords. We suppose the tree has the distances between all
    % the nodes. Then:
    p_i=t_dist.getparent(pnode);
    tinh=0;
    if p_i~=0
        tinh=t_dist.get(p_i);
    end
    while p_i~=0 %% Mientras no lleguemos al root
        tinh=tinh+t_dist.get(p_i);
        p_i=t_dist.getparent(p_i);
    end
    
    
    ls = tloc+tinh;
    
    
end