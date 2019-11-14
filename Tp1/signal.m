%  signal
%  MATLAB - 
%  Val?rie Perrier -
%________________________________
%
%  G?n?ration de signaux. Le signal en sortie est not? Y
%  Calcul de sa transform?e de Fourier
%  Trac? de y(t) et de son spectre (module de sa TF)
%_______________________________
clear;clc;clf
%
% nombre de points de discretisation..............
%
n=input('Number of sample points:');
dx=1/n;
t=0:dx:1;
%
%..choix du signal (menu).................
%
disp('(1) Dirac')
disp('(2) Square function ')
disp('(3) White noise')
disp('(4) Sum of 2 sine functions')
disp('(5) Succession of 2 sinusoides')
disp('(6) Modulated Wave')
disp('(7) Sismique signal')
disp('(8) Audio signal')
m=input('Enter your choice:');
%index=(1:n);
if m==1
	n2=n/2;
	y=[zeros(1,n2-1) 1 zeros(1,n2)];
elseif m==2
	y=square(2*5*pi*t);
elseif m==3
	y=randn(1,length(t));
elseif m==4
	y=sin(2*pi*20*t)+sin(2*pi*85*t);
elseif m==5
	n2=n/2;
	y=[sin(2*pi*20*t(1:n2)) sin(2*pi*85*t(n2+1:n+1))];
elseif m==6
	y=cos(6*pi*t.*(10*t+0.5));
elseif m==7
	load quake
	g=0.0980;
	delt=1/200;
%	y=e*g;%(e est le signal dans quake)
	y=e;
%	t=delt*(1:length(e));
%	yrange=[-250,250];
%	ax=[0 50 yrange];
%	ech=n;
%   index=(1:10000/ech)*ech;
elseif m==8
	load splat
elseif m==9
    y=abs(cos(t*10));
end

m=input('Add noise ?  oui=0    non=1 :');
if m==0
	br=input('signal-to-noise ratio:');
	y=y+br*randn(size(y));
end
%
%..Trace du signal temporel............
%
%axis([0 1 -1.5 1.5])
subplot(5,1,1),plot(t(1:n),y(1:n)),title('time representation')
%
%..Calcul de la transformee de Fourier...
%
n2=n/2;
fy=fft(y,n)/n;
f=(0:n2);
fy=abs(fy);
%..trace............
subplot(5,1,2),plot(f(1:n2),fy(1:n2)),title('Frequency representation')
wave = RWT(y(1:128), 4, 'Morlet');
subplot(5,1,3),ImageRWT(wave, 'Overall', 'spring'),title('Wavelet')
subplot(5,1,4), contour(transpose(wave)),title('Wavelet')
maxima = WTMM(wave);
subplot(5,1,5),ImageWTMM(maxima),title('Maxima ')