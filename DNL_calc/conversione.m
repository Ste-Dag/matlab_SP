function [in] = conversione(in)
    for i=1:length(in)
        if (in(i)==0)
            in(i)=-1;
        end
    end
end