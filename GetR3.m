close all;  
clear; %intialization

set(0,'DefaultFigureWindowStyle','docked')

% Constants
global m0 m T k tau qe Pscat rho;
m0 = 9.10938356*10^(-31); %Electron rest mass
m = 0.26*m0; 
T = 300;
k = 1.38064852*10^(-23); %Boltzmann Constant
tau = 0.2*10^(-12);
qe = 1.60217662*10^(-19); % Electron charge
rho = 10^(19); %Electron concentration in m^(-2)

% Simulation controls
global world;
world.length = 200*10^(-9);
world.height = 100*10^(-9);

global vth;
vth = sqrt(2*k*T/m);

% The mean free path = velocity*mean time between collisions
MFP = vth * tau;

% Simulation Controls
num_particles = 10000;
traced_particles = 10;
distribution_type = 'MB';
epochs = 1000;
show_all_particles = 0;
save_plots = 1;
scatter_particle = 1;
bottleneck = 0;

global dt;
dt = world.height/vth/100;
Pscat = 1 - exp(-dt/tau);

[X, Y] = meshgrid(linspace(0, 200*10^(-9), 200), ...
              linspace(0, 100*10^(-9), 100));
          
global box;
box.left_wall = 80*10^(-9);
box.right_wall = 120*10^(-9);
box.top_wall = 40*10^(-9);
box.top_wall2 = 60*10^(-9);

% Generate the states and fix their initial positions
states = GenerateStates(num_particles, distribution_type);
states = FixInitialPositions(states, box);

voltages = linspace(0.1, 10, 5);

simulations = length(voltages);

AverageDriftCurrents = zeros(simulations, 1);

for simulation=1:simulations
    % Make the conductivity map
    cMap = ConductivityMap(0.01, 1, box);
    V = PotentialSolver(voltages(simulation), cMap);

    temperatures = zeros(epochs, 1);
    DriftCurrents = zeros(epochs, 1);

    [Ex, Ey] = gradient(GetVMap(V));
    Ex = -Ex;
    Ey = -Ey; 
    
    for epoch = 1:epochs
        % Simple Acceleration Solver 
        states = SimpleAccelerationSolver(states, Ex, Ey);
        % Check the boundary conditions of the particles
        states = WorldBoundaryHandler(states, 0);
        % HANDLE THE BOX COLLISIONS
        states = BoxCollisionHandler(states, box);
        % Scatter the particle
        if scatter_particle
            states = ScatterParticle(states);
        end
        % Move the particle
        states = MoveParticle(states);
        % Get the semi conductor temperature at this time step
        temperatures(epoch) = mean(states(:,5));
        % Get the electron drift current
        DriftCurrents(epoch) = GetDriftCurrent(states);

        epoch/epochs * 100
    end
    
    mean(DriftCurrents)
    AverageDriftCurrents(simulation) = mean(DriftCurrents);
end

figure('name', 'Average Drift Current vs. Voltage');
plot(AverageDriftCurrents, voltages);
xlabel('Average Drift Current (A)');
ylabel('Voltage (V)');
grid on;
polyfit(AverageDriftCurrents, voltages, 1)

if save_plots
    FN2 = 'Figures/GetR3Plot';   
    print(gcf, '-dpng', '-r600', FN2);  %Save graph in PNG
end

