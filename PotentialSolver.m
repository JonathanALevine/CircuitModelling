function V = PotentialSolver(V0, cMap)
    nx = 200;
    ny = 100;
    G = sparse(nx*ny);
    B = zeros(1, nx*ny);
    for x = 1:nx
        for y = 1:ny
            n = MapNode(y, x, ny);
            nxp = MapNode(y, x+1, ny);
            nxm = MapNode(y, x-1, ny);
            nyp = MapNode(y+1, x, ny);
            nym = MapNode(y-1, x, ny);

            if x == 1
                G(n, n) = 1;
                B(n) = V0;

            elseif x == nx
                G(n, n) = 1;
                B(n) = 0;

            elseif y == 1
                G(n, nxp) = (cMap(x+1, y) + cMap(x,y))/2;
                G(n, nxm) = (cMap(x-1, y) + cMap(x,y))/2;
                G(n, nyp) = (cMap(x, y+1) + cMap(x,y))/2;            
                G(n, n) = -(G(n,nxp)+G(n,nxm)+G(n,nyp));

            elseif y == ny
                G(n, nxp) = (cMap(x+1, y) + cMap(x,y))/2;
                G(n, nxm) = (cMap(x-1, y) + cMap(x,y))/2;
                G(n, nym) = (cMap(x, y-1) + cMap(x,y))/2;
                G(n, n) = -(G(n,nxp)+G(n,nxm)+G(n,nym));

            else
                G(n, nxp) = (cMap(x+1, y) + cMap(x,y))/2;
                G(n, nxm) = (cMap(x-1, y) + cMap(x,y))/2;
                G(n, nyp) = (cMap(x, y+1) + cMap(x,y))/2;
                G(n, nym) = (cMap(x, y-1) + cMap(x,y))/2;
                G(n, n) = -(G(n,nxp)+G(n,nxm)+G(n,nyp)+G(n,nym));
            end
        end
    end
    V = G\B';
end

