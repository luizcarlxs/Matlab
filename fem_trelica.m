clc
clear

d = 10; %(mm)
A = pi()*(0.5*d/1000)^2; %(m²)


L1 = 2;
L2 = sqrt(2*2^2);
L3 = 2;

E = 200*10^6; %(kPa)

k1 = A*E/L1; %(kN/m)
k2 = A*E/L2; %(kN/m)
k3 = A*E/L3; %(kN/m)


%barra 1
alfa1 = 0*(pi()/180); %(graus)
a1 = cos(alfa1)^2;
a2 = sin(alfa1)*cos(alfa1);
a3 = cos(alfa1)*sin(alfa1);
a4 = sin(alfa1)^2;

%Barra 2
alfa2 = 135*pi()/180; %(graus)
b1 = cos(alfa2)^2;
b2 = sin(alfa2)*cos(alfa2);
b3 = cos(alfa2)*sin(alfa2);
b4 = sin(alfa2)^2;

%Barra 3
alfa3 = 270*pi()/180; %(graus)
c1 = cos(alfa3)^2;
c2 = sin(alfa3)*cos(alfa3);
c3 = cos(alfa3)*sin(alfa3);
c4 = sin(alfa3)^2;

%Matriz de rigidez da barra 1
K1 = k1*[a1 a2 -a1 -a2; a3 a4 -a3 -a4; -a1 -a2 a1 a2; -a3 -a4 a3 a4];
%[1 2 3 4]

%Matriz de rigidez da barra 2
K2 = k2*[b1 b2 -b1 -b2; b3 b4 -b3 -b4; -b1 -b2 b1 b2; -b3 -b4 b3 b4];
%[3 4 5 6]

%Matriz de rigidez da barra 3
K3 = k3*[c1 c2 -c1 -c2; c3 c4 -c3 -c4; -c1 -c2 c1 c2; -c3 -c4 c3 c4];   
%[5 6 1 2

%Forças Conhecidas
F3 = 0;
F5 = 0;
F6 = 1;
F = [F3; F5; F6];

%Deslocamentos Conhecidos[
U1 = 0;
U2 = 0;
U4 = 0;


%Matriz Global
KG = zeros(6,6); 
KG([1,2,3,4],[1,2,3,4])=K1;
KG([3,4,5,6],[3,4,5,6])=KG([3,4,5,6],[3,4,5,6])+K2;
KG([5,6,1,2],[5,6,1,2])=KG([5,6,1,2],[5,6,1,2])+K3;

K_delta = KG([3,5,6],[3,5,6]);  


U = K_delta\F; %A\b for INV(A)*b

U = [0;0;U(1);0;U(2);U(3)] %EM mm
%U = [0;U;0] %m

%F em kN
F1 = KG(1,:)*U;
F2 = KG(2,:)*U;
F4 = KG(4,:)*U;

F = [F1; F2; F(1); F4; F(2); F(3)] % kN


%Gráficos

%Posições Iniciais Para Cada Nó
p_i_X = [0; L1; 0; 0];
p_i_Y = [0; 0; L3; 0];

%Deslocamentos Para Cada Nó
UX = [U(1); U(3); U(5);U(1)];
UY = [U(2); U(4); U(6);U(2)];

%Exagero
m = 500;

%Deslocamentos Maximizados
UXm = UX * m;
UYm = UY * m;

%Posições Finais Para Cada Nó
p_f_X = p_i_X + UXm;
p_f_Y = p_i_Y + UYm;

%Geração dos gráficos
figure;
plot(p_i_X,p_i_Y,'b-',p_f_X,p_f_Y,'r-','LineWidth',2)
grid on; axis equal
xlabel('X (m)')
ylabel('Y (m)')
title('Treliça - Posições iniciais e finais')

