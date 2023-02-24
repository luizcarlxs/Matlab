clc
clear

%DADOS DE ENTRADA
E = [200*10^6;200*10^6]; % MÓDULO DE ELASTICIADE (kPa OU kN/m²)
A = [10^-2;10^-2]; % ÁREA DA SEÇÃO TRANSVERSAL (m²)
I = [300*10^-6;300*10^-6]; % MOMENTO DE INÉRCIA (m^4)
L= [4;2]; % COMPRIMENTO DA BARRA (m) 
ang = [0;90]; % ÂNGULO COM O EIXO X (Graus) 



for i=1:length(L)
fem_function_matriz_portico(E(i),I(i),A(i),L(i),ang(i))
end