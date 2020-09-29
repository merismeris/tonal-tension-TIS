function t=analyze_tree(seq)
stemp=seq;
k = find(seq=='s');
Tr=cell(numel(seq));
for i=1:numel(seq)
    Tr(i)={seq(i)};
end
if ~isempty(k)
    for i=1:numel(stemp)
        if i+1 == 'd'
            t2=tree('DR');
            t2=t2.addnode(1,'SR');
            t2=t2.addnode(1,'d');
            Tr(k(i))={t2};
            Tr(k(i+1))={0};
            stemp(i)=0;
            stemp(i+1)=0;
        elseif i+1=='s'
            t2=tree('SR');
            t2=t2.addnode(1,'SR');
            t2=t2.addnode(1,'SR');
            Tr(k(i))={t2};
            Tr(k(i+1))={0};
            stemp(i+1)=0;
    end
    t2.tostring()
end




end