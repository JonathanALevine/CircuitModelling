function C = GetCMatrix()
    global c L;

    C = zeros(8, 8);

    C(1, 1) = +c;
    C(1, 2) = -c;

    C(2, 1) = -c;
    C(2, 2) = +c;

    C(6, 6) = -L;
end

