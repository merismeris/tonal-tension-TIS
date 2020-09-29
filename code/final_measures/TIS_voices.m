function [inversion,min_dist]=TIS_voices(m1,m2,mkey)

%Calculate chroma of scale
ckey=midi2chroma(mkey);
min_dist=1000;
inversion=m2;
%Calculate DFT of scale
[tkey,a]=normal_fft(ckey);
for j=1:numel(m1),
    dist_temp=0;
    for i=1:numel(m1),
       cnote1=midi2chroma(m1(i));
       [tnote1,a]=normal_fft(cnote1);

       cnote2=midi2chroma(m2(i));
       [tnote2,a]=normal_fft(cnote2);
       d2=complex_dist(tnote2,tkey);

       nsemitones=abs(m1(i)-m2(i));
%        if nsemitones>7,
%            nsemitones=12-nsemitones;
%        end
       
       dist_temp=dist_temp+((d2))*exp(0.05*nsemitones);
   
    end
    
    if dist_temp<min_dist,
        min_dist=dist_temp;
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
end
