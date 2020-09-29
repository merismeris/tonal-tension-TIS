function [vs,vl] =main_analysis (c,t,mkey,mode)

[chords,leaves,seq]=get_leaves_chords(t);
% [t2,seq]=create_tree(numel(h1),t);
% while ~(isequal(seq,h1))
%     [t2,seq]=create_tree(numel(h1),t);
%     disp(seq);
% end
% t=t2;

%Global Matrix
global harm_f;
harm_f=1;

%Establish the key where we are working


%mkey = [60 62 63 65 67 68 71]; %cminor
%mkey = [60 62 64 66 67 69 71]; %GMajor
%mkey = [60 62 63 66 67 69 70]; %gminor
%A minor
global m_mode;
% Major Mode:
m_mode=mode;
% minor Mode:
%m_mode=0;
ckey=midi2chroma(mkey);
 % Call the function
vkey=extract_harm_functions(ckey);


tam_candidates=size(c,1);
n_candidates=zeros(size(c,1),6);
n_candidates_lerdahl=n_candidates;
vs=zeros(size(c,1),6);
vl=zeros(size(c,1),6);
% fit_old1=zeros(1,16);
% fit_old2=zeros(1,16);

%c1=midi2chroma(c(2,:));
% c2=midi2chroma(c(3,:));
 [n_candidates,vs]=TIS_select_candidates(t,c,seq,vkey);
 [n_candidates_lerdahl,vl]=lerdahl_select_candidates(t,c,seq,mkey);

 
  %fit_old(i)=music_eval2(c1,c2,vkey);
  
  %% CHORDAIS MEASURE
