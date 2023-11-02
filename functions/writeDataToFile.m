function writeDataToFile(data, filename)
    % 打开文本文件以写入数据
    fileID = fopen(filename, 'w');
    
    % 将数据按行写入文本文件
    for i = 1:size(data, 1)
        for n=1:size(data,2)
            fprintf(fileID, '%d ', data(i, n));
        end
        fprintf(fileID, '\n');
    end
    
    % 关闭文件
    fclose(fileID);
end
