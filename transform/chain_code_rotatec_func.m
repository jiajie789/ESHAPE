% Copyright (c) 2023, IBCAS
% All rights reserved.

function [rotated_chain_code] = chain_code_rotatec_func(axis)

    decoded_points = axis;

    % Rotate 90 degrees clockwise
    rotated_points = [decoded_points(:,2), -decoded_points(:,1)]; 

    rotated_chain_code = axis2code(rotated_points);

end

