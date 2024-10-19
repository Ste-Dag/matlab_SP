%%create parametric ramp w/ N points pwl file 

pr = "number of points?\n";
N=input(pr);   %N=100;

%% file name is "d.txt"
fileID = fopen('d.txt','w');
fprintf(fileID,"0 0 \n",i,i-1);
for i=1:N
    fprintf(fileID,"%d*T %d*s\n",i,i-1);
    fprintf(fileID,"%d*T+5n %d*s\n",i,i);
end

% 0      0 
% 1*T    0*s
% 1*T+5n 1*s
% 2*T    1*s