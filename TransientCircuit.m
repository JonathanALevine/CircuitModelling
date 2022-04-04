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

G = GetGMatrix();
C = GetCMatrix(0);
F = zeros(8, 1);

number_of_points = 1000;
start_time = 0;
end_time = 1;
% Time step
h = (end_time-start_time)/number_of_points;

t = linspace(start_time, end_time, number_of_points);
freq = linspace(-number_of_points/2, number_of_points/2, number_of_points);

% Step input signal
step_signal = zeros(number_of_points, 1);
sine_signal = zeros(number_of_points, 1);
gaussian_signal = zeros(number_of_points, 1);
% Output signal
Vout = zeros(number_of_points, 1);

% Get the step signal
for n = 1:number_of_points
    step_signal(n) = StepInput(t(n));
end

% Get the sine signal
for n = 1:number_of_points
    sine_signal(n) = SineInput(t(n));
end

% Get the gaussian signal
for n = 1:number_of_points
    gaussian_signal(n) = GaussianPulse(t(n));
end

figure('name', 'Time Domain')
% Step signal
% Initial guess
V = zeros(8, 1);
for n = 1:number_of_points
    F(7, 1) = step_signal(n);
    
    left_side = G + 1/h*C;
    right_side = 1/h*C*V + F;
    V = left_side\right_side;
    
    Vout(n) = V(5);
end

Vout_step_fft = fft(Vout);
Vout_step_ffts = fftshift(Vout_step_fft);

Vin_step_fft = fft(step_signal);
Vin_step_ffts = fftshift(Vin_step_fft);

subplot(3, 1, 1)
plot(t, step_signal)
hold on
plot(t, Vout)
hold off
xlabel('Time (s)');
ylabel('Signal (V)');
legend('V_{in}', 'V_0');
title('Step Input')

% Sine signal
% Initial guess
V = zeros(8, 1);
for n = 1:number_of_points
    F(7, 1) = sine_signal(n);
    
    left_side = G + 1/h*C;
    right_side = 1/h*C*V + F;
    V = left_side\right_side;
    
    Vout(n) = V(5);
end

Vout_sine_fft = fft(Vout);
Vout_sine_ffts = fftshift(Vout_sine_fft);

Vin_sine_fft = fft(sine_signal);
Vin_sine_ffts = fftshift(Vin_sine_fft);

subplot(3, 1, 2)
plot(t, sine_signal)
hold on
plot(t, Vout)
hold off
xlabel('Time (s)');
ylabel('Signal (V)');
legend('V_{in}', 'V_0');
title('Sine Input')

% Gaussian signal
% Initial guess
V = zeros(8, 1);
for n = 1:number_of_points
    F(7, 1) = gaussian_signal(n);
    
    left_side = G + 1/h*C;
    right_side = 1/h*C*V + F;
    V = left_side\right_side;
    
    Vout(n) = V(5);
end

Vout_gaussian_fft = fft(Vout);
Vout_gaussian_ffts = fftshift(Vout_gaussian_fft);

Vin_gaussian_fft = fft(gaussian_signal);
Vin_gaussian_ffts = fftshift(Vin_gaussian_fft);

subplot(3, 1, 3)
plot(t, gaussian_signal)
hold on
plot(t, Vout)
hold off
xlabel('Time (s)');
ylabel('Signal (V)');
legend('V_{in}', 'V_0');
title('Gaussian Pulse')

figure('name', 'Frequency Domain');
subplot(3, 1, 1)
plot(freq, abs(Vin_step_ffts))
hold on;
plot(freq, abs(Vout_step_ffts));
hold off;
xlabel('Frequency (Hz)');
ylabel('Signal (V)');
title('Step Input');
legend('V_{in}', 'V_0');

subplot(3, 1, 2)
plot(freq, abs(Vin_sine_ffts))
hold on;
plot(freq, abs(Vout_sine_ffts));
hold off;
xlabel('Frequency (Hz)');
ylabel('Signal (V)');
title('Sine Input');
legend('V_{in}', 'V_0');

subplot(3, 1, 3)
plot(freq, abs(Vin_gaussian_ffts))
hold on;
plot(freq, abs(Vout_gaussian_ffts));
hold off;
xlabel('Frequency (Hz)');
ylabel('Signal (V)');
title('Gaussian Pulse');
legend('V_{in}', 'V_0');

