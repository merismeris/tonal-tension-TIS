function root_note = calculus_fundamental(m1)
 
  
    
        % Establish weights for the sub-harmonics obtained
    w1 = 10; %8th descendent
    w2 = 5; %5th descendent
    w3 = 3; %3M descendent
    w4 = 2; %7m descendent
    w5 = 1; %2M descendent
    
    W=[ w1, 0, w5, 0, w3, 0, 0, w2, 0, 0, w4, 0;
        0, w1, 0, w5, 0, w3, 0, 0, w2, 0, 0, w4;
        w4, 0, w1, 0, w5, 0, w3, 0, 0, w2, 0, 0;
        0, w4, 0, w1, 0, w5, 0, w3, 0, 0, w2, 0;
        0, 0, w4, 0, w1, 0, w5, 0, w3, 0, 0, w2;
        w2, 0, 0, w4, 0, w1, 0, w5, 0, w3, 0, 0;
        0, w2, 0, 0, w4, 0, w1, 0, w5, 0, w3, 0;
        0, 0, w2, 0, 0, w4, 0, w1, 0, w5, 0, w3;
        w3, 0, 0, w2, 0, 0, w4, 0, w1, 0, w5, 0;
        0, w3, 0, 0, w2, 0, 0, w4, 0, w1, 0, w5;
        w5, 0, w3, 0, 0, w2, 0, 0, w4, 0, w1, 0;
        0, w5, 0, w3, 0, 0, w2, 0, 0, w4, 0, w1;
        ];
    
    array_chord=midi2chroma(m1);
   
    %Multiply vectors
    array_value= zeros(1,12);
    for j=1:12
       array_value(1,j) = W(j,:)*array_chord';
    end
 
    [val index] = max(array_value);
    root_note=index(1)-1;

%     root_note = 0;
    
%     while (root_note == 0),
%         switch index, %convert in a value
%                 case 1
%                     root_note = 1;
%                 case 3
%                    root_note = 2;
%                 case 5
%                     root_note = 3;
%                 case 6
%                     root_note = 4;
%                 case 8
%                    root_note = 5;
%                 case 10
%                     root_note = 6;
%                 case 12
%                     root_note = 7;
%                 otherwise
%                     array_value(index) = 0;
%                     index = max(array_value);
%          end %end switch
%     end %end while

    
   
    
    
end