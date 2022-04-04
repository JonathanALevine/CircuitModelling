function val = GaussianPulse(t)
    std = 0.03;
    delay = 0.06;
    shift = 4*std + delay;
    val = 1*exp(-((t-shift)^2)/(2*(0.03^2)));
end
