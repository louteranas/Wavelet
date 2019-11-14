%_________________________________________
%  ondelette.m
%  PROGRAMME DE TRANSFORMEE EN ONDELETTES
%  Valerie Perrier - 
%
%  Ondelette de Morlet ou chapeau mexicain
%  Le signal a analyser doit s'appeler Y (puissance de 2 points)
%_________________________________________
%
clf
ii=sqrt(-1);
%
%..signal a analyser........
%
n=length(y)-1;
p=fix(log(n)/log(2));
dx=1/n;
t=0:dx:1;
x=-1:dx:1;
%
% calcul de l'ondelette
%
a0=1/2;
a0=a0^(1/2);
p=2*p;
W=zeros(p,n+1);
for i=p-1:-1:0
%	disp('scale')
	a=a0^i;
	xx=x/a; 
%	g=(1-2*xx.^2).*exp(-2*xx.^2)./sqrt(a);
%	plot(x,g),title('wavelet Mexican Hat')
	g=exp(-xx.^2/2).*exp(ii*5*xx)./sqrt(a);
%   plot(x,real(g)),title('Morlet Wavelet-real part')
%   disp('Press a key to continue')
%   pause
%
% calcul des coefficients d'ondelettes a l'echelle a
%
	wa=conv(y,g);
	W(i+1,1:n)=abs(wa(n+1:2*n))/sqrt(a);
end
%
% trace
%
%colormap(gray(60));
subplot(2,1,1),plot(t(1:n),y(1:n)),title('function to analyse')
subplot(2,1,2),imagesc(flipud(W(1:p,1:n))) , title('Wavelet coefficients')
%subplot(3,1,3),contour(W),title('lignes isocontour')
