clc
clear

L1 = 3; %(m)
L2 = 1; %(m)


A = 0.2*0.2; %(m²);

I = 0.2*0.2^3/12; %(m^4)
E = 200*10^6; %(kN/m²)

a = E*A/L1;
b = E*I/L1^3;

a1 = E*A/L2;
b1 = E*I/L2^3;


%Matriz de rigidez da Viga AB
K1 = [a 0 0 -a 0 0; 0 12*b 6*b*L1 0 -12*b 6*b*L1; 0 6*b*L1 4*b*L1^2 0 -6*b*L1 2*b*L1^2; -a 0 0 a 0 0; 0 -12*b -6*b*L1 0 12*b -6*b*L1; 0 6*b*L1 2*b*L1^2 0 -6*b*L1 4*b*L1^2];
%[1 2 3 4 5 6]

K2 = [a1 0 0 -a1 0 0; 0 12*b1 6*b1*L2 0 -12*b1 6*b1*L2; 0 6*b1*L2 4*b1*L2^2 0 -6*b1*L2 2*b1*L2^2; -a1 0 0 a1 0 0; 0 -12*b1 -6*b1*L2 0 12*b1 -6*b1*L2; 0 6*b1*L2 2*b1*L2^2 0 -6*b1*L2 4*b1*L2^2];
% [4 5 6 7 8 9]

%Forças Conhecidas
H4 = 20; %kN
V5 = 0; %kN
M6 = 0; % kNm
H7 = 0       ; %kN
V8 = -20; %kN
M9 = 0; % kNm


P = [H4; V5; M6; H7; V8; M9];


%Condições de contorno conhecidas
Dx1 = 0;%(mm)
Dy2 = 0; %(mm)
T3 = 0; %(rad)

%Matriz Global
KG = zeros(9,9);
KG(1:6,1:6)=K1;
KG(4:9,4:9)=KG(4:9,4:9)+K2;



KR = KG(4:9,4:9);


U = KR\P; %A\b for INV(A)*b


U = [Dx1; Dy2; T3; U(1:6)]; 

H1 = KG(1,:)*U;
V2 = KG(2,:)*U;
M3 = KG(3,:)*U;

P = [H1; V2; M3; P(1:6);]; % kN e kNm

%Resultados
disp("vx1 = "+U(1)*1000+" mm")
disp("vy1 = "+U(2)*1000+" mm")
disp("θ1 = "+round(U(3),5)+" rad")
disp("vx2 = "+U(4)*1000+" mm")
disp("vy2 = "+U(5)*1000+" mm")
disp("θ2 = "+round(U(6),5)+" rad")
disp("vx3 = "+U(7)*1000+" mm")
disp("vy3 = "+U(8)*1000+" mm")
disp("θ3 = "+round(U(9),5)+" rad")


disp(" ")%Espaço em Branco

disp("Fx1 = "+P(1)+" kN")
disp("Fy1 = "+P(2)+" kN")
disp("M1 = "+P(3)+" kNm")
disp("Fx2 = "+P(4)+" kN")
disp("Fy2 = "+P(5)+" kN")
disp("M2 = "+P(6)+" kNm")
disp("Fx3 = "+P(7)+" kN")
disp("Fy3 = "+P(8)+" kN")
disp("M3 = "+P(9)+" kNm")

%Gráficos

%Posições Iniciais Para Cada Nó
p_i_X = [0; 0; L2];
p_i_Y = [0; L1; L1];

%Deslocamentos Para Cada Nó
UX = [0; U(4);U(7)];
UY = [0; U(5);U(8)];

%Exagero
m = 5;

%Deslocamentos Maximizados
UXm = UX * m;
UYm = UY * m;

%Posições Finais Para Cada Nó
p_f_X = p_i_X + UXm;
p_f_Y = p_i_Y + UYm;

%Geração dos gráficos
%figure;
%plot(p_i_X,p_i_Y,'b-', p_f_X,p_f_Y,'r-','LineWidth',2)
%grid on; axis equal
%5xlabel('X (m)')
%ylabel('Y (m)')
%legend("Posição Inicial", "Posição Final")
%title('Treliça - Posições iniciais e finais')


