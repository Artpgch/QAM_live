function [dSig, bSig, mSig, tfield, dData, bData, btact, cNums] = Qframe(dlength, M, fs, fm)
    [dData, bData, btact] = Dataframe(dlength, M); % обращение к функции генерации кадра данных
    [tfield, bSig] = bSignal(dlength, fs, bData, btact); % обращение к функции генерации кадра двоичных прямоугольных импульсов
    dSig = dSignal(tfield, dlength, fs, btact, dData); % обращение функции генерации кадра десятичных прямоугольных импульсов
    [Amp, Phi, cNums] = mData(dData, M); % обращение к функции вычисления амплитуд и фаз модуляции
    mSig = mSignal(tfield, dlength, fs, btact, Amp, Phi, fm); % обращение к функции генерации радиосигнала

end



