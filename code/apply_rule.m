function t=apply_rule(t,node,terminal)


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
        r = randi([2 4]);
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
        case 4
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
if t.get(node) == 'TR'
    
  
            if terminal==1
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

