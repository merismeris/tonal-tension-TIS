function chroma_vector=midi2chroma (vector)
    chroma_vector = zeros(1,12);
    [fil,col]=size(vector);
    for i=1:col,
        index=mod(vector(i),12);
        chroma_vector((index+1))=chroma_vector((index+1))+1; 
    end
end