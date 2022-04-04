function states = FixInitialPositions(states, boxes)
    num_particles = length(states(:,1));
    left_wall = boxes.left_wall;
    right_wall = boxes.right_wall;
    for i=1:num_particles
        if (states(i, 1) >= left_wall & states(i, 1) <= right_wall)
            %states(i, 1) = states(i, 1) - left_wall;
            states(i, 1) = left_wall*0.9;
        end
    end
end

