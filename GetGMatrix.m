function G = GetGMatrix()
    global R1 R2 R3 R4 R0 a;

    g1 = 1/R1;
    g2 = 1/R2;
    g3 = 1/R3;
    g4 = 1/R4;
    g0 = 1/R0;
    
    G = zeros(8, 8);

    G(1, 1) = +g1;
    G(1, 2) = -g1;
    G(1, 7) = +1;

    G(2, 1) = -g1;
    G(2, 2) = g1+g2;
    G(2, 6) = 1;

    G(3, 3) = g3;
    G(3, 6) = -1;

    G(4, 4) = g4;
    G(4, 5) = -g4;
    G(4, 8) = 1;

    G(5, 4) = -g4;
    G(5, 5) = +g4+g0;

    G(6, 2) = +1;
    G(6, 3) = -1;

    G(7, 1) = +1;

    G(8, 3) = -a/(R3);
    G(8, 4) = +1;
end
