function [inversion,min_dist]=TIS_voices2(m1,m2,ckey)

%Calculate chroma of scale
%ckey=midi2chroma(mkey);
%min_dist=1000;
inversion=m2;
%Calculate DFT of scale
[tkey,a]=normal_fft(ckey(1,:));
c1=midi2chroma(m1);
c2=midi2chroma(m2);
[t1,mod_c1]=normal_fft(c1);
[t2,mod_c2]=normal_fft(c2);
% for j=1:numel(m1),
    dist_temp=0;
    for i=1:numel(m1)
       cnote1=midi2chroma(m1(i));
       [tnote1,a]=normal_fft(cnote1);

       cnote2=midi2chroma(m2(i));
       [tnote2,a]=normal_fft(cnote2);
       %d2=complex_dist(tnote2,tkey);
  %     d2=key_dist(tnote2,tkey);
       nsemitones=abs(m1(i)-m2(i));
      
      [v1,v2,v3,distnotes]=TIS_dist(cnote1,cnote2,ckey,'t'); %complex_dist(tnote1,tnote2);
%        if nsemitones>7,
%            nsemitones=12-nsemitones;
%        end
       
       dist_temp=dist_temp+1/exp(0.05*nsemitones*distnotes);%complex_dist(c1,c2);
   
    end
    
%     if dist_temp<min_dist,
%         min_dist=dist_temp;
%         inversion=m2;
%     end
%     %Calculate next inversion for the next iteration
%     m2(1)=m2(1)+12;
%     m2=sort(m2);
%     while (m2(1)-m1(1)) >= 7,
%         m2=m2-12;
%     end
%     while (m2(1)-m1(1))<=-7,
%         m2=m2+12;
%     end
% end
min_dist=dist_temp;
end
