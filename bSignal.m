function [tfield, bSig] = bSignal(dlength, fs, bData, btact) % функция генерации кадра двоичных прямоугольных импульсов

fbData = flip(bData, 2);
tfield=0:1/fs:dlength*btact-1/fs; % разметка временного поля в значениях один бит на одну единицу времени
bSig=zeros(1,length(tfield));
k=0;
for i=1:dlength
    for j=1:btact
            k=k+1;

        switch fbData(i,j)
            case 0
                bSig(1+fs*(k-1):fs*k)=zeros(1,fs);
            case 1
                bSig(1+fs*(k-1):fs*k)=ones(1,fs);
        end

    end
end

bSig=logical(bSig);

end

