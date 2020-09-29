function midi_vector=chroma2midi (vector)
  %  midi_vector = zeros(1,12);
    Imax = find(vector >= 1);
    [fil,col]=size(Imax);
    midi_vector=[];
    for i=1:col,
        v_temp=59+Imax(i);
        midi_vector=[midi_vector;v_temp];
    end
    midi_vector=midi_vector';
end