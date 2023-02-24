clc
clear

L = 3; %(m)
EI = 10*10^3; %(kNm²)

k = EI/L^3; %(kN/m)


%Matriz de rigidez da Viga
a1 = 12; a2 = 6*L; a3 = -12; a4 = 6*L;
b1 = 6*L; b2 = 4*L^2; b3 = -6*L; b4 = 2*L^2;
c1 = -12; c2 = -6*L; c3 = 12; c4 = -6*L; 
d1 = 6*L; d2 = 2*L^2; d3 = -6*L; d4 = 4*L^2;

K = k*[a1 a2 a3 a4; b1 b2 b3 b4; c1 c2 c3 c4; d1 d2 d3 d4];
%[1 2 3 4]


%Forças Conhecidas
F3 = -50; %kN
M4 = 90; %kNm
P = [F3; M4];

%Condições de contorno conhecidas
V1 = 0;
T2 = 0;




%Matriz Global
%KG([1,2,3,4],[1,2,3,4])=K1;
%KG([3,4,5,6],[3,4,5,6])=KG([3,4,5,6],[3,4,5,6])+K2;

K_delta = K([3,4],[3,4]);


U = K_delta\P; %A\b for INV(A)*b


U = [V1; T2; U(1); U(2)]; %EM mm

F1 = K(1,:)*U;
M2 = K(2,:)*U;

P = [F1; M2; P(1); P(2);]; % kN

%Resultados
disp("v1 = "+U(1)*1000+" mm")
disp("θ1 = "+U(2)+" rad")
disp("v2 = "+U(3)*1000+" mm")
disp("θ2 = "+U(4)+" rad")

disp(" ")%Espaço em Branco

disp("F1 = "+P(1)+" kN")
disp("M1 = "+P(2)+" kNm")
disp("F2 = "+P(3)+" kN")
disp("M2 = "+P(4)+" kNm")

%Gráficos

%Posições Iniciais Para Cada Nó
p_i_X = [0; L];
p_i_Y = [0; 0];

%Deslocamentos Para Cada Nó
UX = [0; -L+L*cos(U(4))];
UY = [0; U(3)];

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

