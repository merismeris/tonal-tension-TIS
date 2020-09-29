filesList = dir('Audios/prueba*');
N=numel(filesList);
data=zeros(15,144);
media=zeros(12,12);
for i=1:N
    filesList(i).name
    
    fid = fopen(filesList(i).name,'r');
    str = textscan(fid,'%s','Delimiter','\r');
    fclose(fid);
%     str=readtable(filesList(i).name);
%  
    str=table2array(str(:,:));
    
%   str=extractAfter(str(:,1)," ");
    temp=[];
    f=0;
    c=1;
    for j=1:size(str,1)
        if startsWith(str(j,:),'A')
            str2=extractAfter(str(j,1)," ");
            c=1;
            f=f+1;
        else
            str2=str(j,1);
            c=c+1;
        end
        temp = split(char(str2{1,1}))';
        v=str2double(temp);
        media(f,c)=mean(v(~isnan(v)));
    end
 
    %media
  
%     [row, col] = find(isnan(media))
%     if row ~=0
%         disp('hola');
%     end
    m=media';
    m=m(:);
    m=m';
    data(i,:)=m;
    %Get repeated values
    
  
%     temp_uniq=str2double(temp(1));
%     for k=2:numel(temp)
%         v=str2double(temp(k));
%         repeated=str2double(temp(k-1));
%         if repeated==v && temp_uniq(numel(temp_uniq))~= v
%             temp_uniq=[temp_uniq,v];
%         end
%         if v==-1
%            temp_uniq=[temp_uniq,v]; 
%         end
%     end
%     
%     data{i}=temp_uniq;
end

% data=data';
% T = cell2table(data(1:end,:));
% writetable(T,'myDataFile.csv');
