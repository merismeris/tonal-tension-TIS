function [vi,fit_ind]=select_chord(c1,V_all)
[M,N]=size(V_all);
V=V_all(:,1:12);
fit=V_all(:,13);
flag=1;
m1=chroma2midi(c1);

%prob=[100*(fit(M,1))/(sum(fit))];
sum_all=sum(fit);
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

max_fit=max(fit);
min_fit=min(fit);
norm_value=1./value;
%norm_value=(value-min(value))/(max(value)-min(value));
% fit=(fit-min_fit)/(max_fit-min_fit);
fit=1./fit;
fit=1.5.*fit+0.4.*norm_value;

ctemp=sortrows([chords_proposed,fit],4);
fit=ctemp(:,4);
chords_proposed=ctemp(:,1:3);

fit_new=(1-fit);
sum_all=sum(fit_new);
prob=[];
for i=1:M,
  %  [fil,col]=size(prob);
    prob=[prob;(100*(fit_new(i,1)))/(sum_all)];  
    
end
[fil,col]=size(prob);
prob
j=M-1;
while j>=1,
  %  [fil,col]=size(prob);
    prob(j,1)=(prob(j+1,1)+prob(j,1)); 
    j=j-1;
    
end
%prob

% 
if numel(prob)==1,
    vi=chords_proposed(1,:);
    fit_ind=fit(1);
else
    while flag==1,
        flag=0;
        n_rand=100*rand;
        index=find(prob>n_rand,1,'last');
        temp=chords_proposed(index(1,1),:);
        fit_ind=fit(index);
        vi=temp;
    end
    %Search 2nd intervals!
%     for j=1:N,
%         if j<=10
%             if V(index,j)==1 && V(index,(j+1))==1,
%                 flag=1;
%                 break;
%             end
%         end
%         if j<=9,
%             if V(index,j)==1 && V(index,(j+2))==1,
%                 flag=1;
%                 break;
%             end
%         end
%     end %end for
    
end; %end while

    
end