%% OPT 212: Intro/Refresher Coding Exercises
% Student version
% 
% These exercises accompany the Intro/Refresher active script. They focus on 
% basic MATLAB variables, arrays, element-by-element arithmetic, logical indexing, 
% simple file input/output, plotting, structs, cells, and functions of two variables.
% 
% Complete the TODO blocks in each work area. The companion solution file is 
% opt212_01_intro_refresher_solutions.m.

clear
close all
clc
format compact
set(groot,'DefaultAxesFontSize',14,'DefaultTextFontSize',14, ...
    'DefaultLegendFontSize',14,'DefaultColorbarFontSize',14);
%% Exercise 1: Sampling a One-Dimensional Harmonic Field
% A simple scalar optical field can be modeled as
% 
% $$E(x)=A\cos(kx+\phi), \qquad k={2\pi \over \lambda}.$$
% 
% In this exercise you will sample the field on a one-dimensional grid and plot 
% several phase-shifted versions of the same wave.
% 
% Tasks:
% 
% 1. Use a wavelength of 633 nm, an amplitude of 1.2, and one phase angle. 
% 
% 2. Convert the wavelength to micrometers before computing $k=2\pi/\lambda$ 
% so it is compatible with `x_um`. 
% 
% 3. Create a column vector `x_um` covering four wavelengths. 4. Create a row 
% vector `phase_family` containing at least three phases. 5. Use element-by-element 
% operations and implicit expansion to create `E_family`, where each column is 
% one phase-shifted wave. 
% 
% 6 Plot the family of curves with labels and a legend.
% 
% Suggested variable names: `wavelength_nm`, `wavelength_um`, `amplitude`,`k`, 
% `x_um`, 'phases`, `E_values`.
%% Exercise 1 Work Area
% TODO: Fill in your code for Exercise 1 here.

% Define the variables 
wavelength_nm = 623;
amplitude =  1.2;
% Define the number of points to sample the waveform
points = 801;
% Convert wavelength in nm to wavelength in micrometers
wavelength_um = wavelength_nm/1000;
% Define k
  k = 2*pi/wavelength_um;
% Define x_um , phase_family and E_family

x_um = linspace(0,4*wavelength_um,201)';

phase_family = [0 pi/3 pi];

E_family = amplitude*cos(k*x_um + phase_family);


% Note:  make sure phase_family is a row vector and x_um is a column vector
    %command+t for uncomment a few lines


% Define a figure and plot
figure('Name','Solution 1: harmonic field')
plot(x_um,E_family,'LineWidth',1.3)
grid on
xlabel('x(\mu m)')
ylabel('E(x)')
title('Phase-shifted harmonic fields');
legend(compose('\\phi = %.2f rad',phase_family),'Location','eastoutside')
%% Exercise 2: Finding the full width at half maximum of a spectral peak 
% A detector scan can be represented by a measured irradiance as a function 
% of position; if the light is dispersed by a prism or grating, that distance 
% maps to a wavelength.   Here the signal is a Lorentzian where $I_0$ is the peak 
% intensity, $\lambda$ is the wavelength,  $\lambda_0$ is the central wavelength, 
% and $\Delta\lambda$ is the spectral width (full width at half maximum).  
% 
% $$I(\lambda)= \frac{I_0}{\left(1 + 4\frac{(\lambda-\lambda_0)^2}{\Delta\lambda^2}\right)}.$$
% 
% Tasks:
% 
% 1. Define the parameters:  Use a central wavelength of 1064 nm, a spectral 
% width of 10 nm, and a  
% 
% 2. Define an array of wavelengths centered around the central wavelength extending 
% over at least 10 spectral widths (5 on each side).   
% 
% 3. Calculate and plot the irradiance as a function of wavelength
% 
% 4. Use a logical variable to find the points closest to the half power point.  
% Hint:  The function $\left(I(\lambda) - \frac{I_0}{2}\right)^2$ will be at a 
% minimum at the half power point.  Add these points to the plot. 
% 
% 5.  The difference between these values is the full width at half maximum 
% 
% 
%% Exercise 2 Work Area
% TODO: Add your code for Exercise 2 here.


