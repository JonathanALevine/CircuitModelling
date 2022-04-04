function cMap = ConductivityMap(sigma_inside, sigma_outside, box)
    % Define the limits of the boxes
    nx = 200;
    ny = 100;
    global boxes;
    boxes = [nx*(box.left_wall/10^(-9))/200 nx*(box.right_wall/10^(-9))/200 ny*(box.top_wall/10^(-9))/100 ny*(box.top_wall2/10^(-9))/100]; 
    
    cMap = zeros(nx, ny);
    for i=1:nx
        for j=1:ny
            if i > boxes(1) && i < boxes(2) & (j < boxes(3) || j > boxes(4))
                cMap(i, j) = sigma_inside;
            else
                cMap(i, j) = sigma_outside;
            end
        end
    end
end

