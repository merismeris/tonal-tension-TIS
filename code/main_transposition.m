m1=[60 64 67;60 65 69;59 62 67];
%Global Matrix
global harm_f;
harm_f=2;

%Establish the key where we are working

mkey = [60 62 64 65 67 69 71]; %CMajor
%mkey = [60 62 63 65 67 68 71]; %cminor
%mkey = [60 62 64 66 67 69 71]; %GMajor
%mkey = [60 62 63 66 67 69 70]; %gminor
%A minor
global m_mode;
% Major Mode:
m_mode=1;
% minor Mode:
%m_mode=0;
ckey=midi2chroma(mkey);

t=tree('TR');
[t,n1]=t.addnode(1,'TR');
[t,n2]=t.addnode(1,'DR');
[t, n3]=t.addnode(n1,'t');
[t, n4]=t.addnode(n2,'SR');
[t, n5]=t.addnode(n2,'d');
[t, n6]=t.addnode(n4,'s');
seq=[n3, n6, n5];

 % Call the function
c1=midi2chroma(m1(1,:));
c2=midi2chroma(m1(2,:));
vkey=extract_harm_functions(ckey);
[m,a]=lerdahl_select_candidates(t,m1,seq,mkey);
a


%mkey = [60 62 64 66 67 69 71]; %GMajor
mkey=mkey+7;
c1=midi2chroma(m1(1,:)+7);
c2=midi2chroma(m1(2,:)+7);
m2=m1(:,:)+7;
ckey=midi2chroma(mkey);
vkey=extract_harm_functions(ckey);
[m,a]=lerdahl_select_candidates(t,m2,seq,mkey);
a