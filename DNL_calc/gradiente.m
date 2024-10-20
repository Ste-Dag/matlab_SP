%calculates the oxide gradient contribution
for i=1:M
    for j=1:M 
        x=(j-M/2.0)*D-D/2;
        y=(i-M/2.0)*D-D/2;
        G=x*cos(TH)+y*sin(TH);
        Ctot(i,j)=Cu*(to)/(to+G*GAMMA);
    end
end

C=[];
for i=0:N
   C=[C sum(sum( Ctot.*(SPIRAL==i)))];
end    

PESO=[];
MAX=2^N-1;
for i=0:MAX
    a = dec2bin(i,N);
    out = flip (str2num(a')');
    out=conversione(out);
    PESO=[PESO dot(C(2:end),out)];
end

PESO=PESO+C(1)*ones(size(PESO));
%figure(1) %stem(0:255,PESO)
DNL=diff(PESO)/(2*Cu)-1;
%figure(2) %stem(DNL)
MASSS=[MASSS max(DNL)];
