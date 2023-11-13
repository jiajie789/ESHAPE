% Copyright (c), IBCAS@2023
% All rights reserved.

function [im_cor] = corrosion_func(imBina,circle)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

    se1=strel('disk',str2num(circle));%Create a flat disk structure element with a radius of 5
    im_cor=imerode(imBina,se1);
end

