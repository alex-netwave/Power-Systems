clc; close all; clear;
%This script uses the results of the open ckt and short ckt
%tests to calculate winding resistances, leakage fluxes,
%core-losses, and magnetization current necessary
%to start flux

%im=imread('Test.png');
%image(im)

%Secondary in openckt
%Givens
Poc=35.35; %W
Ioc=50; %A
Voc=1200; %V
%Calculations
Am=-acosd(Poc/(Voc*Ioc));
Ym=(Ioc/Voc)*(cosd(Am)+i*sind(Am));
Rm=real(Ym)^-1
Xm=-1*imag(Ym)^-1 %-1j=1/j*j/j

%Secondary or Primary in shortckt
%Givens
Psc=300;
Isc=150;
Vsc=180;
%Calculations
Am=-acosd(Psc/(Vsc*Isc));
Z1=1/2*(Vsc/Isc)*(cosd(Am)+i*sind(Am));

%Primary in shortckt(In this case reflection is needed
%to find primary values)
%Reflecting Rm and Xm from secondary into primary
a=2; %Turns ratio
Rmp=(a^2)*Rm;
Xmp=(a^2)*Xm;
