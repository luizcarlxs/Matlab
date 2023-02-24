clc
clear

k1 = 400;  %N/m
k2 = 400; %N/m
k3 = 300; %N/m
k4 = 200; %N/m
k5 = 500; %N/m

%FA = x %N Incógnita
FB = 0; %N
FC = 250; %N
%FD = x %N Incógnita 
F = [FB;FC];

UA = 0;
%UB = x %N Incognita
%UC = x %N Incognita
UD = 0; %N

K1 = k1*[1 -1;-1 1]%A e B
K2 = k2*[1 -1;-1 1]%B e C
K3 = k3*[1 -1;-1 1]%C e D
K4 = k4*[1 -1;-1 1]%B e C
K5 = k5*[1 -1;-1 1]%B e C

KG = zeros(4,4);

KG(1:2,1:2)=K1;
KG([1,3],[1,3])=KG([1,3],[1,3])+K2;%K3 e K4
KG(2:3,2:3)=KG(2:3,2:3)+K3+K4;%K3 e K4
KG(3:4,3:4)=KG(3:4,3:4)+K5;

K_delta = KG(2:3,2:3);
U = (K_delta)\F; %A\b for INV(A)*b

U = [0;U;0] %m

FA = KG(1,:)*U;
FD = KG(4,:)*U; 

F = [FA; F; FD] %N
