function save_midi2(aux_chords,name),
    [N,cols]= size(aux_chords);  % number of notes
    M = zeros(N*cols,6);
   
    M(:,1) = 1;         % all in track 1
    M(:,2) = 1;         % all in channel 1
    M(:,4) = 80;  % lets have volume ramp up 80
    k=1;
    %mat_ant = [60 64 67];
    valor_anterior = -1;

    for i=1:N,
        %Introducimos nuestro acorde
        
        for j=1:cols,
            M(k,3) = (int64(aux_chords(i,j)))';      % note numbers: MIDI numbers
            M(k,5) = (valor_anterior+1)';  % note on:  notes start every .5 seconds
            M(k,6) = M(k,5) + 1;   % note off: each note has duration .5 seconds
            k=k+1; 
        end
        %
        valor_anterior = M((k-1),5);

    end
    
    
    midi_new = matrix2midi(M);
    
    file_title = strcat(name,'.mid');
    writemidi(midi_new, file_title);

end