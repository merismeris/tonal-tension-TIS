function tdiss=lerdahl_dissonance(m,skey)
 % Tdiss = inversion+diat+scale_degree, where:
    %   inversion = 2 if chord inverted, 0 otherwise
    %   diat = 3 if a note not belonging to triad-chord, 4 if a note not
    %   belonging to triad nor the scale, 0 otherwise
    %   scale_degree = 1 if 3rd or 5th is in the melodic voice, 0 otherwise
    % NOTE: Scale_degree is not applied in this equation
    inversion = 0; diat = 0; scale_degree=0;
    r2=calculus_fundamental(m);
    m=mod(m,12);
    if m(1) ~= r2
        inversion=2;
    end
    
    %Calculate degree: 
    if m(numel(m))~= r2
        scale_degree=1;
    end
    
    %Know if minor of major mode
    x=4;
    [v,I]=find(skey==(mod(r2+4,12)));
    if isempty(v)
        x=3;
    end
    
    %Calculate diat
    m=unique(m);
    diatm=[r2 mod(r2+x,12) mod(r2+7,12)];
    diatv1=intersect(diatm,m);
    if numel(diatv1)<numel(m)
        diat=3;
    end
    diatv2=intersect(skey,m);
    if numel(diatv2)<numel(m)
        diat=4;
    end
    
    tdiss=inversion+diat+scale_degree;
end