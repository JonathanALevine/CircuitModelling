function val = StepInput(t)
    [t0, t1] = deal(0, 0.03);
    [A0, A1] = deal(0, 1);

    if t< t0
        val = A0;

    elseif t < t1
        val = A0;

    else
        val = A1;
    end
end
