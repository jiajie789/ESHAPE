function[chain_code] = chain_code_func(axis_info,xidxst,yidxst,xidxed,yidxed)
idxall = find(axis_info==1);
[nrow,ncol] = size(axis_info);
numoftotalpoints = numel(idxall);
flags = false(nrow,ncol);
xidxpre = xidxst;
yidxpre = yidxst;
contour_points = zeros(numel(idxall),2);
numofpoints = 1;
flags(yidxst, xidxst) = 1;
contour_points(numofpoints,:) = [yidxst, xidxst];
chain_code = [];
oringin = [yidxst, xidxst];
while(numofpoints < numoftotalpoints)
    if(xidxst==xidxed && yidxst==yidxed)
        break
    end
    yidx = min(max(yidxst - 1, 1),nrow);
    xidx = min(max(xidxst, 1),ncol);
    if(axis_info(yidx,xidx)==1 && flags(yidx, xidx)==0)
        numofpoints = numofpoints + 1;
        contour_points(numofpoints,:) = [yidx, xidx];
        flags(yidx, xidx) = 1;
        yidxpre = yidxst;
        xidxpre = xidxst;
        yidxst = yidx;
        xidxst = xidx;
        chain_code = [chain_code, 2];
    else
        yidx = min(max(yidxst, 1),nrow);
        xidx = min(max(xidxst + 1, 1),ncol);
        if(axis_info(yidx,xidx)==1 && flags(yidx, xidx)==0)
            numofpoints = numofpoints + 1;
            contour_points(numofpoints,:) = [yidx, xidx];
            flags(yidx, xidx) = 1;
            yidxpre = yidxst;
            xidxpre = xidxst;
            yidxst = yidx;
            xidxst = xidx;
            chain_code = [chain_code, 0];
        else
            yidx = min(max(yidxst + 1, 1),nrow);
            xidx = min(max(xidxst, 1),ncol);
            if(axis_info(yidx,xidx)==1 && flags(yidx, xidx)==0)
                numofpoints = numofpoints + 1;
                contour_points(numofpoints,:) = [yidx, xidx];
                flags(yidx, xidx) = 1;
                yidxpre = yidxst;
                xidxpre = xidxst;
                yidxst = yidx;
                xidxst = xidx;
                chain_code = [chain_code, 6];
            else
                yidx = min(max(yidxst, 1),nrow);
                xidx = min(max(xidxst - 1, 1),ncol);
                if(axis_info(yidx,xidx)==1 && flags(yidx, xidx)==0)
                    numofpoints = numofpoints + 1;
                    contour_points(numofpoints,:) = [yidx, xidx];
                    flags(yidx, xidx) = 1;
                    yidxpre = yidxst;
                    xidxpre = xidxst;
                    yidxst = yidx;
                    xidxst = xidx;
                    chain_code = [chain_code, 4];
                else
                    yidx = min(max(yidxst + 1, 1),nrow);
                    xidx = min(max(xidxst + 1, 1),ncol);
                    if(axis_info(yidx,xidx)==1 && flags(yidx, xidx)==0)
                        numofpoints = numofpoints + 1;
                        contour_points(numofpoints,:) = [yidx, xidx];
                        flags(yidx, xidx) = 1;
                        yidxpre = yidxst;
                        xidxpre = xidxst;
                        yidxst = yidx;
                        xidxst = xidx;
                        chain_code = [chain_code, 7];
                    else
                        yidx = min(max(yidxst - 1, 1),nrow);
                        xidx = min(max(xidxst + 1, 1),ncol);
                        if(axis_info(yidx,xidx)==1 && flags(yidx, xidx)==0)
                            numofpoints = numofpoints + 1;
                            contour_points(numofpoints,:) = [yidx, xidx];
                            flags(yidx, xidx) = 1;
                            yidxpre = yidxst;
                            xidxpre = xidxst;
                            yidxst = yidx;
                            xidxst = xidx;
                            chain_code = [chain_code, 1];
                        else
                            yidx = min(max(yidxst + 1, 1),nrow);
                            xidx = min(max(xidxst - 1, 1),ncol);
                            if(axis_info(yidx,xidx)==1 && flags(yidx, xidx)==0)
                                numofpoints = numofpoints + 1;
                                contour_points(numofpoints,:) = [yidx, xidx];
                                flags(yidx, xidx) = 1;
                                yidxpre = yidxst;
                                xidxpre = xidxst;
                                yidxst = yidx;
                                xidxst = xidx;
                                chain_code = [chain_code, 5];
                            else
                                yidx = min(max(yidxst - 1, 1),nrow);
                                xidx = min(max(xidxst - 1, 1),ncol);
                                if(axis_info(yidx,xidx)==1 && flags(yidx, xidx)==0)
                                    numofpoints = numofpoints + 1;
                                    contour_points(numofpoints,:) = [yidx, xidx];
                                    flags(yidx, xidx) = 1;
                                    yidxpre = yidxst;
                                    xidxpre = xidxst;
                                    yidxst = yidx;
                                    xidxst = xidx;
                                    chain_code = [chain_code, 3];
                                else
                                    break;
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end