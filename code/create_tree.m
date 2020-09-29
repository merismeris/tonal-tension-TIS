function [t,seq]=create_tree(num_nodes,t)


num_terminals=0;
terminal=0;

while num_terminals<num_nodes
   num_terminals=0;
   iterator = t.depthfirstiterator;
   last_n=iterator(numel(iterator));
 %  n_first=0;
   node_leavesnt=[];
   num_leaves=0; 
   index=1;
   for i=iterator
       if t.isleaf(i)

%Calculo el número de nodos hoja que tengo, necesario para el bucle.
           num_leaves=num_leaves+1; 
           if strcmp(t.get(i),'t') || strcmp(t.get(i),'s') || strcmp(t.get(i),'d'),
               num_terminals=num_terminals+1;
           else
               node_leavesnt=[node_leavesnt i];
           end
       end
   end
   
   %Cálculo del último nodo (creo que no es necesario)
   %last_n=i;
   
   %Saber si tengo que aplicar alguna regla más para añadir nodos
   if num_terminals < num_nodes
       if num_nodes==num_leaves
           num_rules=0;
       else
           num_rules=(num_nodes/num_leaves);
           if num_rules > num_leaves
               num_rules=num_leaves;
           end
       end
       applied_r=[];
       k=1;
      
       %Aplico reglas si quiero para añadir nuevos nodos
       while k<=num_rules
           if numel(node_leavesnt) ~=0
               r=randi([1,numel(node_leavesnt)]);
               [v,I]=find(applied_r==node_leavesnt(r));
               if numel(v)==0
                   applied_r=[applied_r, node_leavesnt(r)];
                   t=apply_rule(t,node_leavesnt(r),0);
                   k=k+1;
               end       
           end
       end

       %El resto de hojas tienen que aplicar las reglas de derivación de un
       %solo nodo. Sino, nos juntamos con demasiados nodos:
       node_leaves=setdiff(node_leavesnt,applied_r);
       for j=node_leaves
           t=apply_rule(t,j,1);
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
for i=iterator
   if t.isleaf(i)
       seq=[seq,t.get(i)];
       % seq=[seq,i];
   end
end
%disp(t.tostring);

end

