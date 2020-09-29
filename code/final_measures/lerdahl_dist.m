function [i,j,k]=lerdahl_dist(m1,m2,skey)

r1=calculus_fundamental(m1);
r2=calculus_fundamental(m2);
m2=mod(m2,12);

% skey=[0 2 4 5 7 9 11];
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
j=abs(I1-I2);

% k -> number of non common notes resultant from the four levels a, b,
% c and d.

ca1=[r1];
cb1=[r1 mod(r1+7,12)];
x=4;
[v,I]=find(skey==(mod(r1+4,12)));
if isempty(v),
    x=3;
end
cc1=[r1 mod(r1+7,12) mod(r1+x,12)];

%Values for m2
%C in level a
[v,I]=find(m2==(mod(r2,12)));
if isempty(v),
    ca2=[];
else
    ca2=[r2];
end
%C in level b
[v,I]=find(m2==(mod(r2+7,12)));
if isempty(v),
    cb2=ca2;
else
    cb2=[r2 mod(r2+7,12)];
end

% x=4;
% [v,I]=find(skey==(mod(r2+4,12)));
% if isempty(v),
%     x=3;
% end
% [v,I]=find(m2==(mod(r2+x,12)));
% if isempty(v),
%     cc2=cb2;
% else
%     cc2=[r2 mod(r2+7,12) mod(r2+x,12)];
% end


a=intersect(ca1,ca2);
b=intersect(cb1,cb2);
c=intersect(cc1,m2);
d=intersect(skey,m2);

k=1-numel(a)+2-numel(b)+3-numel(c)+7-((7-numel(m2))+numel(d));


%ld=[i,j,k];
end