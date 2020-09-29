function [chords,v]=lerdahl_select_candidates(t,chords,seq,skey),
% Vamos a calcular la distancia que hay entre dos acordes basándonos en la
% harmonic attraction lerdahl y voice_leading lerdahl. 
% Arbol construido = t
% acordes de la sucesión = chords
% Índice de los nodos hoja = seq

% Devolvemos un vector con las cuatro medidas:
% --> v1: voice leading (harmonic attraction)
% --> v2: distance to the key
% --> v3: tonal surface
% --> v4: dissonance 
% --> v5: 
% --> v6:
v=zeros(size(chords,1),6);
skey=mod(skey,12);

%Normalization
max_d=13;
max_vl=15.73;
max_c=7;
max_t=max_c+max_d+max_d*(numel(seq)-1);
%Voice-leading to select the best inversion: The higher the better
%(maximization function)
%[v(1,2),v(1,5),v(1,6)]=lerdahl_dist(chords(1,:),chords(1,:),skey)/max_d;
[v(1,2),v(1,5),v(1,6)]=lerdahl_dist(chords(1,:),chords(1,:),skey);
%v(1,4)=lerdahl_dissonance(chords(1,:),skey)/max_c;
v(1,4)=lerdahl_dissonance(chords(1,:),skey);

for i=2:size(chords,1)
    [inversion,v(i,1)]=lerdahl_voices2(chords(i-1,:),chords(i,:),skey);
  %  fit=fit+fit_temp;
    chords(i,:)=inversion;
    
    %Harmonic attraction rule: h=c*voice_leading/d, where c=10
    %(maximization function)
    %v(i,2)=lerdahl_dist(chords(i-1,:),chords(i,:),skey);
    [v(i,2),v(i,5),v(i,6)]=lerdahl_dist(chords(i-1,:),chords(i,:),skey);
    dist_final=(v(i,2)+v(i,5)+v(i,6));
    if dist_final==0
        %disp('minoentender')
        v(i,1)=0;
    else
        v(i,1)=v(i,1)/dist_final;
    end
    v(i,4)=lerdahl_dissonance(chords(i,:),skey);%/(max_c*2);
    %v(i,2)=v(i,2)/max_d;
end

v(:,3)=lerdahl_global_surface(t,chords,seq,skey);%/max_t;
% v(:,3)=v(:,3)+v(:,4);
end