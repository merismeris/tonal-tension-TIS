function [fitness,v1,v2,v3,v4]=TIS_prev(c1, c2,vkey)
    
%     c1=midi2chroma(m1);
%     c2=midi2chroma(m2);
    %Calculates the DFT of the chroma
    [t1,mod_c1]=normal_fft(c1);
    [t2,mod_c2]=normal_fft(c2);
    
    % Operations:
    % a) Measure quality of the chord
    v1=abs(chord_qual(t2));     
    v1=1-v1; %Average: 0.47
    % 
    max_d=0.94;
    % b) Compare two consecutive chords for the progression
%     v2=abs(compare_chords(t1,t2))/(max_d*2); %0.33-0.34
    v2=abs(compare_chords(t1,t2));
    % c) Compare distance between the chord and the key:
    [tkey,mod_key]=normal_fft(vkey(1,:));
%     v3=1-abs(key_dist(t2,tkey))/(max_d*2); %Average: 0.5
    v3=1-abs(key_dist(t2,tkey));
%     % d) Compare distance between the chord and the harmonic functions
    [tokey,mod_t]=normal_fft(vkey(2,:));
    [dokey,mod_d]=normal_fft(vkey(3,:));
    [sdkey,mod_s]=normal_fft(vkey(4,:));
    
    v4=abs(harmotion(t2,tkey,tokey,dokey,sdkey));
    v4=abs(v4)/pi; %Average: 0.48
%    radtodeg(v4);
%     
%fitness=(v2+v3+2*v4)/4;
%fitness=(6*v2+2.5*v3+3.5*v4)/12;
%fitness=v2;
%     %fitness=1.4*v1+v2;
%      fitness=v1*9.8+2*v2+v3*1.5+v4;
    % fitness=6*v1+1.8*v3+1*v4;
   
    fitness=(v1+3.5*v2+2.1*v3+1.5*v4)/6;
%     fitness=(0.1*v2+2.1*v3+1.5*v4)/4.8;
%    fitness = v1;
%     fitness=v4;
%    fitness=6*v1+2.1*v3;
%    fitness=6.5*v1+v3; % Esta sirve si queremos que aparezcan acordes
%    extraños a la tonalidad pero tríada y consonantes
% end