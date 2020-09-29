function [inversion,min_dist]=study_voices(m1, m2),

num_notes=size(m2,2);

chord_temp=m2;
min_dist=1000;
for i=1:num_notes,
    dist_temp=sum((m1-chord_temp).^2);
    if dist_temp == 0,
        dist_temp = 4;
    else
        dist_temp=log(dist_temp);
    end
    if dist_temp<min_dist,
        min_dist=dist_temp;
        inversion=chord_temp;
    end
    %Calculate next inversion for the next iteration
    chord_temp(1)=chord_temp(1)+12;
    chord_temp=sort(chord_temp);
    while (chord_temp(1)-m1(1)) >= 7,
        chord_temp=chord_temp-12;
    end
    while (chord_temp(1)-m1(1))<=-7,
        chord_temp=chord_temp+12;
    end
    
end

            
    
    
end %end function