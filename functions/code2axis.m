function [ axis ] = code2axis( chain_code,start_point )
%CODE2AXIS 此处显示有关此函数的摘要
%   此处显示详细说明
    % 获取起始点和最后一个点的坐标
%     start_point = [631, 40]; % 起始点坐标
    end_point = start_point; % 初始化最后一个点坐标为起始点坐标
    axis=zeros(length(chain_code)+1,2);
    axis(1,:)=start_point;
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
        axis(i+1,:)=end_point;
%         end_point
    end

end

