function J = GetDriftCurrent(states)
    global rho qe world;
    J = mean(states(:, 3))*rho*qe*world.height; 
end