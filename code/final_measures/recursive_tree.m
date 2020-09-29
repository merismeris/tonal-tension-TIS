function [t2,index]=recursive_tree(t,t2,n,index,chords),
n_children=t.getchildren(n);
if ~t.isleaf(n),   
    for i=n_children,
        [t2,index]=recursive_tree(t,t2,i,index,chords);
    end
end
if t.isleaf(n),
    t2=t2.set(n,num2str(index));
    index=index+1;
else % Estudiamos los casos de las reglas generativas que se pueden dar
    if t.get(n)=='SR',
        if size(n_children,2)==1, % Regla SR --> s
            t2=t2.set(n,num2str(t2.get(n_children(1))));
        else % Regla SR --> SR SR
            n_stable=study_stability(t2,n_children,n,chords);
            t2=t2.set(n,num2str(n_stable));
        end
    else
        if t.get(n)=='DR',
            if size(n_children,2)==1,   % Regla DR --> d
                t2=t2.set(n,num2str(t2.get(n_children(1))));
            else
                if t.get(n_children(1)) == 'SR', % Regla DR --> SR d
                    t2=t2.set(n,num2str(t2.get(n_children(2))));
                else  % Regla DR --> DR DR
                    n_stable=study_stability(t2,n_children,n,chords);
                    t2=t2.set(n,num2str(n_stable));
                end
            end
        else
            if t.get(n) == 'TR', 
                if size(n_children,2)==1, % Regla TR --> t
                    t2=t2.set(n,num2str(t2.get(n_children(1))));
                else
                    if t.get(n_children(1))=='TR', % Regla TR --> TR ??
                        if t.get(n_children(2))=='TR', % Regla TR --> TR TR
                            n_stable=study_stability(t2,n_children,n,chords);
                            t2=t2.set(n,num2str(n_stable));
                        else  % Regla TR --> TR DR
                            t2=t2.set(n,num2str(t2.get(n_children(1))));
                        end
                            
                    else  % Regla TR --> DR TR
                        t2=t2.set(n,num2str(t2.get(n_children(2))));
                    end
                        
                end
            end %END TR
        end % END DR
    end % END SR
end % END ISLEAF
           
    
    
end