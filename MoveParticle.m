function states = MoveParticle(states)
    global dt;
    states(:, 3) = states(:, 3) + states(:, 6)*dt;
    states(:, 4) = states(:, 4) + states(:, 7)*dt;
    states(:,1) = states(:,1) + states(:,3)*dt;
    states(:,2) = states(:,2) + states(:,4)*dt;
    states(:,5) = GetTemperature(states(:,3), states(:,4));
end