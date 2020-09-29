function ls=TIS_surface(t_dist,mdom,m2,pnode,skey,tf)
    m2=mod(m2,12);
    m2=sort(m2);
    mdom=mod(mdom,12);
    mdom=sort(mdom);
    c2=midi2chroma(m2);
    cdom=midi2chroma(mdom);
    % Equation of lerdahl Tension surface:
    % Tg=Tloc+Tinh
    % Tinh=sum(dxdom(xdom))
    % Tloc = d(xdom,y)+Tdiss
    
    % Tdiss = TIS dissonance measure
    [t2,mod_c2]=normal_fft(c2);
    tdiss=abs(chord_qual(t2));     
    tdiss=(1-tdiss); 
    
    %Tloc=distance between xdom and y + dissonance
    [tloc1,tloc2,tloc3,tloc]=TIS_dist(cdom,c2,skey,tf);
    %tloc=tloc1+tloc2+tloc3+tdiss;
    
    % To calculate Tinh we need the hierchical tree to know the distances
    % between the chords. We suppose the tree has the distances between all
    % the nodes. The pnode is the node of the chord we want to measure. Then:
    p_i=t_dist.getparent(pnode);
    tinh=0;

    while p_i~=0 %% Mientras no lleguemos al root
        tinh=tinh+t_dist.get(p_i);
        p_i=t_dist.getparent(p_i);
    end
%     ls=tloc+tinh; 
    ls = [tloc1,tloc2,tloc3,tloc]+tinh;
    
    
end