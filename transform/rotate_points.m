% Copyright (c), IBCAS@2023
% All rights reserved.

function rotated_points = rotate_points(points, center, angle)
    x = points(:,1);
    y = points(:,2);
    x_centered = x - center(1);
    y_centered = y - center(2);
    x_rotated = x_centered * cos(angle) - y_centered * sin(angle);
    y_rotated = x_centered * sin(angle) + y_centered * cos(angle);
    rotated_points = [x_rotated + center(1), y_rotated + center(2)];
end

