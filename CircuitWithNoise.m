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

save_plots = 1;

G = GetGMatrix();
C = GetCMatrix(Cn);

number_of_points = 1000;
start_time = 0;
end_time = 1;
h = (end_time-start_time)/number_of_points;

t = linspace(start_time, end_time, number_of_points);
freq = linspace(-number_of_points/2, number_of_points/2, number_of_points);

% Gaussian Input Signal
gaussian_signal = zeros(number_of_points, 1);
% Output signal
Vout = zeros(number_of_points, 1);

% Get the gaussian signal
for n = 1:number_of_points
    gaussian_signal(n) = GaussianPulse(t(n));
end

figure('name', 'Circuit With Noise')
% Gaussian signal
% Initial guess
V = zeros(8, 1);
for n = 1:number_of_points
    F = GetFMatrix();
    F(7, 1) = gaussian_signal(n);
    
    left_side = G + 1/h*C;
    right_side = 1/h*C*V + F;
    V = left_side\right_side;
    
    Vout(n) = V(5);
end

Vout_fft = fft(Vout);
Vout_ffts = fftshift(Vout_fft);

Vin_fft = fft(gaussian_signal);
Vin_ffts = fftshift(Vin_fft);

subplot(2, 1, 1)
plot(t, gaussian_signal)
hold on 
plot(t, Vout)
hold off
xlabel('Time (s)');
ylabel('Signal (V)');
title('Response in Time Domain');
legend('V_{in}', 'V_0');

subplot(2, 1, 2)
plot(freq, abs(Vin_ffts))
hold on;
plot(freq, abs(Vout_ffts));
hold off;
xlabel('Frequency (Hz)');
ylabel('Signal (V)');
title('Response in Frequency Domain');
legend('V_{in}', 'V_0');

if save_plots
    FN2 = 'Figures/CircuitWithNoise';   
    print(gcf, '-dpng', '-r600', FN2);  %Save graph in PNG
end


