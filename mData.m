function [Amp, Phi, cNums] = mData(dData, M) 

  cNums = qammod(dData, M, 'UnitAveragePower', true); 
  Amp = abs(cNums); 
  Phi = angle(cNums); 

end
