clear; clc; close all;
%Script solves for the voltage matrix values given the impedances of a
%network - see problem 1 image
%Admittances of Circuit
Y0=1/(i);
Y1=1/(2*(cosd(60)+ i*sind(60)));
Y2=Y1;
Y3=1/(5*(cosd(40) + i*sind(40)));
%Admittance Matrix Values
Y11=Y0+Y1+Y3;
Y12=-Y3;
Y21=Y12;
Y22=Y2+Y3; 
Y=[Y11 Y12; Y21 Y22] %Admittance Matrix
I1=450*(cosd(-120)+i*sind(-120)); %Transformed V1 source to a current source
I2=20*(cosd(210)+i*sind(210)); %Current source 2
I=[I1; I2] %Current Matrix
Z=inv(Y); %Impedance Matrix
V=Z*I %Voltages
