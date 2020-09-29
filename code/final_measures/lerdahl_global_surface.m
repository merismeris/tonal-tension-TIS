function [best_p]=lerdahl_global_surface(t,chords,seq,skey),
% Vamos a calcular los predominant chords basados en el árbol que ya
% tenemos construido previamente:
% Arbol construido = t
% acordes de la sucesión = chords
% Índice de los nodos hoja = seq
skey=mod(skey,12);
index = 1;
n = 1;
t2=tree(t);
[t2,index]=recursive_tree(t,t2,n,index,chords);
[fil,col]=size(seq);
new_fit=zeros(fil,col);
% t2 es el árbol con los acordes sustituidos (índices)
index=1;

% Construyamos árbol para generar medidas de distancia entre y->xdom
t3=tree(t2);
iterator = t2.breadthfirstiterator;
for i=iterator,
    ind1=str2num(t2.get(i));
    temp=t2.getparent(i);
    if temp==0,
        ld=0;
    else
        ind2=str2num(t2.get(temp));
        [ld1,ld2,ld3]=lerdahl_dist(chords(ind1,:),chords(ind2,:),skey);
        ld=ld1+ld2+ld3;
    end
    t3=t3.set(i,ld);
end

for i=seq
    p_i=t2.getparent(i);
    while p_i ~=0 && strcmpi(t2.get(p_i),t2.get(i))
        p_i=t2.getparent(p_i);
    end
    if p_i==0
        new_fit(index)=0;
    else
        chord1=chords(str2num(t2.get(p_i)),:);
        chord2=chords(str2num(t2.get(i)),:);
        new_fit(index)=lerdahl_surface(t3,chord1,chord2,p_i,skey);
    end
    index=index+1;
end
best_p=new_fit;
end