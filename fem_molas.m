clc
ka = 500;  %N/m
kb = 1000; %N/m
kc = 1000; %N/m

FB = 50; %N
FC = 0; %N
FD = 100; %N

F = [FB;FC;FD];

K1 = ka*[1 -1;-1 1];
K2 = kb*[1 -1;-1 1];
K3 = kc*[1 -1;-1 1];
KG = zeros(4,4);

KG(1:2,1:2)=K1;
KG(2:3,2:3)=KG(2:3,2:3)+K2;
KG(3:4,3:4)=KG(3:4,3:4)+K3;

K_delta = KG(2:4,2:4);
U = inv(K_delta)*F;
U = [0;U]

FA = KG(1,:)*U %N

