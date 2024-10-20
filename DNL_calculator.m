% calculates the DNL of a differential capacitor created using MxM unit MIM capacitor
% considering the oxide gradient and "Pelgrom" contribution

% more info here: doi= 10.1109/TCAD.2015.2511146

%% MIM properties 
Cu=9.936*10^-15; %% unit cap value [F]
to=27.6*10^-9;   %% mean thickness of capacitor [m]
GAMMA=50*10^-6;

%% capacitor topology
SPIRAL=[8*ones(1,16);         
        8*ones(1,16);
        8 8 7*ones(1,11) 8 8 8;
        8 8 7*ones(1,11) 8 8 8;
        8 8 7 7 6*ones(1,8) 7 8 8 8;
        8 8 7 7   6 5*ones(1,4) 6 6 6 7 8 8 8 ;
        8 8 8 7 6 5 4 4 4 4 6 6 7 8 8 8 ;
        8 8 8 7 6 5 4 2 1 4 5 6 7 8 8 8 ;
        8 8 8 7 6 5 4 0 2 4 5 6 7 8 8 8 ;
        8 8 8 7 6 5 3 3 3 3 5 6 7 8 8 8 ;
        8 8 8 7 6 6 5*ones(1,5) 6  7 7 8 8 ;
        8 8 8 7 6*ones(1,8) 7 7 8 8;
        8 8 8 7*ones(1,11) 8 8;
        8 8 8 7*ones(1,11) 8 8;
        8*ones(1,16);
        8*ones(1,16)];
M=16; N=8;
D=3.5*10^-6;    %% distance between unit cap

TH=0;
punti=50;  %% (2pi)/punti step 
MASSS=[];

for(j=0:punti) 
    TH=2*pi*j/punti;
    gradiente;
end

plot((0:punti)*2*pi/punti,MASSS,'LineWidth',1.5)
xlabel("Gradient angle [rad]"); ylabel("max(DNL) [-]");

%% Pelgrom (randomic) component
U=(.3/100*Cu/2)/2*100; % use datasheet value
p=1;                   % worst case value
d0=10^-6;              % distance between capitor edges
R=zeros(N+1,N+1);

%%covariance  
for K=0:N
       for L=K:N
            temp=0;
            [x1,y1]=find(SPIRAL==K);
            [x2,y2]=find(SPIRAL==L);
            for i=1:length(x1)
                for j=1:length(x2)
                   temp=temp+ p^DIST(x1(i),y1(i),x2(j),y2(j),D,d0);
                end
            end
            R(K+1,L+1)=temp*U^2;
            R(L+1,K+1)=temp*U^2;
       end
end

%variance (diagonal terms)
for K=0:N
    temp=0;
    [x,y]=find(SPIRAL==K);
    for i=1:length(x)
        for j=1:length(x)
           temp=temp+ p^DIST(x(i),y(i),x(j),y(j),D,d0);
        end
    end
    R(K+1,K+1)=temp*U^2;
end

MA=[];
Crand=mvnrnd(zeros(1,N+1),R,500);
for v=1:size(Crand,1)
    C=[1 1 2 4 8 16 32 64 128]*Cu+Crand(v,:);
    PESO=[];
    MAX=2^N-1;
    for i=0:MAX
        a = dec2bin(i,N);
        out = flip (str2num(a')');
        out=conversione(out);
        PESO=[PESO dot(C(2:end),out)];
    end
    
    PESO=PESO+C(1)*ones(size(PESO));
    % figure(1) % stem(0:255,PESO)
    DNL=diff(PESO)/(2*Cu)-1;
    % figure(2) % stem(DNL)
    MA=[MA max(DNL)];
end
max(MA)