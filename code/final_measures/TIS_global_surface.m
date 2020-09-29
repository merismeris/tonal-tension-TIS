function [new_fit]=select_global_TIS(t,chords,seq,skey),
% Vamos a calcular los predominant chords basados en el árbol que ya
% tenemos construido previamente:
% Arbol construido = t
% acordes de la sucesión = chords
% Índice de los nodos hoja = seq
% global harm_f;
skey=mod(skey,12);
index = 1;
n = 1;
t2=tree(t);

[t2,index]=recursive_tree(t,t2,n,index,chords);
%[fil,col]=size(seq);
new_fit=zeros(numel(seq),4);
% t2 es el árbol con los acordes sustituidos (índices)
index=1;

% Construyamos árbol para generar medidas de distancia entre y->xdom
t3=tree(t2);
iterator = t2.breadthfirstiterator;
for i=iterator
    ind1=str2num(t2.get(i)); %Índice de y
    temp=t2.getparent(i);
    if temp==0 %No tenemos un xdom con el que comparar distancias
        dtis1=0;
        dtis2=0;
        dtis3=0;
        dtis=0;
    else %Hay un xdom para compara distancias.
        ind2=str2num(t2.get(temp)); %Índice de xdom
        m1=chords(ind1,:);
        m2=chords(ind2,:);
        c1=midi2chroma(m1);
        c2=midi2chroma(m2);
        char=t.get(temp); %Saber en qué función armónica estamos
        if strncmpi(char,'t',1),
            harm_f='t';
        else
            if strncmpi(char,'s',1),
                harm_f='s';
            else
                if strncmpi(char,'d',1),
                    harm_f='d';
                end
            end
        end
        
        [dtis1,dtis2,dtis3,dtis]=TIS_dist(c1,c2,skey,harm_f); %Distancia
%         dtis=dtis1+dtis2+dtis3;
    end
     t3=t3.set(i,[dtis1,dtis2,dtis3,dtis]); % Guardar distancia en el árbol. comparamos y,xdom y 
%       t3=t3.set(i,[dtis1,dtis2,dtis3]);            % el valor resultante lo guardamos en el nodo hijo
end

for i=seq %Recorremos los nodos hoja en orden (secuencia de acordes)
    p_i=t2.getparent(i);
%     t2.get(p_i)
%     t2.get(i)
%     p_i
    while p_i ~=0 && strcmpi(t2.get(p_i),t2.get(i))  %Buscamos xdom
        p_i=t2.getparent(p_i);
    end
    if p_i==0 %No existe un xdom para este acorde. Su medida de tension surface, es la disonancia
        chord1=chords(str2num(t2.get(i)),:);
        c1=midi2chroma(chord1);
        [tt,~]=normal_fft(c1);
        tf=lower(t.get(i));
        new_fit(index,:)=TIS_dist(c1,c1,skey,tf(1));%1-abs(chord_qual(tt));     
    else
        chord1=chords(str2num(t2.get(p_i)),:); %Acorde padre
        chord2=chords(str2num(t2.get(i)),:);   %Acorde hijo
        char=chord2; %Saber en qué función armónica estamos
        tf=lower(t.get(p_i));
        new_fit(index,:)=TIS_surface(t3,chord1,chord2,p_i,skey,tf(1)); %Calculamos la tension surface
    end
    index=index+1;
end

end