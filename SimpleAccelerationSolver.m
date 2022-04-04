function states = SimpleAccelerationSolver(states, Ex, Ey)

    global qe m;

    [X, Y] = meshgrid(linspace(0, 200*10^(-9), 200), ...
                  linspace(0, 100*10^(-9), 100));

    vx = unique(X(:));
    resultx = interp1(vx, vx, states(:, 1), 'previous');

    vy = unique(Y(:));
    resulty = interp1(vy, vy, states(:, 2), 'previous');
    
    num_particles = length(states);
    
    for n=1:num_particles
        index_x = find(vx==resultx(n));
        index_y = find(vy==resulty(n));
        
        if isempty(index_x)
            index_x = 1;
        end
        
        if isempty(index_y)
            index_y = 1;
        end

        Fx = qe*Ex(index_y, index_x);
        Fy = qe*Ey(index_y, index_x);
        
        ax = Fx/m;
        ay = Fy/m;
        
        states(n, 6) = ax*10^9;
        states(n, 7) = ay*10^9;
    end
end

