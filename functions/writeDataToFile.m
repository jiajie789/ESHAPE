function writeDataToFile(data, filename)
    % ���ı��ļ���д������
    fileID = fopen(filename, 'w');
    
    % �����ݰ���д���ı��ļ�
    for i = 1:size(data, 1)
        for n=1:size(data,2)
            fprintf(fileID, '%d ', data(i, n));
        end
        fprintf(fileID, '\n');
    end
    
    % �ر��ļ�
    fclose(fileID);
end
