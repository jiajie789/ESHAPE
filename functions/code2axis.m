function [ axis ] = code2axis( chain_code,start_point )
%CODE2AXIS �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
    % ��ȡ��ʼ������һ���������
%     start_point = [631, 40]; % ��ʼ������
    end_point = start_point; % ��ʼ�����һ��������Ϊ��ʼ������
    axis=zeros(length(chain_code)+1,2);
    axis(1,:)=start_point;
    % ������ʽ���룬���ݱ���������һ���������
    for i = 1:length(chain_code)
        direction = mod(chain_code(i), 8); % ȡģ���㣬����ʽ����ӳ�䵽4������0���ң�1���ϣ�2����3���£�
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

