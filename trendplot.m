%% simple elaboration of 'Microprocessor Trend Data' from Karl Rupp

%%%get data and convert to matrix
url="https://github.com/karlrupp/microprocessor-trend-data/raw/refs/heads/master/50yrs/frequency.dat"; f=urlread(url);
f= strrep(f,'####',''); f=str2num(f);  %% removed "####" to use str2num

url="https://github.com/karlrupp/microprocessor-trend-data/raw/refs/heads/master/50yrs/cores.dat"; c=urlread(url);
c= strrep(c,'####',''); c=str2num(c);  %% removed "####" to use str2num

url="https://github.com/karlrupp/microprocessor-trend-data/raw/refs/heads/master/50yrs/watts.dat"; w=urlread(url);
w= strrep(w,'####',''); w=str2num(w);  %% removed "####" to use str2num

url="https://github.com/karlrupp/microprocessor-trend-data/raw/refs/heads/master/50yrs/transistors.dat"; t=urlread(url);
t= strrep(t,'####',''); t=str2num(t);  %% removed "####" to use str2num

%%%%plot
figure(1)
subplot(2,2,1)
F=f(:,1)>1990;
x=(f(:,1)); x=x(F); y=(f(:,2)); y=y(F);
scatter(x,y/1000,35,"k","square")
hold on
[p,~,mu] = polyfit(x,y,8);
x1=min(x):(max(x)-min(x))/200:max(x);
y1 = polyval(p,x1,[],mu);
plot(x1,y1/1000,'r','linewidth',2);   
set(gca,'fontsize',12)
grid on
title('Frequency  [GHz]')
axis([1990 2021 0 inf])
%set(gca, 'YScale', 'log10')

subplot(2,2,2)
F=w(:,1)>1990;
x=w(:,1);x=x(F); y=w(:,2); y=y(F);
scatter(x,y,35,"k","square")
hold on
[p,~,mu] = polyfit(x,y,3);
x1=min(x):(max(x)-min(x))/20000:max(x);
y1 = polyval(p,x1,[],mu);
plot(x1,y1,'r','linewidth',2)
set(gca,'fontsize',12)
grid on
title('Dissipated power [W]')
axis([1990 2022 0 inf])

subplot(2,2,3)
F=c(:,1)>1990;
x=c(:,1);x=x(F); y=c(:,2); y=y(F);
scatter(x,y,35,"k","square")
hold on

F=c(:,1)>2006;
x=c(:,1);x=x(F); y=c(:,2); y=y(F);
[p,~,mu]= polyfit(x,y,3);
x1=min(x):(max(x)-min(x))/2000:max(x);
y1 = polyval(p,x1,[],mu);
plot(x1,y1,'r','linewidth',2)
set(gca,'fontsize',12)
grid on
title('#Cores')
axis([1990 2022 0 inf])

subplot(2,2,4)
F=t(:,1)>1990;
x=t(:,1);x=x(F); y=log10(t(:,2)*1000); y=y(F);
scatter(x,y,35,"k","square")
hold on
[p,~,mu] = polyfit(x,y,3);
x1=min(x):(max(x)-min(x))/20000:max(x);
y1 = polyval(p,x1,[],mu);
plot(x1,y1,'r','linewidth',2);
set(gca,'fontsize',12)
grid on
title('log10 #Transistor')
axis([1990 2022 min(y) max(y)])