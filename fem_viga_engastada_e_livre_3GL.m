clc
clear

L = 10; %(m)


A = 36000*10^-6; %(m²);

I = 507.6*10^-6; %(m^4)
E = 200*10^6; %(kN/m²)

a = E*A/L;
b = E*I/L^3;


%Matriz de rigidez da Viga AB
K1 = [a 0 0 -a 0 0; 0 12*b 6*b*L 0 -12*b 6*b*L; 0 6*b*L 4*b*L^2 0 -6*b*L 2*b*L^2; -a 0 0 a 0 0; 0 -12*b -6*b*L 0 12*b -6*b*L; 0 6*b*L 2*b*L^2 0 -6*b*L 4*b*L^2];
%[1 2 3 4]


%Forças Conhecidas
ang = 45*pi()/180; %(rad)
H4 = 8*cos(ang); %kN
V5 = -8*sin(ang); %kN
M6 = 0; % kNm


P = [H4; V5; M6];


%Condições de contorno conhecidas
Dx1 = 0;%(mm)
Dy2 = 0; %(mm)
T3 = 0; %(rad)

%Matriz Global
KG = zeros(6,6);
KG(1:6,1:6)=K1;

KR = KG(4:6,[4:6]);


U = KR\P; %A\b for INV(A)*b


U = [Dx1; Dy2; T3; U(1:3)]; 

H1 = KG(1,:)*U;
V2 = KG(2,:)*U;
M3 = KG(3,:)*U;

P = [H1; V2; M3; P(1:3);]; % kN e kNm

%Resultados
disp("vx1 = "+U(1)*1000+" mm")
disp("vy1 = "+U(2)*1000+" mm")
disp("θ1 = "+round(U(3),5)+" rad")
disp("vx2 = "+U(4)*1000+" mm")
disp("vy2 = "+U(5)*1000+" mm")
disp("θ2 = "+round(U(6),5)+" rad")


disp(" ")%Espaço em Branco

disp("Fx1 = "+P(1)+" kN")
disp("Fy1 = "+P(2)+" kN")
disp("M1 = "+P(3)+" kNm")
disp("Fx2 = "+P(4)+" kN")
disp("Fy2 = "+P(5)+" kN")
disp("M2 = "+P(6)+" kNm")

%Gráficos

%Posições Iniciais Para Cada Nó
p_i_X = [0; L];
p_i_Y = [0; 0];

%Deslocamentos Para Cada Nó
UX = [0; U(4);];
UY = [0; U(5) ];

%Exagero
m = 10;

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

