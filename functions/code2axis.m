% Copyright (c), IBCAS@2023
% All rights reserved.

% Convert chain code to coordinates. 
function [ axis ] = code2axis( chain_code,start_point )

    end_point = start_point; 
    axis=zeros(length(chain_code)+1,2);
    axis(1,:)=start_point;
    for i = 1:length(chain_code)
        direction = mod(chain_code(i), 8);
        if direction == 0
            end_point = end_point + [0, 1];
        elseif direction == 7
            end_point = end_point + [1, 1];
        elseif direction == 6
            end_point = end_point + [1, 0];
        elseif direction == 5
            end_point = end_point + [1, -1];
        elseif direction == 4
            end_point = end_point + [0, -1];
        elseif direction == 3
            end_point = end_point + [-1, -1];
        elseif direction == 2
            end_point = end_point + [-1, 0];
        elseif direction == 1
            end_point = end_point + [-1,1];
        end
        axis(i+1,:)=end_point;
    end

end