% Define constants (central wavelength, spectral width and peak intensity)

lambda0 = 1064;
delta_lambda = 10; 
I_0 = 1;
% Define an array for the wavelength 
wls = linspace(-5*delta_lambda ,5*delta_lambda ,1001 )+lambda0; 
% Calculate the irradiance
Irr = I_0 ./ (1 + 4*(wls-lambda0).^2./(delta_lambda.^2));
% Find the wavelengths closest to the half power point
ftest = (Irr - I_0/2).^2 ; 
[fmin,ll] = min(ftest);
w1 = wls(ll);
% Check and see if it found two minima or one
if length(w1)==2
    w1 = w1(1);
    w2 = w1(2);
else
    w2 = lambda0 - (w1 - lambda0);
end
    FWHM = abs(w1-w2);
% Display the full width at half maximum

display(['Full Width at Half Maximum:' num2str(FWHM) ' nm'])

figure('Name','Solution 2: Spectral Peak')
plot(wls,Irr,'LineWidth',1.3); hold on
plot(w1,Irr(ll),'ob')
plot(w2,Irr(ll),'ob')
grid on
xlabel('x(\mu m)')
ylabel('E(x)')
title(['Spectral peak: FWHM = ' num2str(FWHM,2) ' nm'] );

%% Exercise 3: A Two-Dimensional Beam
% A Gaussian beam envelope in the transverse plane can be approximated by
% 
% $$I(x,y)=I_0\exp\left[-2{x^2+y^2\over w_0^2}\right].$$
% 
% If the beam is slightly tilted, the real value of the field has the form
% 
% $$E(x,y)=\sqrt{I(x,y)}\cos(k_xx+k_yy).$$
% 
% where $k_x = k_0  sin(\theta_x)$ and $k_y = k_0 sin(\theta_y)$ and the angles 
% $\theta$ are small tilt angles; $k_0$ is called the vacuum wave vector and has 
% the value of $2\pi/\lambda$.  
% 
% Tasks:
% 
% 1. Create variables that store the wavelength `532 nm`, waist $w_0$ `1.1 mm`, 
% peak irradiance $I_0$ `1` in arbitrary units and small tilt angles 0.001 rad 
% and .0005 rad. 
% 
% 2. Use `linspace` and `meshgrid` to create coordinate arrays `x` and `y` that 
% extend to three times the beam waist.  x and y need to be in mm.   
% 
% 3. Compute variables  Ixy and Exy and display them in an image (using imagesc), 
% and a surface plot (using surf). 
%% Exercise 3 Work Area
% TODO: Add your code for Exercise 3 here.

% Define the beam parameters
I0 =  1; 
w0 = 1.1 ; 
% beam waist in mm
thetax = 0.001 ;
thetay = 0.005 ;
lambda_nm = 532 ;
lambda_mm = 532 * 10^-6; 
% convert wavelength to mm 
k0 = 2*pi/lambda_mm;
kx = k0 * sin(thetax);
ky = k0 * sin(thetay);
% define the sample points for the beam
xrange = linspace(-3*w0,3*w0,201);
[x,y]=meshgrid(xrange);
% calculate Ixy and Exy
Ixy = I0*exp(-2*(x.^2 +y.^2)/(w0.^2)) ;
Exy = sqrt(Ixy)*cos(kx*x + ky*y);


display results
figure('Name','Solution 3: Gaussian Beam')
subplot(2,2,1)
imagesc(xrange,xrange,Ixy)
subplot(2,2,2)
surf(x,y,Ixy); shading interp
subplot(2,2,3)
imagesc(xrange,xrange,Exy)
subplot(2,2,4)
surf(x,y,Exy); shading interp

subplot(2,2,4)
view([232.76 52.33])