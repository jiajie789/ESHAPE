% Copyright (c), IBCAS@2023
% All rights reserved.
function writeDataToFile(data, filename)
    % Open a text file to write data
    fileID = fopen(filename, 'w');
    
    % Writes data to a text file by line
    for i = 1:size(data, 1)
        for n=1:size(data,2)
            fprintf(fileID, '%d ', data(i, n));
        end
        fprintf(fileID, '\n');
    end
    
    % close txt file
    fclose(fileID);
end
