% Copyright (c), IBCAS@2023
% All rights reserved.

% convert chaincode to coordinates.
function [chain_code] = axis2code(points)
    chain_code = [];

    for i = 2:size(points,1)
        dx = points(i,1) - points(i-1,1);
        dy = points(i,2) - points(i-1,2);
        
        if dx == 0 && dy == 1
            chain_code = [chain_code, 0];
        elseif dx == 1 && dy == 1
            chain_code = [chain_code, 7];
        elseif dx == 1 && dy == 0
            chain_code = [chain_code, 6];            
        elseif dx == 1 && dy == -1
            chain_code = [chain_code, 5];
        elseif dx == 0 && dy == -1
            chain_code = [chain_code, 4];
        elseif dx == -1 && dy == -1
            chain_code = [chain_code, 3];
        elseif dx == -1 && dy == 0
            chain_code = [chain_code, 2];
        elseif dx == -1 && dy == 1
            chain_code = [chain_code, 1];
        else
            disp(i);
        end
    end
end


