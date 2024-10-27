%% picks random student from a class w/o replacement

clear all
pr = "Quanti studenti?\n";   % 25
N=input(pr);  
CLASSE=1:N;

pr = "Chi sono gli assenti?\n";
a=input(pr,"s");             % 9 11 23

ASSENTI=sscanf(a,"%d");
PRESENTI=setdiff(CLASSE,ASSENTI)

L=length(PRESENTI);
while ( L>0 )                   % press CTRL-C to exit
    pr = "NUOVO STUDENTE:";
    input(pr,"s");
    INDEX=randi(length(PRESENTI));
    fprintf("\t\t\t\t %d\n",PRESENTI(INDEX));
    PRESENTI(INDEX)=[]; L=L-1;   %% without replacement
    %bar(PRESENTI(INDEX)) %axis([0 2 0 N]) %grid on   
end



