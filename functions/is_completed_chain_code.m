function is_closed  = is_completed_chain_code( chain_code,start_point )
%UNTITLED 此处显示有关此函数的摘要
%   此处显示详细说明
   % 输入链式编码
    % 获取起始点和最后一个点的坐标
%     start_point = [631, 40]; % 起始点坐标
    end_point = start_point; % 初始化最后一个点坐标为起始点坐标

    % 遍历链式编码，根据编码更新最后一个点的坐标
    for i = 1:length(chain_code)
        direction = mod(chain_code(i), 8); % 取模运算，将链式编码映射到4个方向（0：右，1：上，2：左，3：下）
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
%         end_point
    end

    % 判断是否闭合
%     start_point
%     end_point
    d=sqrt(sum(sum((start_point-end_point).^2)));
    
    if(d>2)
        is_closed = 0;
    else
        is_closed = 1;
    end

    % 输出结果
    if is_closed
        disp('Chain code is closed.');
    else
        disp('Chain code is not closed.');

    end
end

