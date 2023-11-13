% Copyright (c), IBCAS@2023
% All rights reserved.

% determine whether the chain code is closed
function is_closed  = is_completed_chain_code( chain_code,start_point )
    end_point = start_point; 
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
    end


    d=sqrt(sum(sum((start_point-end_point).^2)));
    
    if(d>2)
        is_closed = 0;
    else
        is_closed = 1;
    end

    % output result
    if is_closed
        disp('Chain code is closed.');
    else
        disp('Chain code is not closed.');

    end
end

