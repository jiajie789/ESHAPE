function [ area ,circumference] = cal_area_c( chain_code )
%CAL_AREA 此处显示有关此函数的摘要
%   此处显示详细说明
    coordinates=code2axis(chain_code,[0, 0]);    
%     disp(axis)

    %%计算面积
    % 找到曲线的边界框
    min_y = min(coordinates(:, 1));
    max_y = max(coordinates(:, 1));
    % 初始化面积计数器
    area = 0;
    % 遍历扫描线
    for y = min_y:max_y
        % 找到与扫描线相交的横坐标
        intersection_indices = find(coordinates(:, 1) == y);%满足条件的行号
        intersection_count = length(intersection_indices);  
        intersections = zeros(1, intersection_count);
        for i = 1:intersection_count
            index = intersection_indices(i);
            intersections(i) = coordinates(index, 2);%横坐标
        end
        intersections = sort(intersections);
        % 计算扫描线上的面积
        for i = 1:2:intersection_count-1
            area = area + (intersections(i+1) - intersections(i))+1;
        end
    end
    % 输出结果
    fprintf('area(pixel):%d\n', area);%results(1,:) =,{'area：pixel'},{'circumference：mm'},{'area：mm^2'}];
    circumference=0;
    for i=1:length(chain_code)
        % 判断奇数还是偶数
        if mod(chain_code(i), 2) == 0
            circumference=circumference+norm([1,0]);
        else
            circumference=circumference+norm([1,1]);
        end
    end
    % 输出结果
    fprintf('circumference(pixel):%d\n', circumference);
end

