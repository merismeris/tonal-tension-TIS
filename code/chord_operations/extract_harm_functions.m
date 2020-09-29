function [vkey]=extract_harm_functions(key),
    if nargin==0,

        mkey = [62 64 66 67 69 71 73]; 
        key=midi2chroma(mkey);
    end
   global m_mode;

    if(m_mode==1)
    %Major tones:
        % 1) Duplicate octave of key vector:
        temp_key=[key,key];
        % 2) Find patron of major keys
        index = findsubmat(temp_key,[1 0 1 0 1 1 0 1 0 1 0 1]);
        index=index(1);
        if ~isempty(index)
            % 3) Extract function vectors
            major_chord_patron= [2 0 0 0 1 0 0 1];
            tonic= zeros(1,12);
            dominant=zeros(1,12);
            subdominant=zeros(1,12);
            tindex=index;
            sindex=index+5;
            dindex=index+7;

            for i=0:7,
                j=mod(tindex+i,12);
                if j==0,
                    j=12;
                end
                tonic(j)=major_chord_patron(i+1);
                j=mod(dindex+i,12);
                if j==0,
                    j=12;
                end
                dominant(j)=major_chord_patron(i+1);
                j=mod(sindex+i,12);
                if j==0,
                    j=12;
                end
                subdominant(j)=major_chord_patron(i+1);
            end
        end
      %Minor tones
      else
            % 1) Duplicate octave of key vector:
            temp_key=[key,key];
            % 2) Find patron of minor keys
            index = findsubmat(temp_key,[1 0 1 1 0 1 0 1 1 0 0 1]);
            % 3) Extract function vectors
            if ~isempty(index)
                minor_chord_patron= [2 0 0 1 0 0 0 1];
                major_chord_patron= [2 0 0 0 1 0 0 1];
                tonic= zeros(1,12);
                dominant=zeros(1,12);
                subdominant=zeros(1,12);
                tindex=index;
                sindex=index+5;
                dindex=index+7;

                for i=0:7,
                    j=mod(tindex+i,12);
                    if j==0,
                        j=12;
                    end
                    tonic(j)=minor_chord_patron(i+1);
                    j=mod(dindex+i,12);
                    if j==0,
                        j=12;
                    end
                    dominant(j)=major_chord_patron(i+1);
                    j=mod(sindex+i,12);
                    if j==0,
                        j=12;
                    end
                    subdominant(j)=minor_chord_patron(i+1);
                end
            end

      end
    %     tonic
    %     dominant
    %     subdominant
    vkey=[key;tonic;dominant;subdominant];
end