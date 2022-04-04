close all;  
clear; %intialization

set(0,'DefaultFigureWindowStyle','docked')

% Circuit Parameters
% R3 was determined from assignment 3 simulation
global R1 R2 R3 R4 R0 L c a;
R1 = 1;
R2 = 2;
R3 = 23.0821;
R4 = 0.1;
R0 = 1000;
L = 0.2;
c = 0.25;
a = 100;

save_plots = 1;

G = GetGMatrix();
C = GetCMatrix(0);
F = zeros(8, 1);

% Programing (i)
figure('name', 'Programing (i)');
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
ylabel('Signal (V)');
legend('V_3', 'V_0');

if save_plots
    FN2 = 'Figures/Programing_i';   
    print(gcf, '-dpng', '-r600', FN2);  %Save graph in PNG
end

% Programing (ii)
figure('name', 'Programing (ii)');
F(7, 1) = 1;
omega = linspace(0,500, 1000);
for n = 1:length(omega)
    s = 1i*omega(n);
    V = (G + s*C)\F;
    
    Vout(n) = abs(V(5));
end

subplot(2, 1, 1)
plot(omega, Vout)
xlabel('\omega (rad/s)');
ylabel('|V|');
title('|V| vs. \omega')

subplot(2, 1, 2)
semilogx(omega, 20*log10(Vout))
xlabel('\omega (rad/s)');
ylabel('V_0/V_1 (dB)');
title('dB Gain vs. \omega')

if save_plots
    FN2 = 'Figures/Programing_ii';   
    print(gcf, '-dpng', '-r600', FN2);  %Save graph in PNG
end

% Programing (iii)
figure('name', 'Programing (iii)');
F(7, 1) = 1;
omega = pi;
mu = c;
sigma = 0.05;
capacitor_pdf = makedist('Normal', 'mu', mu, 'sigma', sigma);
for n=1:1:10000
    c_val(n) = random(capacitor_pdf);
    s = 1i*omega;
    C(1, 1) = +c_val(n);
    C(1, 2) = -c_val(n);
    C(2, 1) = -c_val(n);
    C(2, 2) = +c_val(n);
    
    V = (G + s*C)\F;
    
    Vout(n) = abs(V(5));
end

subplot(1, 2, 1)
histogram(c_val, 50);
xlabel('C Val');
ylabel('Count');

subplot(1, 2, 2)
histogram(Vout/F(7, 1), 50);
xlabel('V_0/V_{in}');
ylabel('Count');

if save_plots
    FN2 = 'Figures/Programing_iii';   
    print(gcf, '-dpng', '-r600', FN2);  %Save graph in PNG
end


