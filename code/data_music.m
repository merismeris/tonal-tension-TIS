
%% Bach Chorale
%Bach: (Ach wie Fluchtig, ach wie nichtig): T D37 (D7) S3 D T  (parábola)
disp('e1-bach');
e1=[60 64 67 72; 59 62 67 74; 58 60 64 67; 57 60 65 69; 55 59 62 67;60 64 67 72];
save_midi2(e1,'e1-Bach');
t=tree('TR');
[t,n1]=t.addnode(1,'TR');
[t,n2]=t.addnode(1,'TR');
[t,n3]=t.addnode(n1,'TR');
[t,n4]=t.addnode(n1,'DR');
[t,n22]=t.addnode(n2,'t');
[t,n5]=t.addnode(n3,'TR');
[t,n6]=t.addnode(n3,'DR');
[t,n7]=t.addnode(n5,'t');
[t,n8]=t.addnode(n6,'d');

[t,n9]=t.addnode(n4,'DR');
[t,n10]=t.addnode(n4,'DR');
[t,n11]=t.addnode(n9,'d');
[t,n12]=t.addnode(n10,'SR');
[t,n13]=t.addnode(n10,'d');
[t,n14]=t.addnode(n12,'s');

%t.tostring;
mkey = [60 62 64 65 67 69 71]; %CMajor
mode=1;

[vs,vl]=main_analysis (e1,t,mkey,mode)


vTIS=vs';
vLerdahl=vl';


%xlswrite('vTIS.csv',[vTIS]);
%xlswrite('vLerdahl.csv',[vLerdahl]);
%xlswrite('part.csv',part);


