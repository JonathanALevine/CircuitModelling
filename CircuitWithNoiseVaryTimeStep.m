close all;  
clear; %intialization

set(0,'DefaultFigureWindowStyle','docked')

% Circuit Parameters
% R3 was determined from assignment 3 simulation
global R1 R2 R3 R4 R0 L c a Cn;
R1 = 1;
R2 = 2;
R3 = 23.0821;
R4 = 0.1;
R0 = 1000;
L = 0.2;
c = 0.25;
a = 100;
Cn = 0.00001;
number_of_points = [100; 1000; 10000];

save_plots = 1;

figure('name', 'Circuit With Noise')
for simulation=1:length(number_of_points)
    G = GetGMatrix();
    C = GetCMatrix(Cn);

    start_time = 0;
    end_time = 1;
    h = (end_time-start_time)/number_of_points(simulation);
    
    t = linspace(start_time, end_time, number_of_points(simulation));
    freq = linspace(-number_of_points(simulation)/2, number_of_points(simulation)/2, number_of_points(simulation));

    % Step input signal
    gaussian_signal = zeros(number_of_points(simulation), 1);
    % Output signal
    Vout = zeros(number_of_points(simulation), 1);

    % Get the gaussian signal
    for n = 1:number_of_points(simulation)
        gaussian_signal(n) = GaussianPulse(t(n));
    end

    % Gaussian signal
    % Initial guess
    V = zeros(8, 1);
    for n = 1:number_of_points(simulation)
        F = GetFMatrix();
        F(7, 1) = gaussian_signal(n);

        left_side = G + 1/h*C;
        right_side = 1/h*C*V + F;
        V = left_side\right_side;

        Vout(n) = V(5);
    end

    subplot(length(number_of_points), 1, simulation)
    plot(t, gaussian_signal)
    hold on 
    plot(t, Vout)
    hold off
    xlabel('Time (s)');
    ylabel('Signal (V)');
    title(['Time Step = ', num2str(h), ' s']);
    legend('V_{in}', 'V_0');
end

if save_plots
    FN2 = 'Figures/CircuitWithNoiseVaryTimeStep';   
    print(gcf, '-dpng', '-r600', FN2);  %Save graph in PNG
end

