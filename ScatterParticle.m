function states = ScatterParticle(states)
    global k T m Pscat;
    num_particles = length(states(:,1));
    r = rand(num_particles, 1) < Pscat;
    mu = 0;
    sigma = sqrt(k*T/m);
    velocity_pdf = makedist('Normal', 'mu', mu, 'sigma', sigma);
    states(r,3:4) = random(velocity_pdf, [sum(r), 2]);
end

