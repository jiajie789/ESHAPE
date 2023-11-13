% Copyright (c), IBCAS@2023
% All rights reserved.

function [im_contour] = contour_extraction_func(graydata,methodstr,threshvalue)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

im_contour = edge(graydata,methodstr,threshvalue);
end

