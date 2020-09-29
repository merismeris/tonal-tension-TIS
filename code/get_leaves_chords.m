function[chords,leaves,i_chords]=get_leaves_chords(t)
chords=[];
leaves=[];
i_chords=[];
iterator = t.depthfirstiterator;
for i=iterator
   if t.isleaf(i)
       leaf=t.getparent(i);
       chord=t.get(i);
       leaves=[leaves leaf];
       chords=[chords; chord];  
       i_chords=[i_chords i];
   end
end
end