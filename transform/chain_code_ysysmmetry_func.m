% Copyright (c) 2023, IBCAS
% All rights reserved.

function[ysymmetry_chaincode] = chain_code_ysysmmetry_func(chaincode)
ysymmetry_chaincode = chaincode;
idx0 = chaincode==0;
idx1 = chaincode==1;
idx3 = chaincode==3;
idx4 = chaincode==4;
idx5 = chaincode==5;
idx7 = chaincode==7;
ysymmetry_chaincode(idx0) = 4;
ysymmetry_chaincode(idx1) = 3;
ysymmetry_chaincode(idx3) = 1;
ysymmetry_chaincode(idx4) = 0;
ysymmetry_chaincode(idx5) = 7;
ysymmetry_chaincode(idx7) = 5;