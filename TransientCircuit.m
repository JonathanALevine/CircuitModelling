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
C = GetCMatrix();
F = zeros(8, 1);

number_of_points = 1000;
start_time = 0;
end_time = 1;
h = (end_time-start_time)/number_of_points;

t = linspace(start_time, end_time, number_of_points);

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

% Get the sine signal
for n = 1:number_of_points
    gaussian_signal = GaussianPulse(t(n));
end

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

figure('name', 'Step Input')
plot(step_signal)
hold on
plot(Vout)
hold off
legend('V_{in}', 'V_0');

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

figure('name', 'Sine Input')
plot(sine_signal)
hold on
plot(Vout)
hold off
legend('V_{in}', 'V_0');

