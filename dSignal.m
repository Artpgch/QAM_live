function dSig = dSignal(tfield, dlength, fs, btact, dData) % функция генерации кадра десятичных прямоугольных импульсов
    dSig = uint8(zeros(1, length(tfield)));
    k=0;
    for i=1:dlength
        for j=1:fs*btact
                k=k+1;
                dSig(k)=uint8(dData(i));
        end
    end

end