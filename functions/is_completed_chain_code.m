function is_closed  = is_completed_chain_code( chain_code,start_point )
%UNTITLED �˴���ʾ�йش˺�����ժҪ
%   �˴���ʾ��ϸ˵��
   % ������ʽ����
    % ��ȡ��ʼ������һ���������
%     start_point = [631, 40]; % ��ʼ������
    end_point = start_point; % ��ʼ�����һ��������Ϊ��ʼ������

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
%         end_point
    end

    % �ж��Ƿ�պ�
%     start_point
%     end_point
    d=sqrt(sum(sum((start_point-end_point).^2)));
    
    if(d>2)
        is_closed = 0;
    else
        is_closed = 1;
    end

    % ������
    if is_closed
        disp('Chain code is closed.');
    else
        disp('Chain code is not closed.');

    end
end

