function chords=select_candidates5(t,chords,seq,skey),
% Vamos a calcular la distancia que hay entre dos acordes basándonos en la
% harmonic attraction lerdahl y voice_leading lerdahl. 
% Arbol construido = t
% acordes de la sucesión = chords
% Índice de los nodos hoja = seq

%Voice-leading to select the best inversion: The higher the better
%(maximization function)
chords(1,4)=0;
for i=2:size(chords,1),
    [inversion,fit_vleading]=lerdahl_voices(chords(i-1,1:3),chords(i,1:3),skey);
  %  fit=fit+fit_temp;
    chords(i,1:3)=inversion;
    
    %Harmonic attraction rule: h=c*voice_leading/d, where c=10
    %(maximization function)
    h=10*fit_vleading/lerdahl_dist(chords(i,1:3),chords(i-1,1:3),skey);
    chords(i,4)=1/h;
end

best_p=select_global_candidates(t,chords,seq,skey);
chords(:,4)=(chords(:,4)+0.05*best_p');


end