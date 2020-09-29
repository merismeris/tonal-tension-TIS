function [chords_proposed,fit]=select_chord2(c1,V_all)
    [M,N]=size(V_all);
    V=V_all(:,1:12);
    fit=V_all(:,13);
    m1=chroma2midi(c1);
    value=zeros(M,1);
    chords_proposed=zeros(M,3);
    %Study voice-leading
    for i=1:M,
      m2=chroma2midi(V(i,:));
      [chords_proposed(i,:),value(i,1)]=study_voices(m1,m2); 
    end
    index0=find(value==0);
    for i=1:numel(index0)
        value(index0(i))=10;
    end

    norm_value=1./value;
    fit=1./fit;
    fit=1./(1.5.*fit+0.4.*norm_value);

    ctemp=sortrows([chords_proposed,fit],4);
    fit=ctemp(:,4);
    chords_proposed=ctemp(:,1:3);
    
end