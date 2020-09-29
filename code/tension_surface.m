function v=tension_surface(t,m1,m2)
    v=abs(m1(4)-m2(4));
    r1=calculus_fundamental(m1);
    r2=calculus_fundamental(m2);
    skey=[0 2 4 5 7 9 11];
    % Implementation of Lerdahl measures:
    
    %A) Distance: i+j+k
    % i ->  steps in the circle of fifths to stay in the same diatonic
    % collection (steps in the key to achieve the same alterations. In this
    % case i=0, because we are always in the same scale.
    i=0;
    
    % j -> mving the chord in the diatonic circle of fiths (moving the root
    % from one to another.
    circle_fifths=[5 0 7 2 9 4 11 6 1 8 3 10];
    [v,I1]=find(circle_fifths==r1);
    [v,I2]=find(circle_fifths==r2);
    j=abs(r2-r1);
    % k -> number of non common notes resultant from the four levels a, b,
    % c and d. In this case, d is always 0 because we have the same
    % diatonical scale.
    ca1=[r1];
    cb1=[r1 mod(r1+7,12)];
    cc1=[r1 mod(r1+7,12) mod(r1+x,12)];
    x=4;
    [v,I]=find(skey==(mod(r1+4,12)));
    if isempty(v),
        x=3;
    ca2=[r2];
    cb2=[r2 mod(r2+7,12)];
    x=4;
    [v,I]=find(skey==(mod(r2+4,12)));
    if isempty(v),
        x=3;
    cc2=[r2 mod(r2+7,12) mod(r2+x,12)];
    a=intersect(ca1,ca2);
    b=intersect(cb1,cb2);
    c=intersect(cc1,cc2);
    d=0;
    k=a+b+c+d;
    
    
    lerdahl_d=i+j+k;
    
    
end