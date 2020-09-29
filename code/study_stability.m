function content_n=study_stability(t2,n_children,n,chords),
[fil,col]=size(n_children);
s_chords=zeros(fil,col);
for i=1:col,
    s_chords(i)=1;
    a=str2num(t2.get(n_children(i)));
    chords(a,4);
end
[v,I]=min(s_chords);
content_n=t2.get(n_children(I(1)));

end