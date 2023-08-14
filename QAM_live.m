clear all
dlength = 512; % количество чисел в кадре данных
M = 64; % количество позиций модуляции
fs= 40; % чacтота сигнального сэмплирования
fm = 2; % частота радиосигнала
nf = 40; % частота обновления изображения
[dSig, bSig, mSig, tfield, dData, bData, btact, cNums] = Qframe(dlength, M, fs, fm);
tw = 16; % длина временного поля на графике
tfp = 0:1/fs:tw-1/fs; % разметка временного поля графика
sp = 1; % скорость обновления данных

F = uifigure('Name','Quadrature amplitude modulation', 'Position', [360 135 570 525],'Resize','off');

uilabel(F,"Text", string(M),'Position',[0 490 50 24],'FontSize', [20],'FontColor',[0 0.1 0.3], 'HorizontalAlignment', 'right','FontWeight','bold');
uilabel(F,"Text",'-QAM,','Position',[50 490 70 24],'FontSize', [20],'FontColor',[0 0.1 0.3],'FontWeight','bold');
uilabel(F,"Text",string(btact),'Position',[85 490 50 24],'FontSize', [20],'FontColor',[0 0.1 0.3], 'HorizontalAlignment', 'right','FontWeight','bold');
uilabel(F,"Text",'bits per symbol','Position',[138 490 150 24],'FontSize', [20],'FontColor',[0 0.1 0.3], 'HorizontalAlignment', 'left','FontWeight','bold');

dAx = uiaxes(F,'color', [62/256 95/256 138/256], 'GridColor', [1 1 1],'Position',[10 345 550 140]);
title(dAx,'Data in decimal form','FontWeight','bold','FontSize', [14], Color=[0 0.1 0.3]);
dNum = uilabel(F,"Text",'','Position',[40 330 90 22],'FontSize', [20],'FontColor',[0 0 1], 'HorizontalAlignment', 'left','FontWeight','bold');

bAx = uiaxes(F,'color', [62/256 95/256 138/256], 'GridColor', [1 1 1],'Position',[10 195 550 140]);
title(bAx,'Data in binary form','FontWeight','bold','FontSize', [14], Color=[0 0.1 0.3]);
bNum = uilabel(F,"Text",'','Position',[40 175 190 22],'FontSize', [20],'FontColor',[0 0 1], 'HorizontalAlignment', 'left','FontWeight','bold');

mAx = uiaxes(F,'color', [62/256 95/256 138/256], 'GridColor', [1 1 1],'Position',[10 40 550 140]);
title(mAx,'Modulated radio signal','FontWeight','bold','FontSize', [14], Color=[0 0.1 0.3]);
mNum = uilabel(F,"Text",'','Position',[40 20 190 22],'FontSize', [20],'FontColor',[0 0 1], 'HorizontalAlignment', 'left','FontWeight','bold');

dSigLive = plot(dAx, tfp, zeros(1, length(tfp)),LineWidth=1.3,Color=[0 1 0]);
axis(dAx,[0 tw-1/fs -0.1 1.1*max(dSig)]);
bSigLive = plot(bAx, tfp, zeros(1, length(tfp)),LineWidth=1.3,Color=[0 1 0]);
axis(bAx, [0 tw-1/fs -0.1 1.2]);
mSigLive = plot(mAx, tfp, zeros(1, length(tfp)),LineWidth=1.3,Color=[0 1 0]);
axis(mAx, [0 tw-1/fs -1.1*max(mSig) 1.1*max(mSig)]);

%scatterplot(cNums)
%title(string(M) + '-QAM complex plane')


ft=0; % счётчик сэмплов времени
fd=0; % счётчик символов данных
tStart=(double(convertTo(datetime('now'),"ntp")))/2^32; % текущее начальное время
while isvalid(F)
t=((double(convertTo(datetime('now'),"ntp")))/2^32-tStart); % текущее время, начиная с 0

if  ft < t*fs
   
   ft1=sp*ft+1;
   ft=ft+fs/nf;
   ft2=sp*ft;

if  ft > fd*fs*btact
    fd = fd+1;
dNum.Text = string(dData(fd));
bNum.Text = strjoin(string(uint8(bData(fd,:))));
mNum.Text = string(cNums(fd));

end

   dSigLive.YData(1:sp*fs/nf)=dSig(ft1:ft2);
   bSigLive.YData(1:sp*fs/nf)=bSig(ft1:ft2);
   mSigLive.YData(1:sp*fs/nf)=mSig(ft1:ft2);

for n = 1:sp:tw*nf-sp 

    dSigLive.YData(((tw*nf+1)*(fs/nf))-n*(fs/nf)-sp*fs/nf+1:((tw*nf+1)*(fs/nf))-n*(fs/nf)) = dSigLive.YData(((tw*nf+1)*(fs/nf))-n*(fs/nf)-2*sp*fs/nf+1:((tw*nf+1)*(fs/nf))-n*(fs/nf)-sp*fs/nf);
    bSigLive.YData(((tw*nf+1)*(fs/nf))-n*(fs/nf)-sp*fs/nf+1:((tw*nf+1)*(fs/nf))-n*(fs/nf)) = bSigLive.YData(((tw*nf+1)*(fs/nf))-n*(fs/nf)-2*sp*fs/nf+1:((tw*nf+1)*(fs/nf))-n*(fs/nf)-sp*fs/nf);
    mSigLive.YData(((tw*nf+1)*(fs/nf))-n*(fs/nf)-sp*fs/nf+1:((tw*nf+1)*(fs/nf))-n*(fs/nf)) = mSigLive.YData(((tw*nf+1)*(fs/nf))-n*(fs/nf)-2*sp*fs/nf+1:((tw*nf+1)*(fs/nf))-n*(fs/nf)-sp*fs/nf);

end

drawnow

end
 
if ft >= dlength*fs*btact
        close(F);
 end

end
