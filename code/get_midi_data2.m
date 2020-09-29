function [chords]=get_midi_data2 (midi_matrix)
    [f,c]=size(midi_matrix);
    chords=[];
    input=zeros(2,3);
    input(1,:)=[midi_matrix(1,3),midi_matrix(2,3),midi_matrix(3,3)];
    input(2,:)=[midi_matrix(4,3),midi_matrix(5,3),midi_matrix(6,3)];
    for i=1:3:f,
        c_temp=[midi_matrix(i,3),midi_matrix(i+1,3),midi_matrix(i+2,3)];
        chords=[chords;c_temp];
    end
    
end