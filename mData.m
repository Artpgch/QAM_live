function [Amp, Phi, cNums] = mData(dData, M) % функция вычисления амплитуд и фаз модуляции
cNums = qammod(dData, M, 'UnitAveragePower', true); % вычисление комплексных чисел модуляции
Amp = abs(cNums); % вычисление амплитуд
Phi = angle(cNums); % вычисление фаз
end