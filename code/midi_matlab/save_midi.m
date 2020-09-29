function save_midi(midi_chords,mat_ant,name),
    [T,cols]=size(mat_ant);
    [N,cols]= size(midi_chords);  % number of notes
    M = zeros(cols*(N+N*T),6);
  % initialize matrix:

    M(:,1) = 1;         % all in track 1
    M(:,2) = 1;         % all in channel 1
    M(:,4) = 80;  % lets have volume ramp up 80->120
    k=1;
    %mat_ant = [60 64 67];
    valor_anterior = -0.5;

    for i=1:N,
        %Introduce the previous progression (input progression)
        for l=1:T,
            for j=1:3,
                M(k,3) = (int64(mat_ant(l,j)))';      % note numbers
                M(k,5) = (valor_anterior+.5)';  % note on:  notes start every .5 seconds
                M(k,6) = M(k,5) + .5;   % note off: each note has duration .5 seconds
                k=k+1; 
            end
            valor_anterior = M((k-1),5);
        end

        %Introducimos nuestro acorde
        valor_anterior = M((k-1),5);
        for j=1:3,
            M(k,3) = (int64(midi_chords(i,j)))';      % note numbers
            M(k,5) = (valor_anterior+.5)';  % note on:  notes start every .5 seconds
            M(k,6) = M(k,5) + .5;   % note off: each note has duration .5 seconds
            k=k+1; 
        end
        %

        valor_anterior = M((k-1),5)+1;

    end
   
    midi_new = matrix2midi(M);
    file_title = strcat(name,'.mid');
    writemidi(midi_new, file_title);

end