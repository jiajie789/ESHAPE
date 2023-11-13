% Copyright (c), IBCAS@2023
% All rights reserved.

% Generat chain code based on binary image.
function[chain_code,oringin,endpoint] = gui_chain_code_func(axis_info,oringin_ori)
[nrow,ncol] = size(axis_info);
idxall = find(axis_info==1);
numoftotalpoints = numel(idxall);
disp(numoftotalpoints);
if nargin == 1
    randomval = randi(4);
    disp(['randomval: ',num2str(randomval)])
    if(randomval == 1)
        colidxst = fix(ncol/2);
        rowidxst = find(axis_info(1:fix(nrow/2),colidxst)==1, 1, 'last' );
        oringin_ori = [rowidxst, colidxst];
    end
    if(randomval == 2)
        colidxst = fix(ncol/2);
        rowidxst = fix(nrow/2) + find(axis_info(fix(nrow/2)+1:nrow,colidxst)==1, 1, 'first' );
        oringin_ori = [rowidxst, colidxst];
    end
    if(randomval == 3)
        rowidxst = fix(nrow/2);
        colidxst = find(axis_info(rowidxst,1:fix(ncol/2))==1, 1, 'last' );
        oringin_ori = [rowidxst, colidxst];
    end
    if(randomval == 4)
        rowidxst = fix(nrow/2);
        colidxst = fix(ncol/2) + find(axis_info(rowidxst,fix(ncol/2)+1:ncol)==1, 1, 'first' );
        oringin_ori = [rowidxst, colidxst];
    end
    % disp(num2str(axis_info(rowidxst,colidxst)));
end
if nargin == 2
    rowidxst = oringin_ori(1);
    colidxst = oringin_ori(2);
    oringin_ori = [rowidxst, colidxst];
end



flags = zeros(nrow,ncol);
contour_points = zeros(numoftotalpoints,2);
backword_points = zeros(numoftotalpoints,2);
backword_points_pre = zeros(numoftotalpoints,2);
chain_code_ori = zeros(1, numoftotalpoints);

numofpoints = 1;
contour_points(numofpoints,:) = [rowidxst, colidxst];%Æðµã
flags(rowidxst, colidxst) = 1;
numofbackword = 0;
numofbackword_pre = 0;
numofpoints_pre = 0;
backwordflag = 0;
while(numofpoints < numoftotalpoints)
    fatecount = 8;
    rowidxpre = contour_points(numofpoints,1);
    colidxpre = contour_points(numofpoints,2);
    
    rowidx = min(max(rowidxpre, 1),nrow);
    colidx = min(max(colidxpre + 1, 1),ncol);
    

    if((rowidx == rowidxst) && (colidx == colidxst) && (numofpoints > 2))
        numofpoints = numofpoints + 1;
        contour_points(numofpoints,:) = [rowidx, colidx];
        chain_code_ori(numofpoints - 1) = 0;
        break;
    end
    if(axis_info(rowidx,colidx)==1 && flags(rowidx, colidx)==0)
        numofpoints = numofpoints + 1;
        contour_points(numofpoints,:) = [rowidx, colidx];
        flags(rowidx, colidx) = 1;
        chain_code_ori(numofpoints - 1) = 0;

    else
        fatecount = fatecount - 1;
        rowidx = min(max(rowidxpre - 1, 1),nrow);
        colidx = min(max(colidxpre + 1, 1),ncol);
        if(rowidx == rowidxst && colidx == colidxst && numofpoints > 2)
            numofpoints = numofpoints + 1;
            contour_points(numofpoints,:) = [rowidx, colidx];
            chain_code_ori(numofpoints - 1) = 1;
            break;
        end
        if(axis_info(rowidx,colidx)==1 && flags(rowidx, colidx)==0)
            numofpoints = numofpoints + 1;
            contour_points(numofpoints,:) = [rowidx, colidx];
            flags(rowidx, colidx) = 1;
            chain_code_ori(numofpoints - 1) = 1;
%             continue;
        else
            fatecount = fatecount - 1;
            rowidx = min(max(rowidxpre - 1, 1),nrow);
            colidx = min(max(colidxpre, 1), ncol);
            if(rowidx == rowidxst && colidx == colidxst && numofpoints > 2)
                numofpoints = numofpoints + 1;
                contour_points(numofpoints,:) = [rowidx, colidx];
                chain_code_ori(numofpoints - 1) = 2;
                break;
            end
            if(axis_info(rowidx,colidx)==1 && flags(rowidx, colidx)==0)
                numofpoints = numofpoints + 1;
                contour_points(numofpoints,:) = [rowidx, colidx];
                flags(rowidx, colidx) = 1;
                chain_code_ori(numofpoints - 1) = 2;
