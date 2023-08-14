function [mSig] = mSignal(tfield, dlength, fs, btact, Amp, Phi, fm) % функция генерации радиосигнала
    ampSig = zeros(1, length(tfield));
    phiSig = zeros(1, length(tfield));
    k=0;
    for i=1:dlength
        for j=1:fs*btact
                k=k+1;
                ampSig(k)=Amp(i);
                phiSig(k)=Phi(i);
        end
    end

    mSig = single(ampSig.*sin((2*pi.*(tfield-phiSig)).*fm));
end

