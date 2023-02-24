clc
clear

% DADOS DE ENTRADA
E = [200*10^6;200*10^6]; % MÓDULO DE ELASTICIADE (kPa OU kN/m²)
A = [0.2^2;0.2^2]; % ÁREA DA SEÇÃO TRANSVERSAL (m²)
I = [0.2*0.2^3/12;0.2*0.2^3/12]; % MOMENTO DE INÉRCIA (m^4)
L= [3;1]; % COMPRIMENTO DA BARRA (m) 
ang = [90;0]; % ÂNGULO COM O EIXO X (Graus)

% CALCULA O NUMERO DE TERMOS DA MATRIZ [NUMERO DE BARRAS]
lenL = length(L);
n = 3*(lenL+1);

% CRIA A MATRIZ NULA
KG = zeros(n,n);

for i=1:lenL
    K = fem_function_matriz_portico(E(i),I(i),A(i),L(i),ang(i))
    KG([1+(i-1)*3:6+(i-1)*3],[1+(i-1)*3:6+(i-1)*3])=KG([1+(i-1)*3:6+(i-1)*3],[1+(i-1)*3:6+(i-1)*3])+K;
end

%Forças Conhecidas
H4 = 20; %kN
V5 = 0; %kN
M6 = 0; % kNm
H7 = 0; %kN
V8 = -20; %kN
M9 = 0; % kNm


P = [H4; V5; M6; H7; V8; M9];


%Condições de contorno conhecidas
Dx1 = 0;%(mm)
Dy2 = 0; %(mm)
T3 = 0; %(rad)



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
p_i_X = [0; 0; L(2)];
p_i_Y = [0; L(1); L(1)];

%Deslocamentos Para Cada Nó
UX = [0; U(4);U(7)];
UY = [0; U(5);U(8)];

%Exagero
m = 50;

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

