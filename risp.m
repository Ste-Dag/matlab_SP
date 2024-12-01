% Given the transfer function H(s) = (n1*s +n0)/(d2*s^2 +d1*s +d0)
% use MATLAB  tf function     H = tf([n1 n0], [d2 d1 d0];   

H=tf([1],[1/(2*pi*100) 1]); % first order  
		       
%%%%%%%%STEP RESPONSE%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
ts=.5;  % time simulated
step(H,ts)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
t = 0:0.01:ts;
F0=10; IN = sin(2*pi*F0*t);  

lsim(H,IN,t)    % use lsim to simulate any input signal 
