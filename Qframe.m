function [dSig, bSig, mSig, tfield, dData, bData, btact, cNums] = Qframe(dlength, M, fs, fm)
    [dData, bData, btact] = Dataframe(dlength, M);
    [tfield, bSig] = bSignal(dlength, fs, bData, btact);
    dSig = dSignal(tfield, dlength, fs, btact, dData);
    [Amp, Phi, cNums] = mData(dData, M);
    mSig = mSignal(tfield, dlength, fs, btact, Amp, Phi, fm);
end



