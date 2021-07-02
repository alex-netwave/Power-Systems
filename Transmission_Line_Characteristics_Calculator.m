clc;clear;close all;
%This script calculates the ABCD paramters, the efficiency of the transmission line
%the source voltage, source current, and source real power(single-phase).
%See problem 2 for example

%Givens
z=0.35146*(cosd(84.78)+i*sind(84.78)); %Line's Series Impedance
y=i*4.2*10^-6; %Line's Shunt Admittance
l = 200; %length of Transmission Line in km
PFr=0.99; %Power factor on receiving end
Pr3=700*10^6; %3-Phase Power(in W) at the receiving end load
VLr=(327.8*10^3)*(cosd(30)+i*sind(30)); %Line Voltage on receiving end

%Calculations
Zc=sqrt(z/y); %Characteristic Impedance
g = sqrt(z*y); %Propagation constant in (km)^-1
gl=g*l;

%Transfer Characteristics - Calculations
A = cosh(gl); %unitless
D=A; %unitless
s=sinh(gl); 
B=Zc*s; %ohms
C=(Zc^-1)*s; %Siemens(i.e. mhos)

%Receiving end voltage and current
Vr=VLr/sqrt(3)*(cosd(-30)+i*sind(-30));
%Angle of the power factor on the receiving end, negative if power facor is lagging, positive if leading
power_factor=input("Leading or Lagging Power Factor?(lead or lag): ", 's');
if strcmp(power_factor, 'lead')
    aPFr=+acosd(PFr); %Angle for leading power factor
elseif strcmp(power_factor, 'lag')
    aPFr=-acosd(PFr); %Angle for lagging power factor
end
%aPFr = -acosd(PFr); %Angle of the power factor on the receiving end, negative if power facor is lagging, positive if leading
%aPFr = +acosd(PFr); 
Ir=(Pr3/3*(cosd(aPFr)+i*sind(aPFr)))/(PFr*abs(Vr));

%Matrix for sending end voltage and current
O=[A B; C D]*[Vr;Ir];
Vs=O(1);
Is=O(2);
aVs = angle(Vs)*180/pi; %Angle of the sending voltage, the 180/pi is to turn it to degrees
VLs=Vs*sqrt(3)*(cosd(30)+i*sind(30));

Ss=Vs*conj(Is); %complex single-phase power on sending end
Sr=Vr*conj(Ir); %complex single-phase power on receiving end
Ps=real(Ss); %real single-phase power on sending end
Pr=real(Sr); %real single-phase power on receiving end
PFs=cosd(atand(imag(Ss)/real(Ss))); %power factor on sending end
PFr=cosd(atand(imag(Sr)/real(Sr))); %power factor on receiving end
n=Pr/Ps; %Power efficiency = Pr/Ps
Ploss=Ps-Pr; %Power loss = Ps-Pr
Ploss3=3*Ploss; %3-Phase Power Loss at full load
Vrnl=Vs/A; %Receiving voltage at no load
mVrnl=abs(Vrnl);
mVrfl=abs(Vr); %Magnitude of receiving voltage at full load
Vreg=(mVrnl-mVrfl)/mVrfl * 100; %Percent voltage regulation

