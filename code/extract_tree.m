function [t,seq]=create_tree(num_nodes),
t=tree('TR');
[t, n1]=t.addnode(1,'TR');
[t, n2]=t.addnode(1,'TR');

num_terminals=0;
terminal=0;

while num_terminals<num_nodes,
   num_terminals=0;
   iterator = t.depthfirstiterator;
   last_n=iterator(numel(iterator));
   n_first=0;
   node_leavesnt=[];
   num_leaves=0; 
   index=1;
   for i=iterator,
       if t.isleaf(i),
           if index==1,
               n_first=i;
               index=2;
           end
           num_leaves=num_leaves+1; 
           if strcmp(t.get(i),'t') || strcmp(t.get(i),'s') || strcmp(t.get(i),'d'),
               num_terminals=num_terminals+1;
           else
               node_leavesnt=[node_leavesnt i];
           end
       end
   end
   last_n=i;
   
   if num_terminals < num_nodes,
       if num_nodes==num_leaves,
           num_rules=0;
       else
           num_rules=(num_nodes/num_leaves);
           if num_rules > num_leaves,
               num_rules=num_leaves;
           end
       end
       applied_r=[];
       k=1;
      
       while k<=num_rules,
           if numel(node_leavesnt) ~=0,
               r=randi([1,numel(node_leavesnt)]);
               [v,I]=find(applied_r==node_leavesnt(r));
               if numel(v)==0,
                   applied_r=[applied_r, node_leavesnt(r)];
                   t=apply_rule(t,node_leavesnt(r),n_first,last_n,0);
                   k=k+1;
               end       
           end
       end

       %El resto de hojas tienen que aplicar las reglas de derivación de un
       %solo nodo. Sino, nos juntamos con demasiados nodos:
       node_leaves=setdiff(node_leavesnt,applied_r);
       for j=node_leaves,
           t=apply_rule(t,j,n_first,last_n,1);
       end
   end
   
    
end

% [t, n3]=t.addnode(n1,'TR');
% [t, n4]=t.addnode(n1,'DR');
% [t, n5]=t.addnode(n2,'TR');
% [t, n6]=t.addnode(n3,'t');
% [t, n7]=t.addnode(n4,'SR');
% [t, n8]=t.addnode(n4,'d');
% [t, n9]=t.addnode(n5,'t');
% [t, n10]=t.addnode(n7,'s');

%FUNCIONES ÚTILES:
%t.getparent(n10)
%t.getchildren(node) 
%t.isleaf(node) return true is this node is a leaf node.

%Para hallar los terminales y guardarlos: Recorrido en profundidad (ahora
%no nos hace falta, pero en un futuro sí)
%Habría que guardar el número de nodo hoja y el contenido, para futuro uso.
iterator = t.depthfirstiterator;
seq = [];
for i=iterator,
   if t.isleaf(i),
       seq=[seq,i];
   end
end
disp(t.tostring);

end

function t=apply_rule(t,node,first,last_n,terminal)


%Reglas de producción:
% TR --> DR t 
% TR --> TR TR
% TR --> TR DR
% TR --> t

% DR --> SR d
% DR --> DR DR
% DR --> d 

% SR --> SR SR
% SR --> s

if t.get(node) == 'DR',
    if terminal==1,
        r=1;
    else
        r = randi([2 3]);
    end
    switch r,
        case 1
            t=t.addnode(node,'d');
        case 2
            t=t.addnode(node,'DR');
            t=t.addnode(node,'DR');
        case 3
            t=t.addnode(node,'SR');
            t=t.addnode(node,'d');
    end
end
if t.get(node) == 'SR',
    if terminal==1,
        r=1;
    else
        r = 2;
    end
    switch r,
        case 1
            t=t.addnode(node,'s');
        case 2
            t=t.addnode(node,'SR');
            t=t.addnode(node,'SR');
    end
end
if t.get(node) == 'TR',
    
    if first==node, % FIRST POSITION: TR->t | TR->TR TR | TR -> TR DR
        if terminal==1,
            r=1;
        else
            r = randi([2 3]);
        end
        switch r,
            case 1
                t=t.addnode(node,'t');
            case 2
                t=t.addnode(node,'TR');
                t=t.addnode(node,'TR');
            case 3
                t=t.addnode(node,'TR');
                t=t.addnode(node,'DR');
        end
    else
        if last_n==node, % LAST POSITION: TR->t | TR->TR TR | TR -> DR TR
            if terminal==1,
                r=1;
            else
                r = randi([1 3]);
            end
            switch r,
                case 1
                    t=t.addnode(node,'t');
                case 2
                    t=t.addnode(node,'TR');
                    t=t.addnode(node,'TR');
                case 3
                    t=t.addnode(node,'DR');
                    t=t.addnode(node,'TR');
            end
        else %OTHER POSITIONS
            if terminal==1,
                r=1;
            else
                r = randi([2 4]);
            end
            switch r
                case 1
                    t=t.addnode(node,'t');
                case 2
                    t=t.addnode(node,'TR');
                    t=t.addnode(node,'TR');
                case 3
                    t=t.addnode(node,'DR');
                    t=t.addnode(node,'TR');
                case 4
                    t=t.addnode(node,'TR');
                    t=t.addnode(node,'DR');
            end
        end
    end
end



end

