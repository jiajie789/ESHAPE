% Copyright (c), IBCAS@2023
% All rights reserved.

% Calculate area and circumference.
function [ area ,circumference] = cal_area_c( chain_code )
    coordinates=code2axis(chain_code,[0, 0]);    
    min_y = min(coordinates(:, 1));
    max_y = max(coordinates(:, 1));
    area = 0;
    for y = min_y:max_y
        % The horizontal coordinate where the contour intersects the scan line
        intersection_indices = find(coordinates(:, 1) == y);
        intersection_count = length(intersection_indices);  
        intersections = zeros(1, intersection_count);
        for i = 1:intersection_count
            index = intersection_indices(i);
            intersections(i) = coordinates(index, 2);
        end
        intersections = sort(intersections);
        % caculate area
        for i = 1:2:intersection_count-1
            area = area + (intersections(i+1) - intersections(i))+1;
        end
    end
    % output result
    fprintf('area(pixel):%d\n', area);
    circumference=0;
    for i=1:length(chain_code)
        if mod(chain_code(i), 2) == 0
            circumference=circumference+norm([1,0]);
        else
            circumference=circumference+norm([1,1]);
        end
    end
    fprintf('circumference(pixel):%d\n', circumference);
end

