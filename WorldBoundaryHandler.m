function states = WorldBoundaryHandler(states, specular_boundaries)
    global world;

    if specular_boundaries
        indices = states(:,1) > world.length;
        states(indices,1) = world.length;
        states(indices, 3) = -states(indices, 3);

        indices = states(:,1) < 0;
        states(indices,1) = 0;
        states(indices, 3) = -states(indices, 3);

        indices = states(:,2) > world.height;
        states(indices,4) = -states(indices,4);
        states(indices, 2) = world.height;

        indices = states(:,2) < 0;
        states(indices,4) = -states(indices,4);
        states(indices,2) = 0;
    else
        indices = states(:,1) > world.length;
        states(indices,1) = states(indices,1) - world.length;

        indices = states(:,1) < 0;
        states(indices,1) = states(indices,1) + world.length;

        indices = states(:,2) > world.height;
        states(indices,4) = -states(indices,4);
        states(indices, 2) = world.height;

        indices = states(:,2) < 0;
        states(indices,4) = -states(indices,4);
        states(indices,2) = 0;
    end
    
end

