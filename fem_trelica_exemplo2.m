clc
clear

d = 10; %(mm)
A = pi()*(0.5*d/1000)^2; %(m²)


L1 = sqrt(1.5^2+1^2);
L2 = sqrt(1.5^2+1.3^2);

L=[L1;L2];

E = 210*10^6; %(kPa)

k1 = A*E/L1; %(kN/m)
k2 = A*E/L2; %(kN/m)

%barra 1
alfa1 = 2*pi()-atan(1.5/1);
a1 = cos(alfa1)^2;
a2 = sin(alfa1)*cos(alfa1);
a3 = cos(alfa1)*sin(alfa1);
a4 = sin(alfa1)^2;

%Barra 2
alfa2 = pi()+atan(1.5/1.3);
b1 = cos(alfa2)^2;
b2 = sin(alfa2)*cos(alfa2);
b3 = cos(alfa2)*sin(alfa2);
b4 = sin(alfa2)^2;



%Matriz de rigidez da barra 1
K1 = k1*[a1 a2 -a1 -a2; a3 a4 -a3 -a4; -a1 -a2 a1 a2; -a3 -a4 a3 a4];
%[1 2 3 4]

%Matriz de rigidez da barra 2
K2 = k2*[b1 b2 -b1 -b2; b3 b4 -b3 -b4; -b1 -b2 b1 b2; -b3 -b4 b3 b4];
%[3 4 5 6]


%Forças Conhecidas
F4 = -50;
F3 = 0.0;
F = [F3; F4]


%Deslocamentos Conhecidos[
U1 = 0;
U2 = 0;
U3 = 0;
U5 = 0;
U6 = 0;


%Matriz Global
KG = zeros(6,6); 
KG([1,2,3,4],[1,2,3,4])=K1;
KG([3,4,5,6],[3,4,5,6])=KG([3,4,5,6],[3,4,5,6])+K2;

K_delta = KG([3,4],[3,4]); 


U = K_delta\F; %A\b for INV(A)*b

U = [0;0;U(1);U(2);0;0] %EM mm
%U = [0;U;0] %m

%F em kN

F1 = KG(1,:)*U;
F2 = KG(2,:)*U;
F5 = KG(5,:)*U;
F6 = KG(6,:)*U;

F = [F1; F2; F(1); F(2); F5; F6] % kN


%Gráficos

%Posições Iniciais Para Cada Nó
p_i_X = [0; 1; 2.3];
p_i_Y = [0; -1.5; 0];

%Deslocamentos Para Cada Nó
UX = [U(1); U(3); U(5);];
UY = [U(2); U(4); U(6);];

%Exagero
m = 50;

%Deslocamentos Maximizados
UXm = UX * m;
UYm = UY * m;

%Posições Finais Para Cada Nó
p_f_X = p_i_X + UXm;
p_f_Y = p_i_Y + UYm;

%Geração dos gráficos
figure;
plot(p_i_X,p_i_Y,'b-', p_f_X,p_f_Y,'r-','LineWidth',2)
grid on; axis equal
xlabel('X (m)')
ylabel('Y (m)')
legend("Posição Inicial", "Posição Final")
title('Treliça - Posições iniciais e finais')

