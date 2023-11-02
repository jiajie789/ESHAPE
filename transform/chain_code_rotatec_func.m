function [rotated_chain_code] = chain_code_rotatec_func(axis)


    % 解码链式编码
    decoded_points = axis;

    % 顺时针旋转90度
    rotated_points = [decoded_points(:,2), -decoded_points(:,1)]; 


    % 编码逆时针旋转后的点坐标
    rotated_chain_code = axis2code(rotated_points);

    % 显示结果
%     disp('原始链式编码:');
%     disp(chain_code);
% 
%     disp('逆时针旋转后的链式编码:');
%     disp(rotated_chain_code);

end

