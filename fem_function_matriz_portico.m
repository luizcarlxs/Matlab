%Calcula a matriz do portico

function K = fem_function_matriz_portico(E, I, A, L, ang)

a = E*A/L;
b = E*I/L^3;

lamb = cosd(ang);
u = sind(ang);

K1 = [(a*lamb^2+12*b*u^2) (a-12*b)*lamb*u (-6*b*L*u) (-a*lamb^2-12*b*u^2) -(a-12*b)*lamb*u (-6*b*L*u)];
K2 = [(a-12*b)*lamb*u (a*u^2+12*b*lamb^2) (6*b*L*lamb) -(a-12*b)*lamb*u (-a*u^2-12*b*lamb^2) 6*b*L*lamb];
K3 = [(-6*b*L*u) (6*b*L*lamb) 4*b*L^2 6*b*L*u -6*b*L*u 2*b*L*u];
K4 = [(-a*lamb^2-12*b*u^2) -(a-12*b)*lamb*u 6*b*L*u (a*lamb^2+12*b*u^2) (a-12*b)*lamb*u 6*b*L*u];
K5 = [-(a-12*b)*lamb*u (-a*u^2-12*b*lamb^2) -6*b*L*u (a-12*b)*lamb*u (a*u^2+12*b*lamb^2) -6*b*L*lamb];
K6 = [(-6*b*L*u) 6*b*L*lamb 2*b*L*u 6*b*L*u -6*b*L*lamb 4*b*L^2];

K = [K1; K2; K3; K4; K5; K6]


