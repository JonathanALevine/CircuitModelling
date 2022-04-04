function VMap = GetVMap(V)
    nx = 200;
    ny = 100;
    VMap = zeros(ny, nx);
    for i = 1:nx
        for j = 1:ny
            n = j + (i-1)*ny;
            VMap(j,i) = V(n);
        end
    end
end

