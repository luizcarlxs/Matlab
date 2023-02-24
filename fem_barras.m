clc
clear

A1 = pi()*0.020^2;
A2 = pi()*0.020^2;
A3 = pi()*0.015^2;
A4 = pi()*0.015^2;

L1 = 0.180;
L2 = 0.120;
L3 = 0.100;
L4 = 0.100;

EA = 200*10^3; %kPa
EL = 105*10^3; %kPa

k1 = A1*EA/L1; %kN/m
k2 = A2*EA/L2; %kN/m
k3 = A3*EL/L3; %kN/m
k4 = A4*EL/L4; %kN/m

%FA = x %N Incógnita
FB = 60; %kN
FC = 0.0000; %kN
FD = 40; %kN  
F = [FB;FC;FD];

UA = 0;
%UB = x %N Incognita
%UC = x %N Incognita
%UD = x %N Incognita
UE = 0; %N

K1 = k1*[1 -1;-1 1]; %A e B
K2 = k2*[1 -1;-1 1]; %B e C
K3 = k3*[1 -1;-1 1]; %C e D
K4 = k4*[1 -1;-1 1]; %D e E

KG = zeros(5,5); %Matriz Global

KG(1:2,1:2)=K1;
KG(2:3,2:3)=KG(2:3,2:3)+K2;
KG(3:4,3:4)=KG(3:4,3:4)+K3;
KG(4:5,4:5)=KG(4:5,4:5)+K4;

K_delta = KG(2:4,2:4);
U = (K_delta)\F; %A\b for INV(A)*b

U = [0;U;0] %m

FA = KG(1,:)*U;
FE = KG(5,:)*U; 

F = [FA; F; FE] %N