%                 continue;
            else
                fatecount = fatecount - 1;
                rowidx = min(max(rowidxpre - 1, 1),nrow);
                colidx = min(max(colidxpre - 1, 1),ncol);
                if(rowidx == rowidxst && colidx == colidxst && numofpoints > 2)
                    numofpoints = numofpoints + 1;
                    contour_points(numofpoints,:) = [rowidx, colidx];
                    chain_code_ori(numofpoints - 1) = 3;
                    break;
                end
                if(axis_info(rowidx,colidx)==1 && flags(rowidx, colidx)==0)
                    numofpoints = numofpoints + 1;
                    contour_points(numofpoints,:) = [rowidx, colidx];
                    flags(rowidx, colidx) = 1;
                    chain_code_ori(numofpoints - 1) = 3;
%                     continue;
                else
                    fatecount = fatecount - 1;
                    rowidx = min(max(rowidxpre, 1),nrow);
                    colidx = min(max(colidxpre - 1, 1),ncol);
                    if(rowidx == rowidxst && colidx == colidxst && numofpoints > 2)
                        numofpoints = numofpoints + 1;
                        contour_points(numofpoints,:) = [rowidx, colidx];
                        chain_code_ori(numofpoints - 1) = 4;
                        break;
                    end
                    if(axis_info(rowidx,colidx)==1 && flags(rowidx, colidx)==0)
                        numofpoints = numofpoints + 1;
                        contour_points(numofpoints,:) = [rowidx, colidx];
                        flags(rowidx, colidx) = 1;
                        chain_code_ori(numofpoints - 1) = 4;
%                         continue;
                    else
                        fatecount = fatecount - 1;
                        rowidx = min(max(rowidxpre + 1, 1),nrow);
                        colidx = min(max(colidxpre - 1, 1),ncol);
                        if(rowidx == rowidxst && colidx == colidxst && numofpoints > 2)
                            numofpoints = numofpoints + 1;
                            contour_points(numofpoints,:) = [rowidx, colidx];
                            chain_code_ori(numofpoints - 1) = 5;
                            break;
                        end
                        if(axis_info(rowidx,colidx)==1 && flags(rowidx, colidx)==0)
                            numofpoints = numofpoints + 1;
                            contour_points(numofpoints,:) = [rowidx, colidx];
                            flags(rowidx, colidx) = 1;
                            chain_code_ori(numofpoints - 1) = 5;
%                             continue;
                        else
                            fatecount = fatecount - 1;
                            rowidx = min(max(rowidxpre + 1, 1),nrow);
                            colidx = min(max(colidxpre, 1),ncol);
                            if(rowidx == rowidxst && colidx == colidxst && numofpoints > 2)
                                numofpoints = numofpoints + 1;
                                contour_points(numofpoints,:) = [rowidx, colidx];
                                chain_code_ori(numofpoints - 1) = 6;
                                break;
                            end
                            if(axis_info(rowidx,colidx)==1 && flags(rowidx, colidx)==0)
                                numofpoints = numofpoints + 1;
                                contour_points(numofpoints,:) = [rowidx, colidx];
                                flags(rowidx, colidx) = 1;
                                chain_code_ori(numofpoints - 1) = 6;
%                                 continue;
                            else
                                fatecount = fatecount - 1;
                                rowidx = min(max(rowidxpre + 1, 1),nrow);
                                colidx = min(max(colidxpre + 1, 1),ncol);
                                if(rowidx == rowidxst && colidx == colidxst && numofpoints > 2)
                                    numofpoints = numofpoints + 1;
                                    contour_points(numofpoints,:) = [rowidx, colidx];
                                    chain_code_ori(numofpoints - 1) = 7;
                                    break;
                                end
                                if(axis_info(rowidx,colidx)==1 && flags(rowidx, colidx)==0)
                                    numofpoints = numofpoints + 1;
                                    contour_points(numofpoints,:) = [rowidx, colidx];
                                    flags(rowidx, colidx) = 1;
                                    chain_code_ori(numofpoints - 1) = 7;
%                                     continue;
                                else
                                    fatecount = fatecount - 1;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    if(fatecount == 0) 
        rowidxpre = contour_points(numofpoints,1);
        colidxpre = contour_points(numofpoints,2);
        axis_info(rowidxpre,colidxpre) = 0;
        if(numofbackword == 0 && numofpoints > numofpoints_pre)
            numofpoints_pre = numofpoints;
            backwordflag = 1;
        end
        numofpoints = numofpoints - 1;
        if(numofpoints < 1)
            break
        end
        numofbackword = numofbackword + 1;
        if(numofbackword > 20)
            break;
        else
            if(backwordflag == 1)
                backword_points(numofbackword,:) = [rowidxpre,colidxpre];
            end
        end
    else
        numofbackword = 0;
        backwordflag = 0;
    end
end

chain_code = chain_code_ori(1:numofpoints-1);
endpoint = backword_points(1,:);
oringin = oringin_ori;

