function [decData, binData, btact] = Dataframe(dlength, M)

btact=log2(M); 
decData = randi([0 M-1],dlength,1);
stBin=dec2bin(decData,btact);
binData=zeros(dlength,btact);
for p=1:dlength
    for q=1:btact
         binData(p,q)=str2double(stBin(p,q));
    end
end
binData=logical(binData);

end
