Fs = 44100; % частота дискретизации 
t = 0:1/Fs:5; % дискретное время 
f0 = 1000; % несущая частота, ми вторая октава
OMEGA = 1; % частота модулирующего сигнала 
phi0 = 0;
snr = 3;  
u_am = cos(2*pi*f0*t + phi0);
y = awgn(u_am,snr,'measured');

%multisig
oms = [2093.04 2349.28 2637.04 2093.04];
for i = 1:length(oms)
    mults =  cos(2*pi*oms(i)*t + phi0);
end
%sound(mults,Fs)

%dfs = Fs/length(y);
%freqs = -Fs/2:dfs:(Fs/2)-dfs;

%plot(t, y)
%spectr = fftshift(fft(y));

%plot(freqs,abs(spectr))
%sound(y,Fs)
%audiowrite('testsound.wav',y,Fs);

%h = actxcontrol('WMPlayer.OCX.7',[0 0 600 400],figure(2));
%set(h,'URL','testsound.wav');