%   c1=midi2chroma(c(1,:));
%   c2=midi2chroma(c(1,:));
%   fitness=zeros(tam_candidates,1);
%   for i=1:tam_candidates
%       char=t.get(seq(i));
%         if strncmpi(char,'t',1)
%             harm_f=1;
%         else
%             if strncmpi(char,'s',1)
%                 harm_f=2;
%             else
%                 if strncmpi(char,'d',1)
%                     harm_f=3;
%                 end
%             end
%         end
%        % [fitness(i),vs(i,1),vs(i,2),vs(i,3),vs(i,4)]=TIS_prev(c1,c2,vkey);
%         c1=midi2chroma(c(i,:));
%         if i<tam_candidates
%             c2=midi2chroma(c((i+1),:));
%         end
% 
%   end
%  fitness
%% FINISH
% %Extract y
% yc=[4.2	4.155555556 3.488888889	3.466666667	3.933333333	3.288888889	3.733333333	2.622222222	3.288888889	1.266666667	2.466666667	3.066666667	1.355555556	2.133333333	2.088888889];
% yg=[4.266666667	4.2	3.777777778	3.622222222	3.222222222	3.111111111	3.133333333	2.911111111	1.933333333	2.422222222	2.933333333	1.822222222	1.8	1.355555556	1.444444444];
% ycm=[4.355555556	3.888888889	3.711111111	4.422222222	4.066666667	3.333333333	3.733333333	3.155555556	2.644444444	2.977777778	3.044444444	1.911111111	2.844444444	1.622222222	1.377777778];
% ygm=[4.488888889	3.866666667	4.044444444	4.444444444	4.066666667	4.244444444	3.977777778	3.088888889	3.044444444	2.733333333	1.733333333	2.022222222	2.911111111	2.733333333	1.311111111];
% 
% setv=[];
% for j1=1:3,
%     for j2=4:7,
%         for j3=8:15;
%             setv=[setv;j1 j2 j3];
%         end
%     end
% end
% 
% % setv=combnk(1:15,3);
% r2t=zeros(1,size(setv,1));
% r2l=r2t;
% pvaluet=r2t;
% pvaluel=r2t;
% % Validation: 2, 5, 8, 13
% for j=1:size(setv,1),
%     setd=setv(j,:);
%     ycv=yc(setd);
%     ygv=yg(setd);
%     ycmv=ycm(setd);
%     ygmv=ygm(setd);
% 
%     % Training: the rest
%     yct=yc;     yct(setd)=[];
%     ygt=yg;     ygt(setd)=[];
%     ycmt=ycm;   ycmt(setd)=[];
%     ygmt=ygm;   ygmt(setd)=[];
% 
%     % Validation: 2, 7, 13
%     v1v=vs(3,1,setd);
%     v2v=vs(3,2,setd);
%     v3v=vs(3,3,setd);
%     v4v=vs(3,4,setd);
% 
%     
%     %Training: Values of the set:
%     v1=vs(3,1,1:15);   v1(setd)=[];  %Voice Leading
%     v2=vs(3,2,1:15);   v2(setd)=[];  %Distance
%     v3=vs(3,3,1:15);   v3(setd)=[];  %Hierchical Tension
%     v4= vs(3,4,1:15);  v4(setd)=[];  %Consonance
% 
%     %[ws2,statst2]=calculate_regression2(yct,v1,(v3+v4));
%     %[ws3,statst3]=calculate_regression(yct,v1,v3,v4);
%     [ws,statst]=calculate_regression3(ygmt,v1,v2,v3,v4);
%     
%     %     vvc=ws2(1)*v1v+ws2(2)*(v3v+v4v);
% %     stvt2=corr2(squeeze(vvc),ycv');
% %     vvc=ws3(1)*v1v+ws3(2)*v3v+ws3(3)*v4v;
% %     stvt3=corr2(squeeze(vvc),ycv');
%     vvc=ws(1)*v1v+ws(2)*v2v+ws(3)*v3v+ws(4)*v4v;
%     %stvt=corr2(squeeze(vvc),ycv');
%     [R,P]=corrcoef(squeeze(vvc),ycv');
% %     
%     r2t(j)=R(1,2);
%     pvaluet(j)=P(1,2);
%     
%     %Training: Values of the set:
%     v1=vl(3,1,1:15);   v1(setd)=[];  %Voice Leading
%     v2=vl(3,2,1:15);   v2(setd)=[];  %Distance
%     v3=vl(3,3,1:15);   v3(setd)=[];  %Hierchical Tension
%     v4= vl(3,4,1:15);  v4(setd)=[];  %Consonance
%     
%     % Validation: 2, 7, 13
%     v1v=vl(3,1,setd);
%     v2v=vl(3,2,setd);
%     v3v=vl(3,3,setd);
%     v4v=vl(3,4,setd);
% 
%     
%     %[wl2,statsl2]=calculate_regression2(yct,v1,v3+v4);
%     [wl,statsl]=calculate_regression(yct,v1,v2,v3);
% 
% 
% %     vvc=wl2(1)*v1v+wl2(2)*(v3v+v4v);
% %     stvl2=corr2(squeeze(vvc),ycv');
%     vvc=wl(1)*v1v+wl(2)*v2v+wl(3)*v3v;
%     %stvl=corr2(squeeze(vvc),ycv');
%     [R,P]=corrcoef(squeeze(vvc),ycv');
%     
%     r2l(j)=R(1,2);
%     pvaluel(j)=P(1,2);
%     
% end
% 
% mean(r2t)
% std(r2t)
% mean(pvaluet)
% std(pvaluet)
% 
% mean(r2l)
% std(r2l)
% mean(pvaluel)
% std(pvaluel)
% 
% 
% % fit=zeros(tam_candidates,1);
% % fit2=zeros(tam_candidates,1);
% % 
% % for i=1:tam_candidates,
% %     vs(:,:,i)
% %     vl(:,:,i)
% %     fit(i)=sum(sum(vs(:,:,i)));
% %     fit2(i)=sum(sum(vl(:,:,i)));
% %     
% % end
% % [V,I]=sort(fit);
% % [V,I2]=sort(fit2);
% % 
% % for i=I,
% %     n_candidates(:,:,i)
% %         fit(i)
% % end
% % for i=I2,
% %     n_candidates_lerdahl(:,:,i)
% %     fit2(i)
% % end
% % 
% % % [M,N]=size(progresion);
% % % aux_chords=[];
% % % for i=1:M,
% % %     aux_chords=[aux_chords;chroma2midi(progresion(i,:))];
% % %    
% % % end
% % %     
% % % aux_chords
% % timestamp=datestr(clock, 0);
% % for i=1:10,
% %     index=memory(i,1);
% %     progresion=n_candidates(:,1:3,index)
% %     vs(:,:,index)
% %     save_midi2(progresion,strcat('ainet_c',num2str(index),'_',timestamp));
% %     chords=mat2json(n_candidates(:,:,index));
% %     f = fopen(strcat('chords_ainet_c',num2str(index),'_',timestamp,'.json'), 'w');
% %     fprintf (f, '%s', chords);
% %     fclose(f);
% % end
% % 
% % for i=1:10,
% %     index=memory2(i,1);
% %     progresion=n_candidates2(:,1:3,index)
% %     vl(:,:,index)
% %     save_midi2(progresion,strcat('ainet_l',num2str(index),'_',timestamp));
% %     chords=mat2json(n_candidates2(:,:,index));
% %     f = fopen(strcat('chords_ainet_l',num2str(index),'_',timestamp,'.json'), 'w');
% %     fprintf (f, '%s', chords);
% %     fclose(f);
% % end

end

