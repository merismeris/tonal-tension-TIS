function [chords,v]=select_candidates_TIS(t,chords,seq,skey),
% Vamos a calcular la distancia que hay entre dos acordes basándonos en la
% harmonic attraction lerdahl y voice_leading lerdahl. 
% Arbol construido = t
% acordes de la sucesión = chords
% Índice de los nodos hoja = seq

% Devolvemos un vector con las cuatro medidas:
% --> v1: voice leading (harmonic attraction)
% --> v2: distance
% --> v3: tonal surface
% --> v4: dissonance
v=zeros(size(chords,1),7);

%Normalization
max_d=0.94;
max_t=max_d*(numel(seq));

m1=chords(1,:);
c1=midi2chroma(m1);
t1=normal_fft(c1);
char=t.get(seq(1));
[v(1,2),v(1,5),v(1,6),v(1,7)]=TIS_dist(c1,c1,skey,char); %Distance between two chords
v(1,4)=(1-abs(chord_qual(t1))); %Dissonance measure

%Voice-leading to select the best inversion: The higher the better
%(maximization function)
for i=2:size(chords,1)
    m1=chords(i-1,:);
    m2=chords(i,:);
    c1=midi2chroma(m1);
    c2=midi2chroma(m2);
    t2=normal_fft(c2);
    
    [inversion,v(i,1)]=TIS_voices2(m1,m2,skey);
  %  fit=fit+fit_temp;
    chords(i,:)=inversion;
    
    %global harm_f;
    %Get the function harmony of each chord
    char=t.get(seq(i));
%     if strncmpi(char,'t',1),
%         harm_f=1;
%     else
%         if strncmpi(char,'s',1),
%             harm_f=2;
%         else
%             if strncmpi(char,'d',1),
%                 harm_f=3;
%             end
%         end
%     end
    
    %Harmonic attraction rule: h=c*voice_leading/d, where c=10
    %(minimization function)
    
    [v(i,2),v(i,5),v(i,6),v(i,7)]=TIS_dist(c1,c2,skey,char);
    v(i,4)=(1-abs(chord_qual(t2)));
      %Distance
%     h=v(i,2)+v(i,5)+v(i,6);
%     if h~=0
%     v(i,1)=v(i,1)/h;  
%     end
   % h=(fit_vleading*v(i,2));      %Harmonic attraction
    % chords(i,4)=1/h;
    % v(i,1)=150/h; 
    %v(i,2)=max_d/v(i,2);
    %v(i,1)=10/(max_vl*h);
    % v(i,4)=6*(1-abs(chord_qual(t2))); 
    
end

%To calculate tension surface: 
w_temp=TIS_global_surface(t,chords,seq,skey);%/max_t;
v(:,3)=w_temp(:,1);
% v(:,7)=w_temp(:,2);
% v(:,8)=w_temp(:,3);
%v(:,3)=v(:,4)+2.5*v(:,3);


% %NORMALIZATION
% %%%%v1%%%%VOICE LEADING
% max_vl=numel(chords(1,:))*2*max_d*exp(0.05*11);
% v(:,1)=v(:,1)/max_vl;
% 
% %%%%v2%%%%Distnace to the previous chord
% v(:,2)=v(:,2)/max_d;
% 
% %%%%v3%%%%Hier. Distnace to the previous chord
% v(:,3)=v(:,3)/max_d;
% 
% %%%%v4%%%%Dissonance 
% max_diss=0.94;
% v(:,4)=v(:,4)/max_diss;
% 
% %%%%v5 %%%%Distnace to the key
% max_angle=pi;
% v(:,5)=v(:,5)/max_angle;
% 
% %%%%v6%%%% Distnace to the tonal function
% v(:,6)=v(:,6)/max_angle;
% 
% %%%%v7%%%%Hier. Distnace to the key
% v(:,7)=v(:,7)/max_angle;
% 
% %%%%v8%%%%Hier. Distnace to the tonal function
% v(:,8)=v(:,8)/max_angle;
end