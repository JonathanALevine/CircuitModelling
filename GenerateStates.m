function states = GenerateStates(num_particles, distribution_type)
    global world;
    global vth;
    global k m T;
    
    % x, y, vx, vy, temperature, ax, ay
    states = zeros(num_particles, 7);
    
    if distribution_type == 'MB'
        mu = 0;
        sigma = sqrt(k*T/m);
        velocity_pdf = makedist('Normal', 'mu', mu, 'sigma', sigma);
        for i=1:num_particles
            vx = random(velocity_pdf);
            vy = random(velocity_pdf);
            temperature = GetTemperature(vx, vy);
            ax = 0;
            ay = 0;
            states(i,:) = [world.length*rand world.height*rand vx vy temperature ax ay];
        end
    else
        for i=1:num_particles
            angle = rand*2*pi;
            vx = vth*cos(angle);
            vy = vth*sin(angle);
            temperature = GetTemperature(vx, vy);
            ax = 0;
            ay = 0;
            states(i,:) = [world.length*rand world.height*rand vx vy temperature ax ay];
        end    
    end
end

