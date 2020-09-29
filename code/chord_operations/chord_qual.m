function value= chord_qual(f_vector)

%   c_max=0.431;
%   c_max=0.429421;
   c_max=32.8631;
   distance = complex_dist(f_vector, [0 0 0 0 0 0]);
   value=distance/c_max;
end