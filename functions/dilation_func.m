% Copyright (c), IBCAS@2023
% All rights reserved.

function [im_dil] = dilation_func(imBina)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
B=[0 1 0
   1 1 1
   0 1 0];
im_dil=imdilate(imBina,B); 
end

