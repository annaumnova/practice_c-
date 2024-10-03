Fs = 10000; % частота дискретизации 
t = 0:1/Fs:10; % дискретное время 
omega0 = 660; % несущая частота, ми вторая октава
OMEGA = 1; % частота модулирующего сигнала 
phi0 = 0;
snr = 0; 
u_am = cos(2*pi*omega0*t + phi0);
y = awgn(u_am,snr,'measured');
s = u_am + y;
%figure(1)
%plot(t, s)
%sound(s,Fs)
audiowrite('testsound.wav',s,Fs);

h = actxcontrol('WMPlayer.OCX.7',[0 0 600 400],figure(2));
set(h,'URL','testsound.wav');