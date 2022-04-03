close all;  
clear; %intialization

set(0,'DefaultFigureWindowStyle','docked')

% Part (a)
% Circuit Parameters
R1 = 1;
R2 = 2;
R3 = 10;
R4 = 0.1;
R0 = 1000;
L = 0.2;
c = 0.25;
a = 100;

g1 = 1/R1;
g2 = 1/R2;
g3 = 1/R3;
g4 = 1/R4;
g0 = 1/R0;

% Build G annd C matrices;
G = zeros(8, 8);
C = zeros(8, 8);
F = zeros(8, 1);

G(1, 1) = +g1;
G(1, 2) = -g1;
G(1, 7) = +1;

G(2, 1) = -g1;
G(2, 2) = g1+g2;
G(2, 6) = 1;

G(3, 3) = g3;
G(3, 6) = -1;

G(4, 4) = g4;
G(4, 5) = -g4;
G(4, 8) = 1;

G(5, 4) = -g4;
G(5, 5) = +g4+g0;

G(6, 2) = +1;
G(6, 3) = -1;

G(7, 1) = +1;

G(8, 3) = -a/(R3);
G(8, 4) = +1;

C(1, 1) = +c;
C(1, 2) = -c;

C(2, 1) = -c;
C(2, 2) = +c;

C(6, 6) = -L;

% Part (b)
subplot(2, 2, 1)
index = 1;
for v = -10:1:10
    F(7, 1) = v;
    
    V = G\F;
    Vout(index) = V(5);
    V3(index) = V(3);
    
    index = index + 1;
end

plot(-10:1:10, V3);
hold on
plot(-10:1:10, Vout)
hold off;
xlabel('V_{in} (V)');
ylabel('V (V)');
legend('V_3', 'V_0');

% Part (c)
subplot(2, 2, 2)
F(7, 1) = 1;
omega = linspace(0,100);
for n = 1:length(omega)
    s = 1i*omega(n);
    V = (G + s*C)\F;
    
    V3(n) = abs(V(3));
    Vout(n) = abs(V(5));
end

plot(omega, V3);
hold on
plot(omega, Vout)
hold off;
xlabel('\omega (rad/s)');
ylabel('|V|');
legend('V_3', 'V_0');

% Part (d)
subplot(2, 2, 3)
F(7, 1) = 1;
omega = pi;
mu = c;
sigma = 0.05;
capacitor_pdf = makedist('Normal', 'mu', mu, 'sigma', sigma);
for n=1:1:1000
    c_val(n) = random(capacitor_pdf);
    s = 1i*omega;
    C(1, 1) = +c_val(n);
    C(1, 2) = -c_val(n);
    C(2, 1) = -c_val(n);
    C(2, 2) = +c_val(n);
    
    V = (G + s*C)\F;
    
    Vout(n) = abs(V(5));
end
hist(c_val);
xlabel('C Val');
ylabel('Number');

subplot(2, 2, 4)
hist(Vout/F(7, 1));
xlabel('V_0/V_{in}');
ylabel('Number');
