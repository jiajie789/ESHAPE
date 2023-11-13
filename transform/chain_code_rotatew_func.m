% Copyright (c) 2023, IBCAS
% All rights reserved.

function [rotated_chain_code,rotated_points] = chain_code_rotatew_func(axis)
    
    rotation_center = axis(1,:); % Centered on the starting point
    rotated_points = rotate_points(axis, rotation_center, pi/2); % Rotate 90 degrees counterclockwise

    rotated_points=round(rotated_points);
    rotated_chain_code = axis2code(rotated_points);

end

