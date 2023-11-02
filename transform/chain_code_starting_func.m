function[starting_chaincode] = chain_code_starting_func(chaincode,point)
st = mod(point,numel(chaincode));
starting_chaincode = [chaincode(st+1:numel(chaincode)),chaincode(1:st)];