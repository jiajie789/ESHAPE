% Copyright (c) 2023, IBCAS
% All rights reserved.

function[chaincode] = chain_code_reverse_func(chaincode)
chaincode = mod(flipud(chaincode')'+4,8);