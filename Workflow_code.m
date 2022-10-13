clear all, close all, clc
% This code provides the workflow on generating simulated sensor signals to investigate damage detection in a wind turbine gear box.
% The code has been implemented following along the work and results proposed in

%[1] Kahraman, A. and Singh, R. (1991). Interactions between time-varying mesh stiffness and clearance
% non-linearities in a geared system. Journal of Sound and Vibration, 146(1):135–156.

%[2] Antoniadou, I., Manson, G., Staszewski, W., Barszcz, T., and Worden, K. (2015). A time–frequency
% analysis approach for condition monitoring of a wind turbine gearbox under varying load conditions. Mechanical Systems and Signal Processing, 64-65:188–216.

%% parameters
I = 0.00115; % mass moment of inertia (kg m^2)
mc = 0.23;  % (kg)
r = 0.05;  % base radius (m)
number_teeth = 16 ;
km=3.8*(10.^8); %(N/m)
bg=0.1*(10.^(-3)); % Gear backlash (m)
b=1; %Gear backlash (dimensionless)
z = 0.05; %dimensionless dumping coefficient
omega = 0.5; %mesh frequency 
wn = sqrt(km/mc);
%coefficients input force related to internal vibration 
Fm = 0.1;
Fte1 = 0.01;
Fte2 = 0.004;
Fte3 = 0.002;
%mesh stiffenss function coefficients
k1 = 0.2; 
k2 = 0.1;
k3 = 0.05;

%% Time setting

time_per_rotation= number_teeth/omega*2*pi; %dimensionless time per full rotation of one gear
n=5; %number of rotations considered
range= time_per_rotation*n; %dimensionless time range (we consider n rotations)
dt_sim =  0.015005; % dimensionless time step
tspan = [dt_sim:dt_sim:range]; 


%% Set high speed shaft torque
                  
Tbf = zeros(1,40201); %High speed shaft torque 
% Here we set the high speed shaft torque to zero.  
% Notice that, the vector 'Tbf' can be replaced with simulated High speed 
% shaft torque measurements from the FAST code or sensor measurements 
% representing the shaft's torque of a real wind turbine. If neither of the 
% previous options can be implemented refer to [1, pg 138] where the 
% fluctuating force related to the external input torque excitation is 
% provided analytically.

tvar = linspace(0,range,length(Tbf)); %torque sampling
% The sampling frequency of the High speed shaft torque might not coincide with that
% of our simulation, e.g., the shaft torque may be obtained 
% from a FAST simulation of a wind turbine or may be associated to a 
% different system. Thus, we need to take into account the shaft torque
% sampling frequency into our time range, explicitly.


%% Torque settings
%dimensional Torque
Tbfm = ones(1,length(Tbf))*mean(Tbf); %mean input torque vector
T1bvar = Tbf - Tbfm ; %fluctation torque vector
N = 1; % scaling parameter
Fbvar = N*T1bvar/r; %  fluctuating force related to the external input torque fluctuations. 
% Notice that, the  fluctuating force 'Fbvar' may need to be rescaled as it
% is associated to the exeternal input torque which may be related to a
% different system than the one we are simulating.
denom = mc*bg*(wn.^2);
Fvar = Fbvar/denom ; % dimensionless input force

%% input force and mesh stiffness function
% input force related to internal vibration
f1  = Fte1*(omega.^2)*cos(omega*tspan);
f2  = Fte2*((2*omega).^2)*cos(2*omega*tspan);
f3  = Fte3*((3*omega).^2)*cos(3*omega*tspan);
f = f1 + f2 + f3;
% mesh stiffness function
K1= k1*cos(omega*tspan);
K2= k2*cos(2*omega*tspan);
K3= k3*cos(3*omega*tspan);
K = ones(size(tspan)) -K1 -K2 -K3;

%% Introuduce cracked tooth effects in mesh stiffness function
ddam = round(25/(dt_sim) ); %duration damage in steps
modulation= linspace(0,13,ddam); % modulation function to decrease 13% stiffness function
Kcr = K; 
spr=round(time_per_rotation/dt_sim); %steps one rotation
ang_dam = 67; % angle at which the damage arises 
ad=round(ang_dam/360*spr); %steps to skip first "ang_dam" degrees and apply the damge in the desired location

% apply damage one time each rotation (n rotations considered)
for j=0:n-1
 for i =1:ddam
    Kcr(j*spr+ad+i)= K(j*spr+ad+i) - K(j*spr+ad+i)/100*(modulation(end-i+1));
 end  
end 

%% plot mesh stiffness function during cracked tooth interaction
figure
l=plot(tspan(spr+ad:spr+ad+ddam),K(spr+ad:spr+ad+ddam),'-',tspan(spr+ad:spr+ad+ddam),Kcr(spr+ad:spr+ad+ddam),'-');
l(1).LineWidth = 2;
l(2).LineWidth = 2;
xlabel('Time (Nondimensional)');
ylabel('Stiffness (Nondimensional)');
legend('healthy','cracked');
title({'Mesh Stiffness (one tooth interaction)'})

%% compute x and xdot using ode45 solver

[th,dxh] = ode45(@(t,y)rhs(t,y,z,Fm,f,K,tspan,b,Fvar,tvar),tspan,[0 ;0]);
[tcr,dxcr] = ode45(@(t,y)rhs(t,y,z,Fm,f,Kcr,tspan,b,Fvar,tvar),tspan,[0 ;0]);

%% Plot Backlash function used to solve ODE
figure
plot(linspace(-2,2,100),Backlash(linspace(-2,2,100),b),'-');
xlabel('x(t)') 
ylabel({'B(x(t))'});
title({'Backlash function'})

%% compute second derivative of x
% the second derivative of x is the dimensionless acceleration signal we want to simulate.

Fvar_interpoh = interp1(tvar,Fvar,th); 
Fvar_interpocr = interp1(tvar,Fvar,tcr);
for i =1:size(dxh)
  ddxh(i) = -2*z*dxh(i,2)-K(i)*Backlash(dxh(i,1),b)+f(i)+Fm+Fvar_interpoh(i);
end

for i =1:size(dxcr)
   ddxcr(i) = -2*z*dxcr(i,2)-Kcr(i)*Backlash(dxcr(i,1),b)+f(i)+Fm+Fvar_interpocr(i);
end


%% plot  acceleration signals, cracked and healthy case for n-2 complete rotations of the shaft
acc_signal_h = ddxh(spr:(n-1)*spr);
acc_signal_cr= ddxcr(spr:(n-1)*spr);%esclude first rotation (consider only stable part of ODE solution)

figure
deg=linspace(0,(n-2)*360,length(acc_signal_h));
degcr=linspace(0,(n-2)*360,length(acc_signal_cr));

nexttile
p1=plot(deg,acc_signal_h,'-', deg,acc_signal_cr,'-');
xlabel('Gear Rotation [deg]') 
ylabel({'acceleration';'(nondimensional)'});
xlim([0 1080])