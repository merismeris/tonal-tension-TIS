function [inversion,max_dist]=lerdahl_voices(m1, m2, skey),
inversion=m2;

num_notes=size(m2,2);
r1=skey(1);
ca=[r1];
x=4;
[v,I]=find(skey==(mod(r1+4,12)));
if isempty(v),
    x=3;
end
cc=[r1 mod(r1+7,12) mod(r1+x,12)];
max_dist=0;
m11=mod(m1,12);

for i=1:num_notes,
    %Calculate voice-leading according to lerdahl:
    % s(v1,v2)=a(v2)/a(v1)*1/semitones^2;
    m21=mod(m2,12);
    dist_temp=0;
    for j=1:num_notes,
        
        semitones=abs(m1(j)-m2(j)); %Calculate number of semitones between the voices
        if semitones~=0,
            a=zeros(1,2);
            
            %Calculation of the ANCHORING:
            % 4 --> if the note is in the octave of the scale (tonic note)
            % 3 --> if the note is in the triad tonic chord
            % 2 --> if the note is in the diatonic scale
            % 1 --> if the note is in the chromatic scale
            a(1)=4;
            [v,I]=find(ca==m11(j));
            if numel(I)==0,
                a(1)=3;
                [v,I]=find(cc==m11(j));
                if numel(I)==0,
                    a(1)=2;
                    [v,I]=find(skey==m11(j));
                    if numel(I)==0,
                        a(1)=1;
                    end
                end
            end
            a(2)=4;
            [v,I]=find(ca==m21(j));
            if numel(I)==0,
                a(2)=3;
                [v,I]=find(cc==m21(j));
                if numel(I)==0,
                    a(2)=2;
                    [v,I]=find(skey==m21(j));
                    if numel(I)==0,
                        a(2)=1;
                    end
                end
            end
            dist_temp=dist_temp+(a(2)/a(1))*1/(semitones)^2;   
        end
    end
    
    if dist_temp>max_dist,
        max_dist=dist_temp;
        inversion=m2;
    end
    %Calculate next inversion for the next iteration
    m2(1)=m2(1)+12;
    m2=sort(m2);
    while (m2(1)-m1(1)) >= 7,
        m2=m2-12;
    end
    while (m2(1)-m1(1))<=-7,
        m2=m2+12;
    end
    
end

            
    
    
end %end function