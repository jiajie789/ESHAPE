function [ area ,circumference] = cal_area_c( chain_code )
%CAL_AREA �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    coordinates=code2axis(chain_code,[0, 0]);    
%     disp(axis)

    %%�������
    % �ҵ����ߵı߽��
    min_y = min(coordinates(:, 1));
    max_y = max(coordinates(:, 1));
    % ��ʼ�����������
    area = 0;
    % ����ɨ����
    for y = min_y:max_y
        % �ҵ���ɨ�����ཻ�ĺ�����
        intersection_indices = find(coordinates(:, 1) == y);%�����������к�
        intersection_count = length(intersection_indices);  
        intersections = zeros(1, intersection_count);
        for i = 1:intersection_count
            index = intersection_indices(i);
            intersections(i) = coordinates(index, 2);%������
        end
        intersections = sort(intersections);
        % ����ɨ�����ϵ����
        for i = 1:2:intersection_count-1
            area = area + (intersections(i+1) - intersections(i))+1;
        end
    end
    % ������
    fprintf('area(pixel):%d\n', area);%results(1,:) =,{'area��pixel'},{'circumference��mm'},{'area��mm^2'}];
    circumference=0;
    for i=1:length(chain_code)
        % �ж���������ż��
        if mod(chain_code(i), 2) == 0
            circumference=circumference+norm([1,0]);
        else
            circumference=circumference+norm([1,1]);
        end
    end
    % ������
    fprintf('circumference(pixel):%d\n', circumference);
end

