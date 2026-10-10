%[text] # OPT 212: 2d polynomial fitting class activity
%[text] This exercise is aimed at practicing 2d fitting using Zernike wavefront fitting as the example. 
clear
close all
clc
format compact
set(groot,'DefaultAxesFontSize',14,'DefaultTextFontSize',14, ...
    'DefaultLegendFontSize',11,'DefaultColorbarFontSize',14);
%[text] ## Exercise : Zernike Fitting on a Circular Pupil
%[text] A sampled pupil phase map can be fitted with a Zernike expansion. Use a square grid with `129` points in each direction, coordinates from `-1` to `+1`, and the circular pupil condition
%[text]{"align":"center"} $\\rho=\\sqrt{\\rho\_x^2+\\rho\_y^2}\\le 1.$
%[text] Use the following u Wyant-ordered basis:
%[text]{"align":"center"} $Z\_0=1,$ $Z\_1=\\rho\\cos\\theta=\\rho\_x,$ $Z\_2=\\rho\\sin\\theta=\\rho\_y,$ $Z\_3=2\\rho^2-1,$ $Z\_4=\\rho^2\\cos(2\\theta)=\\rho\_x^2-\\rho\_y^2,$ $Z\_5=\\rho^2\\sin(2\\theta)=2\\rho\_x\\rho\_y,$ $Z\_6=(3\\rho^3-2\\rho)\\cos\\theta=(3\\rho^2-2)\\rho\_x,$ $Z\_7=(3\\rho^3-2\\rho)\\sin\\theta=(3\\rho^2-2)\\rho\_y,$ $Z\_8=6\\rho^4-6\\rho^2+1,$ $Z\_9=\\rho^3\\cos(3\\theta)=\\rho\_x^3-3\\rho\_x\\rho\_y^2.$
%[text] 1\. Build the pupil grid and mask. 
%[text] 2\. Assemble a Zernike matrix with one row for each valid pupil sample and one column for each Zernike mode. 
%[text] 3\. Choose an example wavefront and find the Zernike coefficients that match the wavefront
%[text] $W\_{xy} = 4x + 5x^2 - y^2$
%[text] 4\. Invert the Zernike matrix to find the coefficients that match the wavefront.  
% Define a 2d meshgrid for x and y.  

x = linspace(-1,1,201);
y = linspace(-1,1,201);

[X,Y] =meshgrid(x,y);

% Turn x & y into column vectors
X = X(:);
Y = Y(:);

% choose only values of x&y within the unit circle 
ro2 = X.^2 + Y.^2;
lvr = ro2 <1;
x_col = X(lvr);
y_col = Y(lvr);
%figure
%plot(x_col,y_col,"o");
%axis equal

% Define an aberration function with coefficients of waves
W_xy = 4.*x_col + 5.*x_col.^2 -y_col.^2;

% Define the Zernike matrix
Zout = Zernike(x_col,y_col);

% Invert to find the coefficients.  
C = Zout./W_xy;
display (C); %[output:09141f4b]
%[text] 
%[text] 
%[text] 
%[text] 
%[text] 
%[text] 
%[text] 
% Defines the Zernike Polynomials for our calculations 
function Zout=Zernike(x,y)
ro2=x.^2+y.^2; 
ro2(ro2>1.00001)=nan;
ro=sqrt(ro2);
ro3=ro.^3;
ro4=ro.^4;
ro5=ro.^5;
ro6=ro.^6;
ro7=ro.^7;
ro8=ro.^8;
ro9=ro.^9; 
ro10 = ro.^10; 

theta=atan2(y,x);

theta=atan2(y,x);
Zer(:,1)=ro.*cos(theta);%x tilt
Zer(:,2)=ro.*sin(theta);
Zer(:,3)=-1+2.*ro2;
Zer(:,4)=ro2.*cos(2.*theta);
Zer(:,5)=ro2.*sin(2.*theta);
Zer(:,6)=ro.*(-2+3.*ro2).*cos(theta);
Zer(:,7)=ro.*(-2+3.*ro2).*sin(theta);
Zer(:,8)=1-6.*ro2+6.*ro4;
Zer(:,9)=ro3.*cos(3.*theta);
Zer(:,10)=ro3.*sin(3.*theta);
Zer(:,11)=ro2.*(-3+4.*ro2).*cos(2.*theta);
Zer(:,12)=ro2.*(-3+4.*ro2).*sin(2.*theta);
Zer(:,13)=ro.*(3-12.*ro2+10.*ro4).*cos(theta);
Zer(:,14)=ro.*(3-12.*ro2+10.*ro4).*sin(theta);
Zer(:,15)=-1+12.*ro2-30.*ro4+20.*ro6;
Zer(:,16)=ro4.*cos(4.*theta);
Zer(:,17)=ro4.*sin(4.*theta);
Zer(:,18)=ro3.*(-4+5.*ro2).*cos(3.*theta);

Zer(:,19) = (5 * ro5 - 4 * ro3) .* sin(3*theta);
Zer(:,20) = (15 * ro6 - 20 * ro4 + 6 * ro2) .* cos(2*theta);
Zer(:,21) = (15 * ro6 - 20 * ro4 + 6 * ro2) .* sin(2*theta);
% 
Zer(:,22) = (35 * ro7 - 60 * ro5 + 30 * ro3 - 4 * ro) .* cos(theta);
Zer(:,23) = (35 * ro7 - 60 * ro5 + 30 * ro3 - 4 * ro) .* sin(theta);
Zer(:,24) = (70 * ro.^8 - 140 * ro.^6 + 90 * ro.^4 - 20 * ro.^2 + 1);
Zer(:,25) = ro5 .* cos(5*theta);
Zer(:,26) = ro5 .* sin(5*theta);
Zer(:,27) = (6 * ro6 - 5 * ro4) .* cos(4*theta);
Zer(:,28) = (6 * ro6 - 5 * ro4) .* sin(4*theta);
Zer(:,29) = (21 * ro7 - 30 * ro5 + 10 * ro3) .* cos(3*theta);
Zer(:,30) = (21 * ro7 - 30 * ro5 + 10 * ro3) .* sin(3*theta);

Zer(:,31) = (56 * ro8 - 105 * ro6 + 60 * ro4 - 10 * ro2) .* cos(2*theta);
Zer(:,32) = (56 * ro8 - 105 * ro6 + 60 * ro4 - 10 * ro2) .* sin(2*theta);
Zer(:,33) = ro.*(5-60*ro2 + 210*ro4 - 280*ro6 + 126*ro8).* cos(theta);
Zer(:,34) = ro.*(5-60*ro2 + 210*ro4 - 280*ro6 + 126*ro8).* sin(theta);
Zer(:,35) = -1 + 30*ro2 - 210*ro4 + 560*ro6 -630*ro8 + 252*ro10;  
Zout = [ones(size(Zer(:,1))) Zer]; 
end
%[text] ## 

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"onright","rightPanelPercent":40}
%---
%[output:09141f4b]
%   data: {"dataType":"matrix","outputData":{"columns":1,"name":"Coeffs","rows":36,"type":"double","value":[["1"],["3.99999999999996"],["3.02987990371895e-17"],["1"],["3"],["4.07289409064695e-16"],["-1.94015259741958e-15"],["-2.24743407508698e-16"],["1.21398084225013e-15"],["-1.85840931869791e-15"],["-8.49677978047821e-16"],["2.0793595616261e-15"],["6.10248781487501e-16"],["-2.69882573720272e-15"],["-2.90513292109847e-16"]]}}
%---
