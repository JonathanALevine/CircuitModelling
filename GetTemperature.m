function temperature = GetTemperature(vx, vy)
    global k m; 
    temperature = (vx.^2 + vy.^2)./(2*k)*m;
end

