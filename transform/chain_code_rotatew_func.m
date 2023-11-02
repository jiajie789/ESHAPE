function [rotated_chain_code,rotated_points] = chain_code_rotatew_func(axis)


    % 解码链式编码
    
    % 计算旋转后的点坐标
    rotation_center = axis(1,:); % 以编码的起始点为中心
    rotated_points = rotate_points(axis, rotation_center, pi/2); % 逆时针旋转90度
%     rotated_points=round(rotated_points);


    % 逆时针旋转90度
%     rotated_points = [-decoded_points(:,2), decoded_points(:,1)];

    % 编码逆时针旋转后的点坐标
%     rotated_points=int8(rotated_points);
    rotated_points=round(rotated_points);
    rotated_chain_code = axis2code(rotated_points);

    % 显示结果
%     disp('原始链式编码:');
%     disp(chain_code);
% 
%     disp('逆时针旋转后的链式编码:');
%     disp(rotated_chain_code);

end

