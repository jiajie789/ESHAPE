% Copyright (c), IBCAS@2023
% All rights reserved.

function [gray_en] = enhancement_func(graydata)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

gray_en = imadjust(graydata,[0.2;0.5],[0;1]);
end

