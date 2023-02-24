clc
clear

L1 = 10; %(m)
L2 = 10; %(m)

b = 0.4; %(m)
h = 0.2; %(m)
I = (b * h^3)/12; %(m^4)
E = 200*10^6; %(kN/m²)

k1 = E*I/L1^3; %(kN/m
k2 = E*I/L2^3; %(kN/m)


%Coeficientes da matriz de Rigidez da viga AB
a1 = 12; a2 = 6*L1; a3 = -12; a4 = 6*L1;
b1 = 6*L1; b2 = 4*L1^2; b3 = -6*L1; b4 = 2*L1^2;
c1 = -12; c2 = -6*L1; c3 = 12; c4 = -6*L1; 
d1 = 6*L1; d2 = 2*L1^2; d3 = -6*L1; d4 = 4*L1^2;

%Matriz de rigidez da Viga AB
K1 = k1*[a1 a2 a3 a4; b1 b2 b3 b4; c1 c2 c3 c4; d1 d2 d3 d4];
%[1 2 3 4]

%Coeficientes da matriz de Rigidez da Viga BC
aa1 = 12; aa2 = 6*L2; aa3 = -12; aa4 = 6*L2;
bb1 = 6*L2; bb2 = 4*L2^2; bb3 = -6*L2; bb4 = 2*L2^2;
cc1 = -12; cc2 = -6*L2; cc3 = 12; cc4 = -6*L2; 
dd1 = 6*L2; dd2 = 2*L2^2; dd3 = -6*L2; dd4 = 4*L2^2;

%Matriz de rigidez da Viga BC
K2 = k2*[aa1 aa2 aa3 aa4; bb1 bb2 bb3 bb4; cc1 cc2 cc3 cc4; dd1 dd2 dd3 dd4];
%[3 4 5 6]

%Forças Conhecidas
M2 = 0; %ACHAR θA
V3 = -1; %ACHAR v2
M4 = 0; %ACHAR θB
M6 = 0; %ACHAR θC

P = [M2; V3; M4; M6];


%Condições de contorno conhecidas
V1 = 0;
V5 = 0;





%Matriz Global
KG = zeros(6,6);
KG(1:4,1:4)=K1;
KG(3:6,3:6)=KG(3:6,3:6)+K2;

KR = KG([2,3,4,6],[2,3,4,6]);


U = KR\P; %A\b for INV(A)*b


U = [V1; U(1); U(2); U(3); V5; U(4)]; 

F1 = KG(1,:)*U;
F5 = KG(5,:)*U;

P = [F1; P(1); P(2); P(3); F5; P(4)]; % kN e kNm

%Resultados
disp("v1 = "+U(1)*1000+" mm")
disp("θ1 = "+round(U(2),5)+" rad")
disp("v2 = "+U(3)*1000+" mm")
disp("θ2 = "+round(U(4),5)+" rad")
disp("v3 = "+U(5)*1000+" mm")
disp("θ3 = "+round(U(6),5)+" rad")


disp(" ")%Espaço em Branco

disp("F1 = "+P(1)+" kN")
disp("M1 = "+P(2)+" kNm")
disp("F2 = "+P(3)+" kN")
disp("M2 = "+P(4)+" kNm")
disp("F3 = "+P(5)+" kN")
disp("M3 = "+P(6)+" kNm")

%Gráficos

%Posições Iniciais Para Cada Nó
p_i_X = [0; L1; L1+L2];
p_i_Y = [0; 0; 0];

%Deslocamentos Para Cada Nó
UX = [0; 0; 0];
UY = [U(1); U(3); U(5)];

%Exagero
m = 100;

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

