function F = GetFMatrix()
    F = zeros(8, 1);
    
    magnitude = 0.001;
    mu = 0;
    sigma = 0.5;
    In_pdf = makedist('Normal', 'mu', mu, 'sigma', sigma);
    In = magnitude*random(In_pdf);
    
    F(3, 1) = -In;
end

