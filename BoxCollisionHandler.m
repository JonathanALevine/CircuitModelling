function states = BoxCollisionHandler(states, boxes)
    % Locations of the walls of the boxes
    left_wall = boxes.left_wall;
    right_wall = boxes.right_wall;
    top_wall = boxes.top_wall;
    top_wall2 = boxes.top_wall2;
    
    % Check if particle hit left wall of bottom box
    indices =  states(:,1) >= left_wall*0.99 & states(:, 1) <= left_wall*1.01 & states(:,2) < top_wall;
%     if (states(indices,1) - left_wall < states(indices,1) - right_wall)
%         states(indices, 1) = left_wall;
%     else
%         states(indices, 1) = right_wall;
%     end
    
    states(indices, 3) = -states(indices, 3);
    % Check if particle hit the right wall of the bottom box
    indices =  states(:,1) >= right_wall*0.99 & states(:, 1) <= right_wall*1.01 & states(:,2) < top_wall;
    states(indices, 3) = -states(indices, 3);
    
    indices =  states(:,2) <= top_wall*01.01 & states(:,1) > left_wall & states(:,1) < right_wall;
    states(indices, 4) = -states(indices, 4);
    
    indices =  states(:,1) >= left_wall*0.99 & states(:, 1) <= left_wall*1.01 & states(:,2) > top_wall2;
    states(indices, 3) = -states(indices, 3);
    
    indices =  states(:,1) >= right_wall*0.99 & states(:, 1) <= right_wall*1.01 & states(:,2) > top_wall2;
    states(indices, 3) = -states(indices, 3);
    
    indices =  states(:,2) >= top_wall2*0.99 & states(:,1) > left_wall & states(:,1) < right_wall;
    states(indices, 4) = -states(indices, 4);
end