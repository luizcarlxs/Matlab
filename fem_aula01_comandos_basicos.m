%limpar tudo
clc
clear 
%Matriz com Linhas e colunas
A = [1 2 3; 4 5 6; 7 8 9]
B = [1 1 1; 1 1 1; 1 1 1];

% Matriz de Zeros
C = zeros(4,4);

%Quadrantes específicos
A(2:3,2:3);

%Linha e colunas específicas
A([1,2],[1,3])

C(1:3,1:3)=A;
C(2:4,2:4)=C(2:4,2:4)+B;

%Excluindo a coluna 4
C(:,4)=[];

%Excluindo a linha 3
C(3,:)=[];

%inversão de matriz
K = [1500 -1000 0; -1000 2000 -1000; 0 -1000 1000]
invK = inv(K)